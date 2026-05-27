class MentalConditionModel {
  final String? conditionId;
  final String userId;
  final String conditionName;
  final int? severity;
  final int? durationMonths;
  final List<String>? priorityNutrients;
  final bool restrictCaffeine;
  final bool restrictSugar;
  final bool addVitaminD;
  final bool addAdaptogens;
  final bool gradualFiber;
  final bool active;

  const MentalConditionModel({
    this.conditionId,
    required this.userId,
    required this.conditionName,
    this.severity,
    this.durationMonths,
    this.priorityNutrients,
    this.restrictCaffeine = false,
    this.restrictSugar = false,
    this.addVitaminD = false,
    this.addAdaptogens = false,
    this.gradualFiber = false,
    this.active = true,
  });

  Map<String, dynamic> toJson() => {
        if (conditionId != null) 'conditionId': conditionId,
        'userId': userId,
        'conditionName': conditionName,
        if (severity != null) 'severity': severity,
        if (durationMonths != null) 'durationMonths': durationMonths,
        if (priorityNutrients != null && priorityNutrients!.isNotEmpty)
          'priorityNutrients': priorityNutrients,
        'restrictCaffeine': restrictCaffeine,
        'restrictSugar': restrictSugar,
        'addVitaminD': addVitaminD,
        'addAdaptogens': addAdaptogens,
        'gradualFiber': gradualFiber,
        'active': active,
      };

  factory MentalConditionModel.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] as Map<String, dynamic>?;
    final userId = (userMap?['userId'] ?? json['userId']) as String;

    return MentalConditionModel(
      conditionId: json['conditionId'] as String?,
      userId: userId,
      conditionName: json['conditionName'] as String,
      severity: json['severity'] as int?,
      durationMonths: json['durationMonths'] as int?,
      priorityNutrients: (json['priorityNutrients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      restrictCaffeine: json['restrictCaffeine'] as bool? ?? false,
      restrictSugar: json['restrictSugar'] as bool? ?? false,
      addVitaminD: json['addVitaminD'] as bool? ?? false,
      addAdaptogens: json['addAdaptogens'] as bool? ?? false,
      gradualFiber: json['gradualFiber'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
    );
  }
}