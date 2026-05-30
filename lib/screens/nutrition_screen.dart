import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;

import '../api/profile_api_service.dart';
import '../api/meal_log_api_service.dart';
import '../api/daily_nutrient_totals_api_service.dart';
import '../database/app_database.dart';
import '../providers/database_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/character_chat_bubble.dart';
import '../widgets/spotlight_tutorial.dart';
import '../models/nutrition_targets.dart';
import '../models/ai_meal_response_model.dart';
import '../services/nutrient_target_service.dart';
import '../services/plant_species_service.dart';
import '../services/gemini_service.dart';
import '../services/midnight_reset_service.dart';


// ── NutritionScreen ───────────────────────────────────────────────────────────

class NutritionScreen extends ConsumerStatefulWidget {
  const NutritionScreen({super.key});

  @override
  ConsumerState<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends ConsumerState<NutritionScreen> {
  int _selectedIndex = 0;
  bool _drLindaShown = false;
  bool _showTutorialDummyMeal = false;

  final GlobalKey _plantsKey = GlobalKey();
  final GlobalKey _fermentedKey = GlobalKey();
  final GlobalKey _fiberKey = GlobalKey();
  final GlobalKey _omega3Key = GlobalKey();
  final GlobalKey _magnesiumKey = GlobalKey();
  final GlobalKey _tryptophanKey = GlobalKey();
  final GlobalKey _mealsTabKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();
  final GlobalKey _mealsListKey = GlobalKey();
  final GlobalKey _sourceDialogKey = GlobalKey();

  /// Mutable targets — can be adjusted without touching the DB schema.
  NutritionTargets _targets = const NutritionTargets();

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDrLindaBubble();
      _ensureTodayRow();
    });
  }

  void _ensureTodayRow() async {
    final db = ref.read(dbProvider);
    final today = DateTime.now().toIso8601String().split('T').first;
    final row = await db.dailyNutrientTotalsDao.getTotalsForDate(_userId, today);
    if (row == null) {
      // Midnight reset was missed (app killed). Run it now.
      await MidnightResetService.runReset(_userId, db);
    }
  }

  void _showDrLindaBubble() async {
    if (!mounted || _drLindaShown) return;

    // Skip if the professor's intro (app_intro) OR the full nutrition
    // onboarding has already been completed.
    final finished = ref.read(onboardingProvider);
    if (finished.contains(OnboardingPillars.appIntro)) return;
    if (finished.contains(OnboardingPillars.nutrition)) return;

    final prefs = await SharedPreferences.getInstance();
    final hasShown =
        prefs.getBool('dr_linda_nutrition_intro_shown') ?? false;
    if (hasShown) return;

    _drLindaShown = true;
    if (!mounted) return;

    CharacterChatBubble.show(
      context: context,
      characterName: 'DR. LINDA',
      accentColor: const Color(0xFF4C8C6A),
      steps: const [
        ChatStep(
          imagePath: 'assets/chatPersonas/dr_LindaWaving.png',
          text:
              "Hello! I’m Dr. Linda, your guide to better nutrition and a healthier gut. Let’s take this journey together 👋",
        ),
        ChatStep(
          imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
          text:
              "Your body is full of hidden connections that shape how you feel every day.\n\nYour gut does more than digest food—it plays a key role in your mood, energy, and overall mental well-being.\n\nBy understanding and supporting this connection, we can help your body and mind work in better harmony.",
        ),
      ],
      onDismiss: _onBubbleDismissed,
    );
  }

  /// Called after the intro bubble is dismissed — patches app_intro then starts the tour.
  void _onBubbleDismissed() async {
    // Patch app_intro pillar
    final notifier = ref.read(onboardingProvider.notifier);
    await notifier.complete(OnboardingPillars.appIntro);
    final completed = ref.read(onboardingProvider);

    await ProfileApiService.updateOnboardingProgress(
      _userId,
      completed,
      isLast: false,
    );

    if (!mounted) return;
    _startOnboardingTour();
  }

  void _startOnboardingTour() {
    SpotlightTutorial.show(context, [
      TutorialStep(
        targetKey: _plantsKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png', // Fallback to advising if this doesn't exist
        text: 'This tracks the variety of plants you eat. The more diverse, the happier your gut microbiome!',
      ),
      TutorialStep(
        targetKey: _fermentedKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Fermented foods introduce beneficial probiotics to your gut.',
      ),
      TutorialStep(
        targetKey: _fiberKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Fiber is the fuel for your good bacteria.',
      ),
      TutorialStep(
        targetKey: _omega3Key,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Omega-3 fatty acids are essential for reducing inflammation and supporting brain health.',
      ),
      TutorialStep(
        targetKey: _magnesiumKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Magnesium helps regulate your nervous system and improves sleep quality.',
      ),
      TutorialStep(
        targetKey: _tryptophanKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Tryptophan is an amino acid your body uses to produce serotonin, the "happy chemical".',
      ),
      TutorialStep(
        targetKey: _mealsTabKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Now, let\'s move over to the Meals section to see how you can log your food.',
        onComplete: () async {
          setState(() => _selectedIndex = 1);
        },
      ),
      TutorialStep(
        targetKey: _mealsListKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Here is where your logged and suggested meals live. It\'s your food diary!',
        onStart: () async {
          // Ensure no dummy meal is visible during the list-intro step
          setState(() {
            _selectedIndex = 1;
            _showTutorialDummyMeal = false;
          });
          await Future.delayed(const Duration(milliseconds: 300));
        },
        onComplete: () async {},
      ),
      TutorialStep(
        targetKey: _fabKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Tap this button anytime to log a new meal.',
      ),
      TutorialStep(
        targetKey: _sourceDialogKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'You can choose to log one of my AI-powered suggestions, or log a custom meal yourself!',
        onStart: () async {
          _showMealSourceDialog(isTutorial: true);
        },
        onComplete: () async {
          if (mounted) Navigator.pop(context);
        },
      ),
      TutorialStep(
        targetKey: _mealsListKey,
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'After adding a meal, this is how it will be displayed in your list.',
        onStart: () async {
          setState(() => _showTutorialDummyMeal = true);
          // Give the widget tree time to rebuild and show the dummy card
          await Future.delayed(const Duration(milliseconds: 500));
        },
        onComplete: () async {
          // Keep dummy visible through the details step — turned off in that step's onComplete
        },
      ),
      TutorialStep(
        // No targetKey — the dialog is in a separate overlay so we can't
        // spotlight it by key. A centered bubble works best here.
        imagePath: 'assets/chatPersonas/dr_LindaAdvising.png',
        text: 'Tapping on a meal brings up this detailed card. It breaks down exactly what nutrients you got from it!',
        onStart: () async {
          final dummyMeal = Meal(
            mealId: 'dummy',
            userId: _userId,
            mealName: 'Avocado Toast',
            plantSpeciesCount: 2,
            fermentedServings: 1.0,
            prebioticFiberG: 8.0,
            omega3G: 450,
            magnesiumMg: 60,
            tryptophanMg: 100,
            isSynced: false,
          );
          _showMealDetailsDialog(context, dummyMeal);
          // Wait for the dialog to render before the spotlight redraws
          await Future.delayed(const Duration(milliseconds: 300));
        },
        onComplete: () async {
          // Close the details dialog and hide the dummy meal
          if (mounted) Navigator.pop(context);
          setState(() => _showTutorialDummyMeal = false);
        },
      ),
      TutorialStep(
        imagePath: 'assets/chatPersonas/dr_LindaWaving.png',
        text: 'That\'s all for now! You are ready to start supporting your gut-brain connection.',
        onComplete: () async {
          await _completeNutritionOnboarding();
        },
      ),
    ]);
  }

  /// Called when the user finishes the nutrition onboarding tutorial.
  /// PATCHes the server, updates SharedPreferences, then navigates to /home.
  Future<void> _completeNutritionOnboarding() async {
    const pillar = OnboardingPillars.nutrition;
    final notifier = ref.read(onboardingProvider.notifier);
    await notifier.complete(pillar);
    final completed = ref.read(onboardingProvider);
    final isLast = OnboardingPillars.isLast(pillar);

    final success = await ProfileApiService.updateOnboardingProgress(
      _userId,
      completed,
      isLast: isLast,
    );

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to save progress. Please try again.'),
          backgroundColor: const Color(0xFF4C8C6A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      // Roll back state so the user can retry from the last step
      await notifier.rollback(pillar);
      return;
    }

    // Mark the Dr. Linda bubble as already seen so it never re-shows
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dr_linda_nutrition_intro_shown', true);

    if (!mounted) return;
    final nextRoute = OnboardingPillars.routeAfter(pillar) ?? '/home';
    Navigator.pushReplacementNamed(context, nextRoute,
        arguments: _userId);
  }

  void _showMealSourceDialog({bool isTutorial = false}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          key: isTutorial ? _sourceDialogKey : null,
          backgroundColor: const Color(0xFFEDF4E7),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'How would you like to log?',
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Color(0xFF1C5F5F),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSourceCard(
                icon: Icons.auto_awesome,
                title: "Dr. Linda's Suggestion",
                subtitle: 'Log a meal recommended for you',
                onTap: () {
                  Navigator.pop(ctx);
                  // TODO: Handle Dr. Linda's suggestion
                },
              ),
              const SizedBox(height: 12),
              _buildSourceCard(
                icon: Icons.restaurant_menu,
                title: 'Your meal',
                subtitle: 'Log a meal you created',
                onTap: () {
                  Navigator.pop(ctx);
                  _showLogMealSheet();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFDDE8D0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFC3D3AE)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF4C8C6A).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF4C8C6A), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C5F5F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4C7A5A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogMealSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _OwnMealFlowSheet(userId: _userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC3D3AE),
      body: _selectedIndex == 0
          ? _DashboardTab(
              userId: _userId,
              targets: _targets,
              plantsKey: _plantsKey,
              fermentedKey: _fermentedKey,
              fiberKey: _fiberKey,
              omega3Key: _omega3Key,
              magnesiumKey: _magnesiumKey,
              tryptophanKey: _tryptophanKey,
            )
          : _MealsTab(
              userId: _userId,
              mealsListKey: _mealsListKey,
              showDummyMeal: _showTutorialDummyMeal,
            ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              key: _fabKey,
              onPressed: _showMealSourceDialog,
              backgroundColor: const Color(0xFF4C8C6A),
              foregroundColor: Colors.white,
              elevation: 6,
              child: const Icon(Icons.add_rounded, size: 28),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFF1C5F5F),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFDDE8D0),
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
            icon: Image.asset('assets/dashboard.png',
                width: 48, height: 48, color: Colors.grey),
            activeIcon: Image.asset('assets/dashboard.png',
                width: 48, height: 48, color: const Color(0xFF1C5F5F)),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Container(
              key: _mealsTabKey,
              child: Image.asset('assets/meals.png',
                  width: 48, height: 48, color: Colors.grey),
            ),
            activeIcon: Image.asset('assets/meals.png',
                width: 48, height: 48, color: const Color(0xFF1C5F5F)),
            label: 'Meals',
          ),
        ],
      ),
    );
  }
}

// ── Dashboard Tab ─────────────────────────────────────────────────────────────

class _DashboardTab extends ConsumerWidget {
  final String userId;
  final NutritionTargets targets;
  final GlobalKey plantsKey;
  final GlobalKey fermentedKey;
  final GlobalKey fiberKey;
  final GlobalKey omega3Key;
  final GlobalKey magnesiumKey;
  final GlobalKey tryptophanKey;

  const _DashboardTab({
    required this.userId,
    required this.targets,
    required this.plantsKey,
    required this.fermentedKey,
    required this.fiberKey,
    required this.omega3Key,
    required this.magnesiumKey,
    required this.tryptophanKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalsAsync = ref.watch(todayNutrientTotalsProvider(userId));

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDDE8D0),
            Color(0xFFC3D3AE),
            Color(0xFFAAC49A),
          ],
        ),
      ),
      child: SafeArea(
        child: totalsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF4C8C6A)),
          ),
          error: (e, _) => Center(
            child: Text(
              'Error loading data:\n$e',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF1C5F5F)),
            ),
          ),
          data: (totals) => SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                const Text(
                  'Daily Dashboard',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 28,
                    color: Color(0xFF1C5F5F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildCircularScore(totals),
                const SizedBox(height: 40),
                _buildMetricsGrid(totals, targets),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularScore(DailyNutrientTotal? totals) {
    final score = (totals?.overallScorePct ?? 0.0).clamp(0.0, 1.0);
    final pct = (score * 100).round();
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: score,
            strokeWidth: 14,
            backgroundColor: const Color(0xFFBDD4A8),
            color: const Color(0xFF4C8C6A),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Overall Score:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4C7A5A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$pct%',
              style: const TextStyle(
                fontSize: 38,
                fontFamily: 'Georgia',
                color: Color(0xFF1C5F5F),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(
      DailyNutrientTotal? totals, NutritionTargets t) {
    final plantCurrent =
        (totals?.plantSpeciesCount ?? 0).toDouble();
    final fermentedCurrent = totals?.fermentedServings ?? 0.0;
    final fiberCurrent = totals?.prebioticFiberG ?? 0.0;
    final omega3Current = totals?.omega3G ?? 0.0;
    final magCurrent = totals?.magnesiumMg ?? 0.0;
    final tryptCurrent = totals?.tryptophanMg ?? 0.0;

    double prog(double current, double target) =>
        target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: [
        _MetricCard(
          key: plantsKey,
          iconPath: 'assets/nutritionDashboardAssets/plants.png',
          title: 'Plant Diversity',
          valueText:
              '${plantCurrent.toInt()} / ${t.plantSpecies}',
          progress: prog(plantCurrent, t.plantSpecies.toDouble()),
        ),
        _MetricCard(
          key: fermentedKey,
          iconPath:
              'assets/nutritionDashboardAssets/fermented_foods.png',
          title: 'Fermented Foods',
          valueText:
              '${fermentedCurrent.toStringAsFixed(1)} / ${t.fermented.toStringAsFixed(0)}',
          progress: prog(fermentedCurrent, t.fermented),
        ),
        _MetricCard(
          key: fiberKey,
          iconPath:
              'assets/nutritionDashboardAssets/prebiotic_fiber.png',
          title: 'Prebiotic Fiber',
          valueText:
              '${fiberCurrent.toStringAsFixed(0)} / ${t.fiberG.toStringAsFixed(0)}g',
          progress: prog(fiberCurrent, t.fiberG),
        ),
        _MetricCard(
          key: omega3Key,
          iconPath: 'assets/nutritionDashboardAssets/omega_3.png',
          title: 'Omega-3',
          valueText:
              '${omega3Current.toStringAsFixed(1)} / ${t.omega3G.toStringAsFixed(0)}g',
          progress: prog(omega3Current, t.omega3G),
        ),
        _MetricCard(
          key: magnesiumKey,
          iconPath: 'assets/nutritionDashboardAssets/magnesium.png',
          title: 'Magnesium',
          valueText:
              '${magCurrent.toStringAsFixed(0)} / ${t.magnesiumMg.toStringAsFixed(0)}mg',
          progress: prog(magCurrent, t.magnesiumMg),
        ),
        _MetricCard(
          key: tryptophanKey,
          iconPath:
              'assets/nutritionDashboardAssets/tryptophan.png',
          title: 'Tryptophan',
          valueText:
              '${tryptCurrent.toStringAsFixed(0)} / ${t.tryptophanMg.toStringAsFixed(0)}mg',
          progress: prog(tryptCurrent, t.tryptophanMg),
        ),
      ],
    );
  }
}

// ── Metric Card ───────────────────────────────────────────────────────────────

class _MetricCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String valueText;
  final double progress;

  const _MetricCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.valueText,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF4E7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFC3D3AE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, width: 25, height: 25),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1C5F5F),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              valueText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C5F5F),
              ),
            ),
          ),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFC3D3AE),
            color: const Color(0xFF4C8C6A),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

// ── Meals Tab ─────────────────────────────────────────────────────────────────

class _MealsTab extends ConsumerStatefulWidget {
  final String userId;
  final GlobalKey mealsListKey;
  final bool showDummyMeal;

  const _MealsTab({
    required this.userId,
    required this.mealsListKey,
    this.showDummyMeal = false,
  });

  @override
  ConsumerState<_MealsTab> createState() => _MealsTabState();
}

class _MealsTabState extends ConsumerState<_MealsTab> {
  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete this meal?',
          style: TextStyle(
              fontFamily: 'Georgia', color: Color(0xFF1C5F5F)),
        ),
        content: const Text(
          'This will permanently remove the meal and its log entry.',
          style: TextStyle(color: Color(0xFF4C7A5A)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF4C7A5A))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.delete_rounded,
          color: Colors.white, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64,
            color: const Color(0xFF4C8C6A).withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'No meals logged yet',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 18,
              color: Color(0xFF4C7A5A),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap + to log your first meal',
            style: TextStyle(fontSize: 14, color: Color(0xFF4C7A5A)),
          ),
        ],
      ),
    );
  }



  String _buildDescription(Meal meal) {
    final parts = <String>[];
    if ((meal.plantSpeciesCount ?? 0) > 0) {
      parts.add('${meal.plantSpeciesCount} plant species');
    }
    if ((meal.prebioticFiberG ?? 0) > 0) {
      parts.add('${meal.prebioticFiberG!.toStringAsFixed(1)}g fiber');
    }
    if ((meal.omega3G ?? 0) > 0) {
      parts.add('${meal.omega3G!.toStringAsFixed(1)}g omega-3');
    }
    return parts.isEmpty
        ? 'No nutrition data recorded'
        : parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final mealsAsync = ref.watch(mealsStreamProvider(widget.userId));

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFDDE8D0),
            Color(0xFFC3D3AE),
            Color(0xFFAAC49A),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header banner ────────────────────────────────────────
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRect(
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/nutritionbg.png',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                const Text(
                  'Suggested Meals',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 26,
                    color: Color(0xFF1C5F5F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // ── Meals list ───────────────────────────────────────────
            Expanded(
              key: widget.mealsListKey,
              child: mealsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFF4C8C6A)),
                ),
                error: (e, _) =>
                    Center(child: Text('Error: $e')),
                data: (meals) {
                  // Show a dummy card during the tutorial
                  if (widget.showDummyMeal) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      children: const [
                        _MealCard(
                          name: 'Avocado Toast',
                          slot: 'breakfast',
                          description:
                              'Sourdough bread with avocado, lemon & seeds',
                        ),
                      ],
                    );
                  }

                  if (meals.isEmpty) return _buildEmptyState();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: meals.length,
                    itemBuilder: (ctx, i) {
                      final meal = meals[i];
                      return Dismissible(
                        key: ValueKey(meal.mealId),
                        direction: DismissDirection.endToStart,
                        background: _buildDismissBackground(),
                        confirmDismiss: (_) =>
                            _confirmDelete(context),
                        onDismissed: (_) async {
                          await ref
                              .read(mealDaoProvider)
                              .deleteMeal(meal.mealId);
                          // Stream auto-refreshes; no setState needed.
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content:
                                    const Text('Meal removed'),
                                backgroundColor:
                                    const Color(0xFF4C8C6A),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                        child: GestureDetector(
                          onTap: () => _showMealDetailsDialog(context, meal),
                          child: _MealCard(
                            name: meal.mealName ?? 'Unnamed Meal',
                            slot: meal.mealSlot ?? '',
                            description: _buildDescription(meal),
                            onConsume: () => _consumeMeal(context, meal),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _consumeMeal(BuildContext context, Meal meal) async {
    try {
      final db = ref.read(dbProvider);
      final uuid = const Uuid();
      final logId = uuid.v4();
      final now = DateTime.now();
      final todayStr = now.toIso8601String().split('T').first;

      // ── 1. Insert log locally (isSynced = false until confirmed) ──────────
      await db.mealLogDao.insertLog(MealLogsCompanion.insert(
        logId: logId,
        mealId: meal.mealId,
        userId: widget.userId,
        date: todayStr,
        mealSlot: meal.mealSlot ?? 'snack',
        loggedAt: now.toIso8601String(),
      ));

      // ── 2. Recompute cumulative nutrient progress from all today's logs ───
      final logsWithMeals =
          await db.mealLogDao.getLogsWithMeals(widget.userId, todayStr, todayStr);
      int plantSum = 0;
      double fiberSum = 0;
      double fermSum = 0;
      double omegaSum = 0;
      double magSum = 0;
      double trypSum = 0;

      for (final pair in logsWithMeals) {
        plantSum += pair.meal.plantSpeciesCount ?? 0;
        fiberSum += pair.meal.prebioticFiberG ?? 0;
        fermSum += pair.meal.fermentedServings ?? 0;
        omegaSum += pair.meal.omega3G ?? 0;
        magSum += pair.meal.magnesiumMg ?? 0;
        trypSum += pair.meal.tryptophanMg ?? 0;
      }

      // ── 3. Update local daily totals row ──────────────────────────────────
      final dt =
          await db.dailyNutrientTotalsDao.getTotalsForDate(widget.userId, todayStr);

      double score = 0;
      int tPlant = 5;
      double tFiber = 28, tFerm = 2, tOmega = 2, tMag = 350, tTryp = 400;

      if (dt != null) {
        tPlant = dt.targetPlantSpecies ?? 5;
        tFiber = dt.targetFiberG ?? 28;
        tFerm = dt.targetFermented ?? 2;
        tOmega = dt.targetOmega3G ?? 2;
        tMag = dt.targetMagnesiumMg ?? 350;
        tTryp = dt.targetTryptophanMg ?? 400;

        score += (tPlant > 0 ? (plantSum / tPlant).clamp(0, 1) : 0);
        score += (tFiber > 0 ? (fiberSum / tFiber).clamp(0, 1) : 0);
        score += (tFerm > 0 ? (fermSum / tFerm).clamp(0, 1) : 0);
        score += (tOmega > 0 ? (omegaSum / tOmega).clamp(0, 1) : 0);
        score += (tMag > 0 ? (magSum / tMag).clamp(0, 1) : 0);
        score += (tTryp > 0 ? (trypSum / tTryp).clamp(0, 1) : 0);
        score /= 6.0;

        await db.dailyNutrientTotalsDao.updateProgress(
            widget.userId, todayStr, fermSum, fiberSum, magSum, omegaSum,
            plantSum, trypSum, score);
      }

      // ── 4. Try to push meal log to server immediately ─────────────────────
      final logPayload = <String, dynamic>{
        'userId': widget.userId,
        'date': todayStr,
        'mealSlot': meal.mealSlot ?? 'snack',
        'plantSpeciesCount': meal.plantSpeciesCount,
        'fermentedServings': meal.fermentedServings,
        'prebioticFiberG': meal.prebioticFiberG,
        'omega3G': meal.omega3G,
        'magnesiumMg': meal.magnesiumMg,
        'tryptophanMg': meal.tryptophanMg,
        if (meal.plantSpeciesList != null)
          'plantSpeciesList': jsonDecode(meal.plantSpeciesList!),
        if (meal.suggestionId != null) 'suggestionId': meal.suggestionId,
        'triggerFoodFlag': false,
      };

      final logSynced = await MealLogApiService.createMealLog(logPayload);

      if (logSynced) {
        // Mark log as synced in local DB
        await db.mealLogDao.markAsSynced(logId);

        // ── 5. Push daily totals (PATCH or POST) using typed DTO ─────────────
        await DailyNutrientTotalsApiService.upsertTotals(
          userId: widget.userId,
          date: todayStr,
          plantSpeciesCount: plantSum,
          fermentedServings: fermSum,
          prebioticFiberG: fiberSum,
          omega3G: omegaSum,
          magnesiumMg: magSum,
          tryptophanMg: trypSum,
          overallScorePct: score,
          targetPlantSpecies: tPlant,
          targetFermented: tFerm,
          targetFiberG: tFiber,
          targetOmega3G: tOmega,
          targetMagnesiumMg: tMag,
          targetTryptophanMg: tTryp,
        );
        if (dt != null) {
          await db.dailyNutrientTotalsDao.markAsSynced(dt.totalId);
        }

        // ── 6. Remove the meal card from the list ─────────────────────────────
        await db.mealDao.deleteMeal(meal.mealId);
      }
      // If offline, the log stays with isSynced=false and will sync later.

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(logSynced
                ? '${meal.mealName ?? 'Meal'} logged!'
                : '${meal.mealName ?? 'Meal'} saved offline — will sync when connected.'),
            backgroundColor: const Color(0xFF4C8C6A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }
  }

}


// ── Log Meal Bottom Sheet (AI Flow) ──────────────────────────────────────────

enum _OwnMealStage { input, loading, review, logging }

class _OwnMealFlowSheet extends ConsumerStatefulWidget {
  final String userId;
  const _OwnMealFlowSheet({required this.userId});

  @override
  ConsumerState<_OwnMealFlowSheet> createState() => _OwnMealFlowSheetState();
}

class _OwnMealFlowSheetState extends ConsumerState<_OwnMealFlowSheet> {
  _OwnMealStage _stage = _OwnMealStage.input;

  String _selectedSlot = 'Breakfast';
  final _detailsController = TextEditingController();

  final List<String> _slots = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  AiMealResponse? _aiResponse;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _analyzeMeal() async {
    final mealDetails = _detailsController.text.trim();
    if (mealDetails.isEmpty) return;

    setState(() => _stage = _OwnMealStage.loading);

    try {
      // 1. Get Context
      final contextFuture = ref.read(mealFlowContextProvider(widget.userId).future);
      final ctx = await contextFuture;

      final profile = ctx.profile;
      if (profile == null) {
        throw Exception("Profile not found.");
      }

      // 2. Compute targets & context hash
      final targets = NutrientTargetService.computeTargets(
          profile, ctx.conditions, ctx.dailyState);

      final newHash = NutrientTargetService.buildContextHash(
          widget.userId, profile, ctx.conditions, ctx.dailyState);

      final prefs = await SharedPreferences.getInstance();
      final oldHash = prefs.getString('nutrient_context_hash');

      final db = ref.read(dbProvider);

      if (ctx.dailyTotal == null) {
        // Create today's row
        final now = DateTime.now();
        final today =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
        final uuid = const Uuid();
        await db.dailyNutrientTotalsDao.insertOrReplaceTotals(
          DailyNutrientTotalsCompanion.insert(
            totalId: uuid.v4(),
            userId: widget.userId,
            date: today,
            computedAt: now.toIso8601String(),
            fermentedServings: const drift.Value(0.0),
            magnesiumMg: const drift.Value(0.0),
            omega3G: const drift.Value(0.0),
            overallScorePct: const drift.Value(0.0),
            plantSpeciesCount: const drift.Value(0),
            prebioticFiberG: const drift.Value(0.0),
            tryptophanMg: const drift.Value(0.0),
            targetFermented: drift.Value(targets.fermented),
            targetFiberG: drift.Value(targets.fiberG),
            targetMagnesiumMg: drift.Value(targets.magnesiumMg),
            targetOmega3G: drift.Value(targets.omega3G),
            targetPlantSpecies: drift.Value(targets.plantSpecies),
            targetTryptophanMg: drift.Value(targets.tryptophanMg),
          ),
        );
      } else if (oldHash != newHash) {
        // Update targets
        final today = ctx.dailyTotal!.date;
        await db.dailyNutrientTotalsDao.updateTargets(
          widget.userId,
          today,
          targets.fermented,
          targets.fiberG,
          targets.magnesiumMg,
          targets.omega3G,
          targets.plantSpecies,
          targets.tryptophanMg,
        );
      }

      await prefs.setString('nutrient_context_hash', newHash);

      // Re-fetch daily total to ensure we have the latest targets
      final todayStr = DateTime.now().toIso8601String().split('T').first;
      final dailyTotal = await db.dailyNutrientTotalsDao.getTotalsForDate(widget.userId, todayStr);

      // 3. Plant Window
      final plantWindow = await PlantSpeciesService.queryWindow(
          db, widget.userId, targets.plantSpecies, dailyTotal?.plantSpeciesCount ?? 0);

      // 4. Call AI
      final aiResponse = await GeminiService.analyzeMeal(
        profile: profile,
        conditions: ctx.conditions,
        dailyState: ctx.dailyState,
        dailyTotal: dailyTotal,
        plantWindow: plantWindow,
        mealSlot: _selectedSlot.toLowerCase(),
        userMealDescription: mealDetails,
      );

      setState(() {
        _aiResponse = aiResponse;
        _stage = _OwnMealStage.review;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _stage = _OwnMealStage.input);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not analyze your meal. Please try again. \nError: $e'),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }

  Future<void> _logMeal() async {
    if (_aiResponse == null) return;
    setState(() => _stage = _OwnMealStage.logging);

    try {
      final db = ref.read(dbProvider);
      final uuid = const Uuid();
      final mealId = uuid.v4();

      // Insert Meal
      await db.mealDao.insertMeal(MealsCompanion.insert(
        mealId: mealId,
        userId: widget.userId,
        mealName: drift.Value(_aiResponse!.mealName),
        mealSlot: drift.Value(_aiResponse!.mealSlot),
        plantSpeciesList: drift.Value(jsonEncode(_aiResponse!.plantSpeciesList)),
        plantSpeciesCount: drift.Value(_aiResponse!.plantSpeciesCount),
        fermentedServings: drift.Value(_aiResponse!.fermentedServings),
        magnesiumMg: drift.Value(_aiResponse!.magnesiumMg),
        omega3G: drift.Value(_aiResponse!.omega3G),
        prebioticFiberG: drift.Value(_aiResponse!.prebioticFiberG),
        tryptophanMg: drift.Value(_aiResponse!.tryptophanMg),
      ));

      // End of insertion

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _stage = _OwnMealStage.review);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving meal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFEDF4E7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFC3D3AE),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (_stage == _OwnMealStage.input) _buildInputStage(),
          if (_stage == _OwnMealStage.loading) _buildLoadingStage('Analysing your meal...'),
          if (_stage == _OwnMealStage.review) _buildReviewStage(),
          if (_stage == _OwnMealStage.logging) _buildLoadingStage('Saving meal...'),
        ],
      ),
    );
  }

  Widget _buildInputStage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Log a Meal',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C5F5F),
          ),
        ),
        const SizedBox(height: 20),
        // Meal slot chips
        Wrap(
          spacing: 8,
          children: _slots.map((slot) {
            final selected = slot == _selectedSlot;
            return ChoiceChip(
              label: Text(slot),
              selected: selected,
              onSelected: (_) => setState(() => _selectedSlot = slot),
              selectedColor: const Color(0xFF4C8C6A),
              backgroundColor: const Color(0xFFDDE8D0),
              labelStyle: TextStyle(
                color: selected ? Colors.white : const Color(0xFF1C5F5F),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        // Meal details field
        TextField(
          controller: _detailsController,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'What did you eat?',
            alignLabelWithHint: true,
            labelStyle: const TextStyle(color: Color(0xFF4C7A5A)),
            filled: true,
            fillColor: const Color(0xFFDDE8D0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          cursorColor: const Color(0xFF1C5F5F),
        ),
        const SizedBox(height: 24),
        // Save button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4C8C6A), Color(0xFF1C5F5F)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1C5F5F).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextButton(
              onPressed: _analyzeMeal,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text(
                'Analyse',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingStage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const CircularProgressIndicator(color: Color(0xFF4C8C6A)),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 18,
                color: Color(0xFF1C5F5F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStage() {
    final ai = _aiResponse!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                ai.mealName,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C5F5F),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF4C8C6A).withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ai.mealSlot.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C8C6A),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Grid
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _buildGridCell('+${ai.plantSpeciesCount}', 'PLANTS'),
                  _buildVerticalDivider(),
                  _buildGridCell(ai.fermentedServings > 0 ? 'YES' : 'NO', 'FERMENTED'),
                  _buildVerticalDivider(),
                  _buildGridCell('${ai.prebioticFiberG.toStringAsFixed(0)}g', 'FIBER'),
                ],
              ),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
              Row(
                children: [
                  _buildGridCell('${ai.omega3G.toStringAsFixed(0)}mg', 'OMEGA-3'),
                  _buildVerticalDivider(),
                  _buildGridCell('${ai.magnesiumMg.toStringAsFixed(0)}mg', 'MAGNESIUM'),
                  _buildVerticalDivider(),
                  _buildGridCell('${ai.tryptophanMg.toStringAsFixed(0)}mg', 'TRYPTOPHAN'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          ai.gutBrainRationale,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF4C7A5A),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFF4C8C6A)),
                  ),
                ),
                child: const Text(
                  'Discard',
                  style: TextStyle(
                    color: Color(0xFF4C8C6A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C8C6A), Color(0xFF1C5F5F)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1C5F5F).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: _logMeal,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'Save Meal',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Meal Card ─────────────────────────────────────────────────────────────────

class _MealCard extends StatelessWidget {
  /// Optional network image URL — shows a placeholder when null.
  final String? imageUrl;
  final String name;
  final String description;
  final String slot;
  final VoidCallback? onConsume;

  const _MealCard({
    this.imageUrl,
    required this.name,
    required this.description,
    required this.slot,
    this.onConsume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF4E7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFC3D3AE)),
      ),
      child: Row(
        children: [
          // Image / placeholder
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16)),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name + slot badge
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C5F5F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (slot.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C8C6A)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            slot.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C8C6A),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4C7A5A),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: onConsume,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C8C6A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Consumed',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 110,
      height: 110,
      color: const Color(0xFFBDD4A8),
      child: const Icon(
        Icons.restaurant_menu,
        size: 40,
        color: Color(0xFF4C8C6A),
      ),
    );
  }
}

void _showMealDetailsDialog(BuildContext context, Meal meal, {GlobalKey? dialogKey}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        key: dialogKey,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                meal.mealName ?? 'Unnamed Meal',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C5F5F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Image Placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  color: const Color(0xFFBDD4A8),
                  child: const Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: Color(0xFF4C8C6A),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Grid
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildGridCell(
                            '+${meal.plantSpeciesCount ?? 0}', 'PLANTS'),
                        _buildVerticalDivider(),
                        _buildGridCell(
                            (meal.fermentedServings ?? 0) > 0 ? 'YES' : 'NO',
                            'FERMENTED'),
                        _buildVerticalDivider(),
                        _buildGridCell(
                            '${meal.prebioticFiberG?.toStringAsFixed(0) ?? 0}g',
                            'FIBER'),
                      ],
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    Row(
                      children: [
                        _buildGridCell(
                            '${meal.omega3G?.toStringAsFixed(0) ?? 0}mg',
                            'OMEGA-3'),
                        _buildVerticalDivider(),
                        _buildGridCell(
                            '${meal.magnesiumMg?.toStringAsFixed(0) ?? 0}mg',
                            'MAGNESIUM'),
                        _buildVerticalDivider(),
                        _buildGridCell(
                            '${meal.tryptophanMg?.toStringAsFixed(0) ?? 0}mg',
                            'TRYPTOPHAN'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Description text
              const Text(
                'This meal provides healthy fats, fiber, and diverse plant nutrients. It also offers omega-3 fatty acids, magnesium, and tryptophan to support brain health and mood.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4C7A5A),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildGridCell(String value, String label) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C5F5F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF4C7A5A),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildVerticalDivider() {
  return Container(
    height: 60,
    width: 1,
    color: Colors.grey.shade300,
  );
}