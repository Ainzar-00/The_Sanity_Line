import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../models/profile_model.dart';
import '../models/mental_condition_model.dart';
import '../models/daily_state_model.dart';
import '../models/nutrition_targets.dart';

class NutrientTargetService {
  static NutritionTargets computeTargets(
    ProfileModel profile,
    List<MentalConditionModel> conditions,
    DailyStateModel? dailyState,
  ) {
    // 1. Base values (use neutral defaults if dailyState is null)
    final sex = profile.sex?.toLowerCase() ?? 'male';
    final weightKg = profile.weightKg ?? 70.0;
    
    // Neutral defaults
    final currentMood = dailyState?.currentMood ?? 5;
    final currentDigestion = dailyState?.currentDigestion ?? 5;
    final stressLevel = dailyState?.stressLevel ?? 5;
    final physicalTraining = dailyState?.physicalTraining ?? false;
    final trainingIntensity = dailyState?.trainingIntensity ?? 5;
    final alcoholPrevNight = dailyState?.alcoholPrevNight ?? false;

    // 2. Compute Plant Species
    int plantSpecies = 5;
    if (profile.digestiveConditions != null &&
        profile.digestiveConditions!.isNotEmpty) {
      plantSpecies = 3;
    }
    if (currentDigestion <= 3) {
      plantSpecies = 2;
    }

    // 3. Compute Fiber
    double fiberG = sex == 'female' ? 25.0 : 38.0;
    if (conditions.any((c) => c.gradualFiber)) {
      fiberG *= 0.70;
    }
    if (currentDigestion <= 3) {
      fiberG *= 0.80;
    }

    // 4. Compute Fermented
    double fermented = 2.0;
    if (conditions.any((c) => c.addAdaptogens)) {
      fermented = 3.0;
    }
    if (currentDigestion <= 3) {
      fermented = 1.0;
    }
    if (alcoholPrevNight) {
      fermented = 0.0;
    }

    // 5. Compute Omega-3
    double omega3G = sex == 'female' ? 1.1 : 1.6;
    if (conditions.any((c) =>
        c.conditionName.toLowerCase().contains('depression') ||
        c.conditionName.toLowerCase().contains('anxiety'))) {
      omega3G = 2.5;
    }
    if (physicalTraining) {
      omega3G += 0.5;
    }

    // 6. Compute Magnesium
    double magnesiumMg = sex == 'female' ? 320.0 : 420.0;
    if (stressLevel >= 7) {
      magnesiumMg *= 1.15;
    }
    if (trainingIntensity >= 7) {
      magnesiumMg *= 1.10;
    }

    // 7. Compute Tryptophan
    double tryptophanMg = 5.0 * weightKg;
    if ((profile.baselineMood ?? 5) <= 4) {
      tryptophanMg *= 1.10;
    }
    if (currentMood <= 3) {
      tryptophanMg *= 1.10;
    }

    return NutritionTargets(
      plantSpecies: plantSpecies,
      fiberG: fiberG,
      fermented: fermented,
      omega3G: omega3G,
      magnesiumMg: magnesiumMg,
      tryptophanMg: tryptophanMg,
    );
  }

  static String buildContextHash(
    String userId,
    ProfileModel profile,
    List<MentalConditionModel> conditions,
    DailyStateModel? dailyState,
  ) {
    final profileUpdatedAt = profile.profileId ?? ''; // using id as proxy or any other stable field
    
    // Sort conditions to ensure stable hash
    final conditionNames = conditions.map((c) => c.conditionName).toList()..sort();
    final conditionsHash = conditionNames.join('|');
    
    final dailyStateRecordedAt = dailyState?.recordedAt?.toIso8601String() ?? '';

    final rawStr = '$userId|$profileUpdatedAt|$conditionsHash|$dailyStateRecordedAt';
    final bytes = utf8.encode(rawStr);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
