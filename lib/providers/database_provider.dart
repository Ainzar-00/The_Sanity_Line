import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

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
