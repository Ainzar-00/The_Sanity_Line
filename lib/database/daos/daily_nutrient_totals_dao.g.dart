// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_nutrient_totals_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyNutrientTotalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyNutrientTotalsTable get dailyNutrientTotals =>
      attachedDatabase.dailyNutrientTotals;
  DailyNutrientTotalsDaoManager get managers =>
      DailyNutrientTotalsDaoManager(this);
}

class DailyNutrientTotalsDaoManager {
  final _$DailyNutrientTotalsDaoMixin _db;
  DailyNutrientTotalsDaoManager(this._db);
  $$DailyNutrientTotalsTableTableManager get dailyNutrientTotals =>
      $$DailyNutrientTotalsTableTableManager(
        _db.attachedDatabase,
        _db.dailyNutrientTotals,
      );
}
