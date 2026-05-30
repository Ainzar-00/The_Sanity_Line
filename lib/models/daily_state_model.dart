class DailyStateModel {
  final String stateId;
  final String userId;
  final DateTime date; // Extracted to DateTime

  final int? currentMood;
  final int? energyLevel;
  final int? hungerLevel;
  final bool? physicalTraining;
  final double? sleepHoursPrevNight;
  final int? sleepQuality;
  final int? stressLevel;
  final int? trainingDurationMin;
  final int? trainingIntensity;
  final int? wokeUpFeeling;
  final DateTime? recordedAt;
  final String? trainingType;

  final bool? alcoholPrevNight;
  final String? aversion;
  final int? caffeineTodayMg;
  final int? cookTimeAvailableMin;
  final String? craving;
  final int? currentDigestion;
  final int? hoursSinceLastMeal;
  final DateTime? requestedAt;
  final int? waterIntakeMl;

  DailyStateModel({
    required this.stateId,
    required this.userId,
    required this.date,
    this.currentMood,
    this.energyLevel,
    this.hungerLevel,
    this.physicalTraining,
    this.sleepHoursPrevNight,
    this.sleepQuality,
    this.stressLevel,
    this.trainingDurationMin,
    this.trainingIntensity,
    this.wokeUpFeeling,
    this.recordedAt,
    this.trainingType,
    this.alcoholPrevNight,
    this.aversion,
    this.caffeineTodayMg,
    this.cookTimeAvailableMin,
    this.craving,
    this.currentDigestion,
    this.hoursSinceLastMeal,
    this.requestedAt,
    this.waterIntakeMl,
  });

  factory DailyStateModel.fromJson(Map<String, dynamic> json) {
    return DailyStateModel(
      stateId: json['stateId'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      currentMood: json['currentMood'] as int?,
      energyLevel: json['energyLevel'] as int?,
      hungerLevel: json['hungerLevel'] as int?,
      physicalTraining: json['physicalTraining'] as bool?,
      sleepHoursPrevNight: (json['sleepHoursPrevNight'] as num?)?.toDouble(),
      sleepQuality: json['sleepQuality'] as int?,
      stressLevel: json['stressLevel'] as int?,
      trainingDurationMin: json['trainingDurationMin'] as int?,
      trainingIntensity: json['trainingIntensity'] as int?,
      wokeUpFeeling: json['wokeUpFeeling'] as int?,
      recordedAt: json['recordedAt'] != null
          ? DateTime.tryParse(json['recordedAt'] as String)
          : null,
      trainingType: json['trainingType'] as String?,
      alcoholPrevNight: json['alcoholPrevNight'] as bool?,
      aversion: json['aversion'] as String?,
      caffeineTodayMg: json['caffeineTodayMg'] as int?,
      cookTimeAvailableMin: json['cookTimeAvailableMin'] as int?,
      craving: json['craving'] as String?,
      currentDigestion: json['currentDigestion'] as int?,
      hoursSinceLastMeal: json['hoursSinceLastMeal'] as int?,
      requestedAt: json['requestedAt'] != null
          ? DateTime.tryParse(json['requestedAt'] as String)
          : null,
      waterIntakeMl: json['waterIntakeMl'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first,
      if (currentMood != null) 'currentMood': currentMood,
      if (energyLevel != null) 'energyLevel': energyLevel,
      if (hungerLevel != null) 'hungerLevel': hungerLevel,
      // Always send as boolean — DailyStateRequest has physicalTraining: Boolean = false
      'physicalTraining': physicalTraining ?? false,
      if (sleepHoursPrevNight != null)
        'sleepHoursPrevNight': sleepHoursPrevNight,
      if (sleepQuality != null) 'sleepQuality': sleepQuality,
      if (stressLevel != null) 'stressLevel': stressLevel,
      if (trainingDurationMin != null)
        'trainingDurationMin': trainingDurationMin,
      if (trainingIntensity != null) 'trainingIntensity': trainingIntensity,
      if (wokeUpFeeling != null) 'wokeUpFeeling': wokeUpFeeling,
      if (trainingType != null) 'trainingType': trainingType,
    };
  }
}
