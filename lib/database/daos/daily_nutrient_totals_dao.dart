import 'package:drift/drift.dart';
import '../app_database.dart';

part 'daily_nutrient_totals_dao.g.dart';

@DriftAccessor(tables: [DailyNutrientTotals])
class DailyNutrientTotalsDao extends DatabaseAccessor<AppDatabase>
    with _$DailyNutrientTotalsDaoMixin {
  DailyNutrientTotalsDao(super.db);

  /// Upsert: insert or replace on conflict (keyed by totalId).
  Future<void> insertOrReplaceTotals(
          DailyNutrientTotalsCompanion entry) =>
      into(dailyNutrientTotals).insertOnConflictUpdate(entry);

  /// Single row for a user+date, or null if none exists.
  Future<DailyNutrientTotal?> getTotalsForDate(
    String userId,
    String date,
  ) =>
      (select(dailyNutrientTotals)
            ..where(
                (t) => t.userId.equals(userId) & t.date.equals(date)))
          .getSingleOrNull();

  /// Reactive stream for the dashboard — re-emits whenever the row changes.
  Stream<DailyNutrientTotal?> watchTotalsForDate(
    String userId,
    String date,
  ) =>
      (select(dailyNutrientTotals)
            ..where(
                (t) => t.userId.equals(userId) & t.date.equals(date)))
          .watchSingleOrNull();

  /// Rows within an inclusive date range.
  Future<List<DailyNutrientTotal>> getTotalsForDateRange(
    String userId,
    String from,
    String to,
  ) =>
      (select(dailyNutrientTotals)
            ..where((t) =>
                t.userId.equals(userId) &
                t.date.isBiggerOrEqualValue(from) &
                t.date.isSmallerOrEqualValue(to))
            ..orderBy([(t) => OrderingTerm.asc(t.date)]))
          .get();

  /// Delete a user's totals row for a specific date.
  Future<void> deleteTotalsForDate(String userId, String date) =>
      (delete(dailyNutrientTotals)
            ..where(
                (t) => t.userId.equals(userId) & t.date.equals(date)))
          .go();
}
