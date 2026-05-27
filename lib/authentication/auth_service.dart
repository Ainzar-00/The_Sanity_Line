import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_result.dart';
import '../api/profile_api_service.dart';
import '../api/user_api_service.dart';
import '../models/user_model.dart';
import '../models/provider_enum.dart';

// ── AuthService ───────────────────────────────────────────────────────────────
// Pure business logic — no BuildContext, no Navigator, no UI widgets.
// Every method returns an [AuthResult] so the calling screen only needs to
// inspect .success / .errorMessage / .route.

class AuthService {
  // ── Profile-based route resolution ────────────────────────────────────────
  // Three possible outcomes:
  //   local flag set              → /home  (fastest, offline-safe)
  //   API returns null (404)      → /assessment (user has no profile yet)
  //   API throws (network error)  → /home  (safe fallback — returning users
  //                                          bypass assessment; new users
  //                                          always come from signUp() which
  //                                          routes to /assessment directly)
  static Future<AuthResult> _resolveRoute(String uid) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Fast-path: local flag already set.
    if (prefs.getBool('onboarding_done_$uid') ?? false) {
      return AuthResult.ok(route: '/home', routeArguments: uid);
    }

    // 2. Ask the API — but only trust it when reachable.
    try {
      final profile = await ProfileApiService.getProfileByUserId(uid);
      if (profile != null && profile.onboardingCompletedAt != null) {
        // Onboarding is complete — cache locally for future logins.
        await prefs.setBool('onboarding_done_$uid', true);
        return AuthResult.ok(route: '/home', routeArguments: uid);
      }
      // profile == null means HTTP 404: user genuinely has no profile yet.
      return AuthResult.ok(route: '/assessment', routeArguments: uid);
    } catch (_) {
      // Network/server error — we cannot determine status.
      // Defaulting to /home avoids re-showing assessment to returning users.
      // Brand-new users always pass through signUp() which hardcodes /assessment.
      return AuthResult.ok(route: '/home', routeArguments: uid);
    }
  }

  AuthService._(); // not instantiable — use static methods

  // ── Email / password login ─────────────────────────────────────────────────

  static Future<AuthResult> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);

      // Update last seen in backend
      await UserApiService.updateLastSeen(credential.user!.uid);

      return _resolveRoute(credential.user!.uid);
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
    String confirmPassword,
  ) async {
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);

      // Sync user to backend
      final userModel = UserModel(
        userId: credential.user!.uid,
        email: email.trim(),
        displayName: name.trim(),
        provider: Provider.email,
      );
      await UserApiService.createUser(userModel);

      // New user always needs onboarding
      return AuthResult.ok(route: '/assessment', routeArguments: credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(mapFirebaseError(e.code));
    } catch (_) {
      return AuthResult.error('Something went wrong. Please try again.');
    }
  }

  // ── Google sign-in ─────────────────────────────────────────────────────────

  static Future<AuthResult> signInWithGoogle() async {
    // ⚠️ Replace with your Web OAuth 2.0 client ID from Firebase Console →
    // Authentication → Sign-in method → Google → Web SDK configuration
    const webClientId =
        '1013286477109-fdcvg7bbovm9a87onlirdepj6e5eo6k4.apps.googleusercontent.com';

    try {
      final googleSignIn = GoogleSignIn(
        // Required for Flutter Web
        clientId: webClientId,
        // Required for Android to get a valid idToken for Firebase
        serverClientId: webClientId,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the flow — not an error, just abort
        return AuthResult.error('');
      }
      final googleAuth = await googleUser.authentication;
      final oauthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final credential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);

      // Ensure user exists in backend and update last seen
      final existingUser = await UserApiService.getUser(credential.user!.uid);
      if (existingUser == null) {
        final userModel = UserModel(
          userId: credential.user!.uid,
          email: credential.user!.email,
          displayName: credential.user!.displayName,
          photoUrl: credential.user!.photoURL,
          provider: Provider.google,
        );
        await UserApiService.createUser(userModel);
      } else {
        await UserApiService.updateLastSeen(credential.user!.uid);
      }

      return _resolveRoute(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(mapFirebaseError(e.code));
    } catch (e) {
      // In debug, surface the real error to help diagnose config issues.
      assert(() {
        // ignore: avoid_print
        print('[AuthService] Google sign-in exception: $e');
        return true;
      }());
      return AuthResult.error('Google sign-in failed. Please try again.');
    }
  }

  // ── Session check (used by SplashScreen) ──────────────────────────────────
  // Returns AuthResult with the destination route, or null if not logged in.

  static Future<AuthResult?> checkCurrentUser() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // Update last seen whenever checking auth successfully
    await UserApiService.updateLastSeen(user.uid);

    // Resolve route based on onboarding state
    return _resolveRoute(user.uid);
  }

  // ── Logout ─────────────────────────────────────────────────────────────────

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
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
