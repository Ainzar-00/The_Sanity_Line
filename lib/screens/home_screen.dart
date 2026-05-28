import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth_service.dart';
import '../api/meal_log_api_service.dart';
import '../api/morning_checkin_api_service.dart';
import '../models/morning_checkin_model.dart';
import '../widgets/character_chat_bubble.dart';
import '../widgets/morning_checkin_dialog.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;
  const HomeScreen({super.key, this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Show professor welcome after first frame so Overlay is ready
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _maybeShowProfessorWelcome();
      // Morning check-in runs after welcome (so they don't overlap)
      _maybeShowMorningCheckin();
    });
  }

  Future<void> _maybeShowProfessorWelcome() async {
    if (!mounted) return;
    final uid = widget.userId;
    if (uid == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = 'prof_welcome_seen_$uid';
    if (prefs.getBool(key) ?? false) return; // Already seen — skip

    if (!mounted) return;

    // Use a Completer so we can await dismissal before showing check-in
    // ignore: use_build_context_synchronously — context is used inside a
    // synchronous closure, not after an await gap; the mounted guard above covers it.
    final dismissed = Future<void>(() {
      final completer = _WelcomeCompleter();
      CharacterChatBubble.show(
        context: context,
        characterName: 'THE PROFESSOR',
        steps: const [
          ChatStep(
            imagePath: 'assets/chatPersonas/professorExplaining.png',
            text:
                "Welcome to your dashboard! 🎉 As I mentioned, The Sanity Line is built around six pillars of health: Nutrition, Sleep, Physical Activity, Social Connections, Mind & Body, and Avoiding Harmful Substances.",
          ),
          ChatStep(
            imagePath: 'assets/chatPersonas/professorExplaining.png',
            text:
                "Each pillar is backed by science and tailored to your profile. Tap any of them to begin exploring — and I'll be right here to guide you along the way. Your journey starts now! 🚀",
          ),
        ],
        onDismiss: () async {
          final p = await SharedPreferences.getInstance();
          await p.setBool(key, true);
          completer.complete();
        },
      );
      return completer.future;
    });
    await dismissed;
  }

  // ── Morning check-in trigger ──────────────────────────────────────────────

  Future<void> _maybeShowMorningCheckin() async {
    print('[MorningCheckin] Checking conditions...');
    if (!mounted) return;
    final uid = widget.userId;
    if (uid == null) {
      print('[MorningCheckin] Skipped: userId is null');
      return;
    }

    // 1. Time gate — only at or after 7 AM
    final now = DateTime.now();
    if (now.hour < 7) {
      print('[MorningCheckin] Skipped: It is ${now.hour}:00, which is before 7 AM');
      return;
    }

    // 2. Already done today? (date-scoped key resets automatically each day)
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final prefs = await SharedPreferences.getInstance();
    final doneKey = 'checkin_done_${uid}_$today';
    if (prefs.getBool(doneKey) ?? false) {
      print('[MorningCheckin] Skipped: checkin_done locally is true for today');
      return;
    }

    // 3. No meal log today (user hasn't eaten yet)
    final hasMeal = await MealLogApiService.hasMealLogToday(uid);
    if (hasMeal) {
      print('[MorningCheckin] Skipped: User already has a meal log for today');
      return;
    }

    // 4. Server-side guard (handles reinstalls / multi-device)
    final serverHasOne = await MorningCheckinApiService.hasCheckinToday(uid);
    if (serverHasOne) {
      print('[MorningCheckin] Skipped: Server says checkin already exists for today');
      await prefs.setBool(doneKey, true); // sync local state
      return;
    }

    if (!mounted) return;

    print('[MorningCheckin] All conditions passed! Showing dialog.');

    MorningCheckinDialog.show(
      context: context,
      userId: uid,
      onComplete: (MorningCheckinModel checkin) async {
        // Mark done locally immediately (resilient to API failure)
        await prefs.setBool(doneKey, true);
        // Submit to backend
        await MorningCheckinApiService.submitCheckin(checkin);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      appBar: AppBar(
        title: const Text('The Sanity Line'),
        backgroundColor: const Color(0xFF1C5F5F),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1C5F5F)),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                await AuthService.logout();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Row 1: Nutrition | Sleep
            Row(
              children: [
                Expanded(
                  child: WellnessNode(
                    label: 'Nutrition',
                    imagePath: 'assets/nutrition_img.png',
                    color: const Color(0xFF5AAD6F),
                    glowColor: const Color(0xFFC8EDCC),
                    onTap: () => Navigator.pushNamed(context, '/nutrition'),
                  ),
                ),
                Expanded(
                  child: WellnessNode(
                    label: 'Sleep',
                    imagePath: 'assets/sleep_img.png',
                    color: const Color(0xFF4A7CC7),
                    glowColor: const Color(0xFFBDD4F5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Row 2: Social Connections | Physical Activity
            Row(
              children: [
                Expanded(
                  child: WellnessNode(
                    label: 'Social\nConnections',
                    imagePath: 'assets/social_connections.png',
                    color: const Color(0xFFD94F7A),
                    glowColor: const Color(0xFFF5BDD0),
                    imageSize: 70,
                  ),
                ),
                Expanded(
                  child: WellnessNode(
                    label: 'Physical\nActivity',
                    imagePath: 'assets/physicalActivity_img.png',
                    color: const Color(0xFFD47A1A),
                    glowColor: const Color(0xFFF5DBA0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Row 3: Mind & Body | Avoiding Harmful Substances
            Row(
              children: [
                Expanded(
                  child: WellnessNode(
                    label: 'Mind &\nBody',
                    imagePath: 'assets/mind&body.png',
                    color: const Color(0xFF4AADAA),
                    glowColor: const Color(0xFFB0E4E2),
                    imageSize: 70,
                  ),
                ),
                Expanded(
                  child: WellnessNode(
                    label: 'Avoiding\nHarmful\nSubstances',
                    imagePath: 'assets/AvoidingHarmfulSubstances.png',
                    color: const Color(0xFF6A5ABF),
                    glowColor: const Color(0xFFCFC8F0),
                    imageSize: 55,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WellnessNode extends StatelessWidget {
  final String label;
  final String imagePath;
  final Color color;
  final Color glowColor;
  final double imageSize;
  final VoidCallback? onTap;

  const WellnessNode({
    super.key,
    required this.label,
    required this.imagePath,
    required this.color,
    required this.glowColor,
    this.imageSize = 65,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  glowColor.withValues(alpha: 0.90),
                  glowColor.withValues(alpha: 0.55),
                  glowColor.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.65, 1.0],
              ),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontStyle: FontStyle.italic,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C5F5F),
              height: 1.3,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper: makes CharacterChatBubble awaitable ──────────────────────────────
// dart:async Completer bridges the callback-based onDismiss to a Future.

class _WelcomeCompleter {
  final _c = Completer<void>();
  Future<void> get future => _c.future;
  void complete() => _c.complete();
}
