import 'package:drift/drift.dart';
import '../app_database.dart';

part 'meal_suggestion_dao.g.dart';

@DriftAccessor(tables: [MealSuggestions])
class MealSuggestionDao extends DatabaseAccessor<AppDatabase>
    with _$MealSuggestionDaoMixin {
  MealSuggestionDao(super.db);

  /// Insert a new AI-generated suggestion.
  Future<void> insertSuggestion(MealSuggestionsCompanion entry) =>
      into(mealSuggestions).insert(entry);

  /// All suggestions for this user (accepted + rejected), newest first.
  Future<List<MealSuggestion>> getSuggestionsForUser(String userId) =>
      (select(mealSuggestions)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)]))
          .get();

  /// Watch suggestions — auto-emits when the table changes.
  Stream<List<MealSuggestion>> watchSuggestionsForUser(String userId) =>
      (select(mealSuggestions)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)]))
          .watch();

  /// Mark a suggestion as rejected (user swiped-away the corresponding meal).
  Future<void> markRejected(String suggestionId) =>
      (update(mealSuggestions)
            ..where((t) => t.suggestionId.equals(suggestionId)))
          .write(const MealSuggestionsCompanion(userAccepted: Value(0)));

  /// Mark a suggestion as accepted (user kept / logged the meal).
  Future<void> markAccepted(String suggestionId) =>
      (update(mealSuggestions)
            ..where((t) => t.suggestionId.equals(suggestionId)))
          .write(const MealSuggestionsCompanion(userAccepted: Value(1)));
}
