// ── ProfileModel ──────────────────────────────────────────────────────────────
// Mirrors the Spring Boot Profile entity.
// All nullable fields are omitted from toJson() when null so the PUT /upsert
// endpoint only overwrites what is explicitly provided.

class ProfileModel {
  final String? profileId;
  final String userId;

  // Section 1 — Personal biometrics
  final int? age;
  final String? sex;
  final double? weightKg;

  // Section 2 — Wellbeing indicators
  final int? baselineMood;
  final int? stressLevel;

  // Section 3 — Digestive health & diet
  final List<String>? digestiveConditions;
  final List<String>? foodSensitivities;
  final int? initialPlantDiversity;
  final double? initialFermentedServings;

  // Section 4 — Lifestyle factors
  final double? avgSleepHours;
  final int? caffeineDailyMg;
  final double? alcoholWeeklyUnits;

  // Onboarding state (read from GET response)
  final DateTime? onboardingCompletedAt;

  const ProfileModel({
    this.profileId,
    required this.userId,
    this.age,
    this.sex,
    this.weightKg,
    this.baselineMood,
    this.stressLevel,
    this.digestiveConditions,
    this.foodSensitivities,
    this.initialPlantDiversity,
    this.initialFermentedServings,
    this.avgSleepHours,
    this.caffeineDailyMg,
    this.alcoholWeeklyUnits,
    this.onboardingCompletedAt,
  });

  // ── Deserialisation ─────────────────────────────────────────────────────────
  // Server returns nested: { "user": { "userId": "..." }, "age": ... }
  // Extract userId from the nested user object if present, else fall back to
  // a flat key so the model works with both server responses and local maps.

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] as Map<String, dynamic>?;
    final userId = (userMap?['userId'] ?? json['userId']) as String;

    return ProfileModel(
      profileId: json['profileId'] as String?,
      userId: userId,
      age: json['age'] as int?,
      sex: json['sex'] as String?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      baselineMood: json['baselineMood'] as int?,
      stressLevel: json['stressLevel'] as int?,
      digestiveConditions: (json['digestiveConditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      foodSensitivities: (json['foodSensitivities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      initialPlantDiversity: json['initialPlantDiversity'] as int?,
      initialFermentedServings:
          (json['initialFermentedServings'] as num?)?.toDouble(),
      avgSleepHours: (json['avgSleepHours'] as num?)?.toDouble(),
      caffeineDailyMg: json['caffeineDailyMg'] as int?,
      alcoholWeeklyUnits: (json['alcoholWeeklyUnits'] as num?)?.toDouble(),
      onboardingCompletedAt: json['onboardingCompletedAt'] == null
          ? null
          : DateTime.tryParse(json['onboardingCompletedAt'] as String),
    );
  }

  // ── Serialisation ───────────────────────────────────────────────────────────
  // Nulls are omitted — the PUT /upsert endpoint ignores missing fields,
  // preserving previously stored values.

  Map<String, dynamic> toJson() => {
        'userId': userId,
        if (age != null) 'age': age,
        if (sex != null && sex!.isNotEmpty) 'sex': sex,
        if (weightKg != null) 'weightKg': weightKg,
        if (baselineMood != null && baselineMood! > 0) 'baselineMood': baselineMood,
        if (stressLevel != null && stressLevel! > 0) 'stressLevel': stressLevel,
        if (digestiveConditions != null && digestiveConditions!.isNotEmpty)
          'digestiveConditions': digestiveConditions,
        if (foodSensitivities != null && foodSensitivities!.isNotEmpty)
          'foodSensitivities': foodSensitivities,
        if (initialPlantDiversity != null)
          'initialPlantDiversity': initialPlantDiversity,
        if (initialFermentedServings != null)
          'initialFermentedServings': initialFermentedServings,
        if (avgSleepHours != null) 'avgSleepHours': avgSleepHours,
        if (caffeineDailyMg != null) 'caffeineDailyMg': caffeineDailyMg,
        if (alcoholWeeklyUnits != null) 'alcoholWeeklyUnits': alcoholWeeklyUnits,
      };
}