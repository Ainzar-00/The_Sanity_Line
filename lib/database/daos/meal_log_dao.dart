import 'package:drift/drift.dart';
import '../app_database.dart';

part 'meal_log_dao.g.dart';

@DriftAccessor(tables: [MealLogs])
class MealLogDao extends DatabaseAccessor<AppDatabase>
    with _$MealLogDaoMixin {
  MealLogDao(super.db);

  /// Insert a log entry.
  Future<void> insertLog(MealLogsCompanion entry) =>
      into(mealLogs).insert(entry);

  /// Delete a single log by its id.
  Future<void> deleteLog(String logId) =>
      (delete(mealLogs)..where((t) => t.logId.equals(logId))).go();

  /// All logs for a user on a specific date (yyyy-MM-dd).
  Future<List<MealLog>> getLogsForDate(String userId, String date) =>
      (select(mealLogs)
            ..where(
                (t) => t.userId.equals(userId) & t.date.equals(date)))
          .get();

  /// All logs for a user within an inclusive date range.
  Future<List<MealLog>> getLogsForDateRange(
    String userId,
    String from,
    String to,
  ) =>
      (select(mealLogs)
            ..where((t) =>
                t.userId.equals(userId) &
                t.date.isBiggerOrEqualValue(from) &
                t.date.isSmallerOrEqualValue(to)))
          .get();

  /// Join logs with meals to get nutrient info
  Future<List<MealWithLog>> getLogsWithMeals(
      String userId, String from, String to) async {
    final query = select(mealLogs).join([
      innerJoin(db.meals, db.meals.mealId.equalsExp(mealLogs.mealId))
    ])
      ..where(mealLogs.userId.equals(userId) &
          mealLogs.date.isBiggerOrEqualValue(from) &
          mealLogs.date.isSmallerOrEqualValue(to));

    final rows = await query.get();
    return rows.map((row) {
      return MealWithLog(
        mealLog: row.readTable(mealLogs),
        meal: row.readTable(db.meals),
      );
    }).toList();
  }

  Future<List<MealLog>> getUnsyncedLogs() =>
      (select(mealLogs)..where((t) => t.isSynced.equals(false))).get();

  Future<void> markAsSynced(String logId) =>
      (update(mealLogs)..where((t) => t.logId.equals(logId)))
          .write(const MealLogsCompanion(isSynced: Value(true)));
}

class MealWithLog {
  final MealLog mealLog;
  final Meal meal;

  MealWithLog({required this.mealLog, required this.meal});
}
