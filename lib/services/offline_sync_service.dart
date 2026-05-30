import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../database/app_database.dart';
import '../api/meal_log_api_service.dart';
import '../api/daily_nutrient_totals_api_service.dart';

/// Handles pushing locally-cached data to the backend whenever connectivity
/// is available. Uses [isSynced] flags on SQLite rows instead of SharedPreferences.
class OfflineSyncService {
  static bool _isSyncing = false;

  /// Call this on connectivity restore or immediately after a "consume" action.
  static Future<void> attemptSync(AppDatabase db) async {
    if (_isSyncing) return;

    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity.contains(ConnectivityResult.none)) {
        return; // Still offline
      }

      _isSyncing = true;

      // ── Sync Meal Logs (via MealLogRequest) ────────────────────────────────
      // We join each unsynced log with its meal to build a flat MealLogRequest
      // that the backend can parse without any nested entity references.
      final unsyncedLogs = await db.mealLogDao.getUnsyncedLogs();
      for (final log in unsyncedLogs) {
        // Fetch the associated meal for nutrient data
        final meal = await db.mealDao.getMealById(log.mealId);

        final data = <String, dynamic>{
          'userId': log.userId,
          'date': log.date,
          'mealSlot': log.mealSlot,
          // Nutrient data from the joined meal row
          if (meal != null) ...{
            'plantSpeciesCount': meal.plantSpeciesCount,
            'fermentedServings': meal.fermentedServings,
            'prebioticFiberG': meal.prebioticFiberG,
            'omega3G': meal.omega3G,
            'magnesiumMg': meal.magnesiumMg,
            'tryptophanMg': meal.tryptophanMg,
            if (meal.plantSpeciesList != null)
              'plantSpeciesList': jsonDecode(meal.plantSpeciesList!),
            if (meal.suggestionId != null) 'suggestionId': meal.suggestionId,
          },
          // MealLogRequest boolean defaults
          'triggerFoodFlag': false,
        };

        final success = await MealLogApiService.createMealLog(data);
        if (success) {
          await db.mealLogDao.markAsSynced(log.logId);
          // Also mark the parent meal as synced since its data was submitted
          if (meal != null) {
            await db.mealDao.markAsSynced(meal.mealId);
          }
        }
      }

      // ── Sync Daily Nutrient Totals ──────────────────────────────────────────
      final unsyncedTotals = await db.dailyNutrientTotalsDao.getUnsyncedTotals();
      for (final total in unsyncedTotals) {
        final body = <String, dynamic>{
          'fermentedServings': total.fermentedServings,
          'magnesiumMg': total.magnesiumMg,
          'omega3G': total.omega3G,
          'overallScorePct': total.overallScorePct,
          'plantSpeciesCount': total.plantSpeciesCount,
          'prebioticFiberG': total.prebioticFiberG,
          'tryptophanMg': total.tryptophanMg,
          'targetFermented': total.targetFermented,
          'targetFiberG': total.targetFiberG,
          'targetMagnesiumMg': total.targetMagnesiumMg,
          'targetOmega3G': total.targetOmega3G,
          'targetPlantSpecies': total.targetPlantSpecies,
          'targetTryptophanMg': total.targetTryptophanMg,
        };
        final success = await DailyNutrientTotalsApiService.patchTotals(
            total.userId, total.date, body);
        if (success) {
          await db.dailyNutrientTotalsDao.markAsSynced(total.totalId);
        }
      }
    } catch (e) {
      print('[OfflineSyncService] Exception during sync: $e');
    } finally {
      _isSyncing = false;
    }
  }
}
