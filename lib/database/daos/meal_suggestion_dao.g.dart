// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_suggestion_dao.dart';

// ignore_for_file: type=lint
mixin _$MealSuggestionDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealSuggestionsTable get mealSuggestions => attachedDatabase.mealSuggestions;
  MealSuggestionDaoManager get managers => MealSuggestionDaoManager(this);
}

class MealSuggestionDaoManager {
  final _$MealSuggestionDaoMixin _db;
  MealSuggestionDaoManager(this._db);
  $$MealSuggestionsTableTableManager get mealSuggestions =>
      $$MealSuggestionsTableTableManager(
        _db.attachedDatabase,
        _db.mealSuggestions,
      );
}
