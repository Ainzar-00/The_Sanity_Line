class NutritionTargets {
  final double fermented;
  final double fiberG;
  final double magnesiumMg;
  final double omega3G;
  final int plantSpecies;
  final double tryptophanMg;

  const NutritionTargets({
    this.fermented = 2.0,
    this.fiberG = 28.0,
    this.magnesiumMg = 350.0,
    this.omega3G = 2.0,
    this.plantSpecies = 5,
    this.tryptophanMg = 400.0,
  });

  NutritionTargets copyWith({
    double? fermented,
    double? fiberG,
    double? magnesiumMg,
    double? omega3G,
    int? plantSpecies,
    double? tryptophanMg,
  }) =>
      NutritionTargets(
        fermented: fermented ?? this.fermented,
        fiberG: fiberG ?? this.fiberG,
        magnesiumMg: magnesiumMg ?? this.magnesiumMg,
        omega3G: omega3G ?? this.omega3G,
        plantSpecies: plantSpecies ?? this.plantSpecies,
        tryptophanMg: tryptophanMg ?? this.tryptophanMg,
      );
}
