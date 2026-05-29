// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_log_dao.dart';

// ignore_for_file: type=lint
mixin _$MealLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealSuggestionsTable get mealSuggestions => attachedDatabase.mealSuggestions;
  $MealsTable get meals => attachedDatabase.meals;
  $MealLogsTable get mealLogs => attachedDatabase.mealLogs;
  MealLogDaoManager get managers => MealLogDaoManager(this);
}

class MealLogDaoManager {
  final _$MealLogDaoMixin _db;
  MealLogDaoManager(this._db);
  $$MealSuggestionsTableTableManager get mealSuggestions =>
      $$MealSuggestionsTableTableManager(
        _db.attachedDatabase,
        _db.mealSuggestions,
      );
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db.attachedDatabase, _db.meals);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db.attachedDatabase, _db.mealLogs);
}
