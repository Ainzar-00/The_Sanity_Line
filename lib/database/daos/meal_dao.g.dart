// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_dao.dart';

// ignore_for_file: type=lint
mixin _$MealDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealSuggestionsTable get mealSuggestions => attachedDatabase.mealSuggestions;
  $MealsTable get meals => attachedDatabase.meals;
  $MealLogsTable get mealLogs => attachedDatabase.mealLogs;
  MealDaoManager get managers => MealDaoManager(this);
}

class MealDaoManager {
  final _$MealDaoMixin _db;
  MealDaoManager(this._db);
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
