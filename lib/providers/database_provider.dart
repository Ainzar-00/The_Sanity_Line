import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../models/profile_model.dart';
import '../models/mental_condition_model.dart';
import '../models/daily_state_model.dart';
import '../api/profile_api_service.dart';
import '../api/mental_condition_api_service.dart';
import '../api/daily_state_api_service.dart';

// ── Singleton database ────────────────────────────────────────────────────────

/// Single [AppDatabase] instance shared across the app.
/// Disposed automatically when the [ProviderContainer] is destroyed.
final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ── DAO providers ─────────────────────────────────────────────────────────────

final mealSuggestionDaoProvider =
    Provider((ref) => ref.read(dbProvider).mealSuggestionDao);

final mealDaoProvider =
    Provider((ref) => ref.read(dbProvider).mealDao);

final mealLogDaoProvider =
    Provider((ref) => ref.read(dbProvider).mealLogDao);

final nutrientTotalsDaoProvider =
    Provider((ref) => ref.read(dbProvider).dailyNutrientTotalsDao);

// ── Stream providers (reactive UI) ────────────────────────────────────────────

/// Live list of meals for [userId] — re-emits on every DB change.
final mealsStreamProvider =
    StreamProvider.family<List<Meal>, String>((ref, userId) {
  return ref.watch(mealDaoProvider).watchMealsForUser(userId);
});

/// Live daily-nutrient-totals row for today — re-emits whenever it changes.
final todayNutrientTotalsProvider =
    StreamProvider.family<DailyNutrientTotal?, String>((ref, userId) {
  final today = _today();
  return ref
      .watch(nutrientTotalsDaoProvider)
      .watchTotalsForDate(userId, today);
});

// ── Helpers ───────────────────────────────────────────────────────────────────

String _today() {
  final now = DateTime.now();
  return '${now.year}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.day.toString().padLeft(2, '0')}';
}

class MealFlowContext {
  final ProfileModel? profile;
  final List<MentalConditionModel> conditions;
  final DailyStateModel? dailyState;
  final DailyNutrientTotal? dailyTotal;

  MealFlowContext({
    this.profile,
    required this.conditions,
    this.dailyState,
    this.dailyTotal,
  });
}

final mealFlowContextProvider =
    FutureProvider.family<MealFlowContext, String>((ref, userId) async {
  final today = _today();

  // Load everything in parallel
  final profileFuture = ProfileApiService.getProfileByUserId(userId);
  final conditionsFuture =
      MentalConditionApiService.getConditionsForUser(userId);
  final dailyStateFuture = DailyStateApiService.getForDate(userId, today);
  final totalsFuture =
      ref.read(nutrientTotalsDaoProvider).getTotalsForDate(userId, today);

  final results = await Future.wait([
    profileFuture,
    conditionsFuture,
    dailyStateFuture,
    totalsFuture,
  ]);

  return MealFlowContext(
    profile: results[0] as ProfileModel?,
    conditions: results[1] as List<MentalConditionModel>,
    dailyState: results[2] as DailyStateModel?,
    dailyTotal: results[3] as DailyNutrientTotal?,
  );
});
