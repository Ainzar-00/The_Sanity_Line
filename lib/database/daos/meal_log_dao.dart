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
}
