import 'package:drift/drift.dart';
import '../app_database.dart';

part 'meal_dao.g.dart';

@DriftAccessor(tables: [Meals, MealLogs, MealSuggestions])
class MealDao extends DatabaseAccessor<AppDatabase> with _$MealDaoMixin {
  MealDao(super.db);

  /// Insert a new meal record.
  Future<void> insertMeal(MealsCompanion entry) =>
      into(meals).insert(entry);

  /// All meals for a user.
  Future<List<Meal>> getMealsForUser(String userId) =>
      (select(meals)
            ..where((t) => t.userId.equals(userId) & t.isLogged.equals(false))
            ..orderBy([(t) => OrderingTerm.desc(t.mealId)]))
          .get();

  /// Reactive stream — emits a new list whenever meals change.
  Stream<List<Meal>> watchMealsForUser(String userId) =>
      (select(meals)
            ..where((t) => t.userId.equals(userId) & t.isLogged.equals(false))
            ..orderBy([(t) => OrderingTerm.desc(t.mealId)]))
          .watch();

  /// Single meal by id.
  Future<Meal?> getMealById(String mealId) =>
      (select(meals)..where((t) => t.mealId.equals(mealId)))
          .getSingleOrNull();

  Future<void> markAsLogged(String mealId) =>
      (update(meals)..where((t) => t.mealId.equals(mealId)))
          .write(const MealsCompanion(isLogged: Value(true)));

  /// Delete a meal in a single transaction:
  ///  1. If the meal has a suggestion → mark it rejected.
  ///  2. meal_logs rows are removed automatically via ON DELETE CASCADE.
  ///  3. Delete the meal row.
  Future<void> deleteMeal(String mealId) async {
    await transaction(() async {
      final meal = await getMealById(mealId);
      if (meal != null && meal.suggestionId != null) {
        await (update(mealSuggestions)
              ..where((t) => t.suggestionId.equals(meal.suggestionId!)))
            .write(const MealSuggestionsCompanion(userAccepted: Value(0)));
      }
      // CASCADE handles meal_logs; just delete the meal row.
      await (delete(meals)..where((t) => t.mealId.equals(mealId))).go();
    });
  }

  Future<List<Meal>> getUnsyncedMeals() =>
      (select(meals)..where((t) => t.isSynced.equals(false))).get();

  Future<void> markAsSynced(String mealId) =>
      (update(meals)..where((t) => t.mealId.equals(mealId)))
          .write(const MealsCompanion(isSynced: Value(true)));
}
