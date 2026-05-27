import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth_service.dart';
import '../widgets/character_chat_bubble.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowProfessorWelcome();
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

    CharacterChatBubble.show(
      context: context,
      characterName: 'THE PROFESSOR',
      steps: const [
        // Completing the app introduction started during assessment
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
                  glowColor.withOpacity(0.90),
                  glowColor.withOpacity(0.55),
                  glowColor.withOpacity(0.0),
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
