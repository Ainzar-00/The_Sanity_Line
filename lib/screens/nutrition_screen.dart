import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/character_chat_bubble.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _selectedIndex = 0;
  bool _drLindaShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDrLindaBubble();
    });
  }

  void _showDrLindaBubble() async {
    if (!mounted || _drLindaShown) return;
    
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool('dr_linda_nutrition_intro_shown') ?? false;
    
    if (hasShown) return;
    
    _drLindaShown = true;
    await prefs.setBool('dr_linda_nutrition_intro_shown', true);
    
    if (!mounted) return;
    CharacterChatBubble.show(
      context: context,
      characterName: 'DR. LINDA',
      accentColor: const Color(0xFF4aabab), // Greenish theme
      steps: const [
        ChatStep(
          imagePath: 'assets/chatPersonas/dr_LindaWaving.png',
          text: "Hello! I'm Dr. Linda. I will be your guide for all things nutrition and gut health! 👋",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: _selectedIndex == 0
          ? const _DashboardTab()
          : const _MealsTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFF1C5F5F),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Georgia',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/dashboard.png', width: 48, height: 48,
                color: Colors.grey),
            activeIcon: Image.asset('assets/dashboard.png', width: 48, height: 48,
                color: const Color(0xFF1C5F5F)),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/meals.png', width: 48, height: 48,
                color: Colors.grey),
            activeIcon: Image.asset('assets/meals.png', width: 48, height: 48,
                color: const Color(0xFF1C5F5F)),
            label: 'Meals',
          ),
        ],
      ),
    );
  }
}

// ── Dashboard Tab ─────────────────────────────────────────────────────────────

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Text(
          'Daily Dashboard',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C5F5F),
          ),
        ),
      ),
    );
  }
}

// ── Meals Tab ─────────────────────────────────────────────────────────────────

class _MealsTab extends StatelessWidget {
  const _MealsTab();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
