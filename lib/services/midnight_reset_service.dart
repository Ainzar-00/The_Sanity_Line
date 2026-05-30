import 'package:drift/drift.dart' hide Column;
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../api/profile_api_service.dart';
import '../api/mental_condition_api_service.dart';
import 'nutrient_target_service.dart';

class MidnightResetService {
  static const taskName = 'midnight_nutrient_reset';

  static void scheduleNext() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final initialDelay = nextMidnight.difference(now);

    Workmanager().registerOneOffTask(
      'midnight_reset_task_id',
      taskName,
      initialDelay: initialDelay,
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static Future<void> runReset(String userId, AppDatabase db) async {
    final profile = await ProfileApiService.getProfileByUserId(userId);
    if (profile == null) return;

    final conditions =
        await MentalConditionApiService.getConditionsForUser(userId);

    // Recompute all targets (dailyState is null for new day defaults)
    final targets =
        NutrientTargetService.computeTargets(profile, conditions, null);

    final now = DateTime.now();
    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final uuid = const Uuid();
    final totalId = uuid.v4();

    await db.dailyNutrientTotalsDao.insertOrReplaceTotals(
      DailyNutrientTotalsCompanion.insert(
        totalId: totalId,
        userId: userId,
        date: today,
        computedAt: DateTime(now.year, now.month, now.day).toIso8601String(),
        // Progress columns
        fermentedServings: const Value(0.0),
        magnesiumMg: const Value(0.0),
        omega3G: const Value(0.0),
        overallScorePct: const Value(0.0),
        plantSpeciesCount: const Value(0),
        prebioticFiberG: const Value(0.0),
        tryptophanMg: const Value(0.0),
        // Targets
        targetFermented: Value(targets.fermented),
        targetFiberG: Value(targets.fiberG),
        targetMagnesiumMg: Value(targets.magnesiumMg),
        targetOmega3G: Value(targets.omega3G),
        targetPlantSpecies: Value(targets.plantSpecies),
        targetTryptophanMg: Value(targets.tryptophanMg),
      ),
    );

    // Clear hash
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nutrient_context_hash');
  }
}
