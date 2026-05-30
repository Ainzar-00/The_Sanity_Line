import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_result.dart';
import '../api/user_api_service.dart';
import '../api/profile_api_service.dart';
import '../models/user_model.dart';
import '../models/provider_enum.dart' as provider_enum;
import '../providers/onboarding_provider.dart';

// ── AuthService ───────────────────────────────────────────────────────────────
// Pure business logic — no BuildContext, no Navigator, no UI widgets.
// Every method returns an [AuthResult] so the calling screen only needs to
// inspect .success / .errorMessage / .route.

class AuthService {
  AuthService._(); // not instantiable — use static methods

  static final _googleSignIn = GoogleSignIn(
    clientId:
        '1013286477109-fdcvg7bbovm9a87onlirdepj6e5eo6k4.apps.googleusercontent.com',
    serverClientId:
        '1013286477109-fdcvg7bbovm9a87onlirdepj6e5eo6k4.apps.googleusercontent.com',
  );

  // ── Email / password login ─────────────────────────────────────────────────

  static Future<AuthResult> login(
    String email,
    String password, {
    WidgetRef? ref,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Account exists in Firebase — save UID and proceed
      final prefs = await SharedPreferences.getInstance();
      final uid = credential.user!.uid;
      await prefs.setString('uid', uid);
      await UserApiService.updateLastSeen(uid);
      if (ref != null) await _restoreOnboarding(uid, ref);

      return AuthResult.ok(route: '/home', routeArguments: uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(mapFirebaseError(e.code));
    } catch (_) {
      return AuthResult.error('Something went wrong. Please try again.');
    }
  }

  // ── Email / password sign-up ───────────────────────────────────────────────

  static Future<AuthResult> signUp(
    String name,
    String email,
    String password,
    String confirmPassword, {
    WidgetRef? ref,
  }) async {
    if (password.trim() != confirmPassword.trim()) {
      return AuthResult.error('Passwords do not match.');
    }
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      await credential.user!.updateDisplayName(name.trim());

      final userModel = UserModel(
        userId: credential.user!.uid,
        email: email.trim(),
        displayName: name.trim(),
        provider: provider_enum.Provider.email,
      );
      await UserApiService.createUser(userModel);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);

      // New user — no onboarding completed yet, notifier stays empty
      return AuthResult.ok(route: '/assessment', routeArguments: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(mapFirebaseError(e.code));
    } catch (_) {
      return AuthResult.error('Something went wrong. Please try again.');
    }
  }

  // ── Google sign-in ─────────────────────────────────────────────────────────

  static Future<AuthResult> signInWithGoogle({
    required bool isLogin,
    WidgetRef? ref,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return AuthResult.error('');

      final googleAuth = await googleUser.authentication;
      final oauthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final credential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );

      final uid = credential.user!.uid;
      // Firebase tells us clearly whether this UID existed before this call
      final accountExistsInFirebase =
          credential.additionalUserInfo?.isNewUser == false;

      // ── Login ─────────────────────────────────────────────────────────────
      if (isLogin) {
        if (!accountExistsInFirebase) {
          // UID does not exist in Firebase — clean up and block login
          try { await credential.user?.delete(); } catch (_) {}
          await _googleSignIn.signOut();
          return AuthResult.error('No account found. Please sign up first.');
        }

        // UID exists — save it and go home
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', uid);
        await UserApiService.updateLastSeen(uid);
        if (ref != null) await _restoreOnboarding(uid, ref);
        return AuthResult.ok(route: '/home', routeArguments: uid);
      }

      // ── Sign-up ───────────────────────────────────────────────────────────
      if (accountExistsInFirebase) {
        // UID already exists — just log them in
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', uid);
        await UserApiService.updateLastSeen(uid);
        if (ref != null) await _restoreOnboarding(uid, ref);
        return AuthResult.ok(route: '/home', routeArguments: uid);
      }

      // New UID — create profile and send to onboarding
      final userModel = UserModel(
        userId: uid,
        email: credential.user!.email,
        displayName: credential.user!.displayName,
        photoUrl: credential.user!.photoURL,
        provider: provider_enum.Provider.google,
      );
      await UserApiService.createUser(userModel);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', uid);
      return AuthResult.ok(route: '/assessment', routeArguments: uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(mapFirebaseError(e.code));
    } catch (e) {
      assert(() {
        // ignore: avoid_print
        print('[AuthService] Google sign-in exception: $e');
        return true;
      }());
      return AuthResult.error('Google sign-in failed. Please try again.');
    }
  }

  // ── Session check (used by SplashScreen) ──────────────────────────────────

  static Future<AuthResult?> checkCurrentUser({WidgetRef? ref}) async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    await UserApiService.updateLastSeen(user.uid);
    if (ref != null) await _restoreOnboarding(user.uid, ref);
    return AuthResult.ok(route: '/home', routeArguments: user.uid);
  }

  // ── Logout ─────────────────────────────────────────────────────────────────

  static Future<void> logout() async {
    // Remove UID and onboarding progress from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await OnboardingNotifier.clearPrefs();
    // Sign out from Google and Firebase
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  // ── Onboarding restoration ─────────────────────────────────────────────────
  // Called after every successful login / session check.
  // 1. Try SharedPreferences first (fast path).
  // 2. If missing, fetch finishedOnboarding from the server and cache locally.

  static Future<void> _restoreOnboarding(String uid, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('onboarding_finished_pillars');
    final notifier = ref.read(onboardingProvider.notifier);

    if (raw != null && raw.isNotEmpty) {
      await notifier.loadFromPrefs();
    } else {
      // Not cached — fetch from server and cache
      final pillars = await ProfileApiService.getFinishedPillars(uid);
      await notifier.loadFromServer(pillars);
    }
  }

  // ── Error mapping ──────────────────────────────────────────────────────────

  static String mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}