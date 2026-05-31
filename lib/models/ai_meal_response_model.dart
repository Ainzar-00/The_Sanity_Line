class AiMealResponse {
  final String mealName;
  final String mealSlot;
  final List<String> plantSpeciesList;
  final int plantSpeciesCount;
  final double fermentedServings;
  final double magnesiumMg;
  final double omega3G;
  final double prebioticFiberG;
  final double tryptophanMg;
  final String gutBrainRationale;

  /// Flat list of ingredient strings returned by the AI.
  final List<String> ingredients;

  /// Optional step-by-step cooking instructions returned by the AI.
  final String? instructions;

  AiMealResponse({
    required this.mealName,
    required this.mealSlot,
    required this.plantSpeciesList,
    required this.plantSpeciesCount,
    required this.fermentedServings,
    required this.magnesiumMg,
    required this.omega3G,
    required this.prebioticFiberG,
    required this.tryptophanMg,
    required this.gutBrainRationale,
    this.ingredients = const [],
    this.instructions,
  });

  factory AiMealResponse.fromJson(Map<String, dynamic> json) {
    return AiMealResponse(
      mealName: json['mealName'] as String? ?? 'Unknown Meal',
      mealSlot: json['mealSlot'] as String? ?? '',
      plantSpeciesList: (json['plantSpeciesList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      plantSpeciesCount: (json['plantSpeciesCount'] as num?)?.toInt() ?? 0,
      fermentedServings: (json['fermentedServings'] as num?)?.toDouble() ?? 0.0,
      magnesiumMg: (json['magnesiumMg'] as num?)?.toDouble() ?? 0.0,
      omega3G: (json['omega3G'] as num?)?.toDouble() ?? 0.0,
      prebioticFiberG: (json['prebioticFiberG'] as num?)?.toDouble() ?? 0.0,
      tryptophanMg: (json['tryptophanMg'] as num?)?.toDouble() ?? 0.0,
      gutBrainRationale: json['gutBrainRationale'] as String? ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      instructions: json['instructions'] as String?,
    );
  }
}
