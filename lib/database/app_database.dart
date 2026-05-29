import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';

import 'daos/daily_nutrient_totals_dao.dart';
import 'daos/meal_dao.dart';
import 'daos/meal_log_dao.dart';
import 'daos/meal_suggestion_dao.dart';

part 'app_database.g.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

/// AI-generated meal suggestions. One suggestion may become one Meal.
class MealSuggestions extends Table {
  TextColumn get suggestionId => text()();
  TextColumn get userId => text()();
  TextColumn get mealName => text().nullable()();
  TextColumn get mealSlot => text().nullable()();

  /// JSON-encoded list of ingredients.
  TextColumn get ingredients => text().nullable()();
  TextColumn get instructions => text().nullable()();
  TextColumn get gutBrainRationale => text().nullable()();

  /// JSON snapshot of the prompt used to generate this suggestion.
  TextColumn get promptSnapshot => text().nullable()();

  /// Raw JSON response from the AI model.
  TextColumn get rawResponseJson => text().nullable()();
  TextColumn get targetsCondition => text().nullable()();
  TextColumn get requestedAt => text()();

  /// 1 = accepted / not yet acted on, 0 = rejected.
  IntColumn get userAccepted =>
      integer().withDefault(const Constant(1))();
  TextColumn get stateId => text().nullable()();

  // Nutrition estimates from the suggestion
  RealColumn get fermentedServings => real().nullable()();
  RealColumn get magnesiumMg => real().nullable()();
  RealColumn get omega3G => real().nullable()();
  IntColumn get plantSpeciesCount => integer().nullable()();
  RealColumn get prebioticFiberG => real().nullable()();
  RealColumn get tryptophanMg => real().nullable()();

  @override
  Set<Column> get primaryKey => {suggestionId};
}

/// A concrete meal — either user-created or derived from a suggestion.
class Meals extends Table {
  TextColumn get mealId => text()();
  TextColumn get userId => text()();

  /// Nullable FK to meal_suggestions. NULL means user-created with no suggestion.
  TextColumn get suggestionId => text()
      .nullable()
      .references(MealSuggestions, #suggestionId)();

  TextColumn get mealName => text().nullable()();
  TextColumn get mealSlot => text().nullable()();
  IntColumn get plantSpeciesCount => integer().nullable()();

  /// JSON-encoded list of plant species names.
  TextColumn get plantSpeciesList => text().nullable()();
  RealColumn get fermentedServings => real().nullable()();
  RealColumn get magnesiumMg => real().nullable()();
  RealColumn get omega3G => real().nullable()();
  RealColumn get prebioticFiberG => real().nullable()();
  RealColumn get tryptophanMg => real().nullable()();

  @override
  Set<Column> get primaryKey => {mealId};
}

/// One log entry: records that a user consumed a meal on a given date.
/// meal_logs rows are cascade-deleted when the parent meal is deleted.
class MealLogs extends Table {
  TextColumn get logId => text()();

  /// FK → meals.meal_id with ON DELETE CASCADE.
  TextColumn get mealId => text()
      .references(Meals, #mealId, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();
  TextColumn get date => text()(); // yyyy-MM-dd
  TextColumn get mealSlot => text()(); // breakfast|lunch|dinner|snack
  TextColumn get loggedAt => text()(); // ISO 8601 datetime

  @override
  Set<Column> get primaryKey => {logId};
}

/// Aggregated daily totals, pre-computed and stored for fast dashboard reads.
class DailyNutrientTotals extends Table {
  TextColumn get totalId => text()();
  TextColumn get userId => text()();
  TextColumn get date => text()(); // yyyy-MM-dd
  TextColumn get computedAt => text()(); // ISO 8601 datetime

  // Actual totals for the day
  RealColumn get fermentedServings => real().nullable()();
  RealColumn get magnesiumMg => real().nullable()();
  RealColumn get omega3G => real().nullable()();
  RealColumn get overallScorePct => real().nullable()();
  IntColumn get plantSpeciesCount => integer().nullable()();
  RealColumn get prebioticFiberG => real().nullable()();
  RealColumn get tryptophanMg => real().nullable()();

  // Targets stored alongside totals so history preserves the goals in effect
  RealColumn get targetFermented => real().nullable()();
  RealColumn get targetFiberG => real().nullable()();
  RealColumn get targetMagnesiumMg => real().nullable()();
  RealColumn get targetOmega3G => real().nullable()();
  IntColumn get targetPlantSpecies => integer().nullable()();
  RealColumn get targetTryptophanMg => real().nullable()();

  @override
  Set<Column> get primaryKey => {totalId};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [MealSuggestions, Meals, MealLogs, DailyNutrientTotals],
  daos: [MealSuggestionDao, MealDao, MealLogDao, DailyNutrientTotalsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Enable FK enforcement on every connection open.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

QueryExecutor _openConnection() {
  return SqfliteQueryExecutor.inDatabaseFolder(
    path: 'sanity_line.db',
    logStatements: false,
  );
}
