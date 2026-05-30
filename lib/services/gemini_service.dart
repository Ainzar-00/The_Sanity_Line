import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/ai_meal_response_model.dart';
import '../models/profile_model.dart';
import '../models/mental_condition_model.dart';
import '../models/daily_state_model.dart';
import '../database/app_database.dart';
import 'plant_species_service.dart';

// TODO: Replace with your actual Gemini API Key or use flutter_dotenv
const _geminiApiKey = 'AQ.Ab8RN6LJUNWaPFEvZJOInu5pFCWg0DdEMNuR5sdBW-XtxVe1jQ';

class GeminiService {
  static Future<AiMealResponse> analyzeMeal({
    required ProfileModel profile,
    required List<MentalConditionModel> conditions,
    required DailyStateModel? dailyState,
    required DailyNutrientTotal? dailyTotal, // For targets and progress
    required PlantSpeciesWindow plantWindow,
    required String mealSlot,
    required String userMealDescription,
  }) async {
    final systemPrompt = _buildSystemPrompt(
      profile: profile,
      conditions: conditions,
      dailyState: dailyState,
      dailyTotal: dailyTotal,
      plantWindow: plantWindow,
      mealSlot: mealSlot,
    );

    final model = GenerativeModel(
      model: 'gemini-3.5-flash', // You can use pro if needed
      apiKey: _geminiApiKey,
      systemInstruction: Content.system(systemPrompt),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      )
    );

    try {
      final response = await model.generateContent([
        Content.text(userMealDescription)
      ]);

      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      final jsonMap = jsonDecode(text) as Map<String, dynamic>;
      return AiMealResponse.fromJson(jsonMap);
    } catch (e) {
      print('Gemini analysis failed: $e');
      rethrow;
    }
  }

  static String _buildSystemPrompt({
    required ProfileModel profile,
    required List<MentalConditionModel> conditions,
    required DailyStateModel? dailyState,
    required DailyNutrientTotal? dailyTotal,
    required PlantSpeciesWindow plantWindow,
    required String mealSlot,
  }) {
    final conditionsStr = conditions.map((c) => c.toJson().toString()).join(', ');

    return '''
You are an expert gut-brain nutrition AI.
Analyze the user's free-text meal description and output a JSON object describing its nutritional value, focusing on gut-brain axis nutrients.

User Context:
Age: ${profile.age}, Sex: ${profile.sex}, Weight: ${profile.weightKg}kg
Baseline Mood: ${profile.baselineMood}
Digestive Conditions: ${profile.digestiveConditions}
Food Sensitivities: ${profile.foodSensitivities}
Avg Sleep Hours: ${profile.avgSleepHours}
Caffeine Daily: ${profile.caffeineDailyMg}mg
Alcohol Weekly: ${profile.alcoholWeeklyUnits} units

Mental Conditions: [$conditionsStr]

Daily State (Today):
Mood: ${dailyState?.currentMood ?? 5}/5
Energy: ${dailyState?.energyLevel ?? 5}/5
Stress: ${dailyState?.stressLevel ?? 5}/5
Digestion: ${dailyState?.currentDigestion ?? 5}/5
Sleep Quality: ${dailyState?.sleepQuality ?? 5}/5
Sleep Hours: ${dailyState?.sleepHoursPrevNight ?? 8}
Physical Training: ${dailyState?.physicalTraining ?? false}
Training Type: ${dailyState?.trainingType}
Training Intensity: ${dailyState?.trainingIntensity ?? 5}/10
Alcohol Prev Night: ${dailyState?.alcoholPrevNight ?? false}
Caffeine Today: ${dailyState?.caffeineTodayMg ?? 0}mg
Water Intake: ${dailyState?.waterIntakeMl ?? 0}ml
Craving: ${dailyState?.craving}
Aversion: ${dailyState?.aversion}
Cook Time Available: ${dailyState?.cookTimeAvailableMin}min
Hours Since Last Meal: ${dailyState?.hoursSinceLastMeal}
Hunger Level: ${dailyState?.hungerLevel ?? 5}/10

Nutrient Targets (Daily):
Plant Species: ${dailyTotal?.targetPlantSpecies ?? 5}
Fiber: ${dailyTotal?.targetFiberG ?? 28}g
Fermented: ${dailyTotal?.targetFermented ?? 2} servings
Omega-3: ${dailyTotal?.targetOmega3G ?? 2}g
Magnesium: ${dailyTotal?.targetMagnesiumMg ?? 350}mg
Tryptophan: ${dailyTotal?.targetTryptophanMg ?? 400}mg

Current Progress (Today):
Plant Species: ${dailyTotal?.plantSpeciesCount ?? 0}
Fiber: ${dailyTotal?.prebioticFiberG ?? 0}g
Fermented: ${dailyTotal?.fermentedServings ?? 0} servings
Omega-3: ${dailyTotal?.omega3G ?? 0}g
Magnesium: ${dailyTotal?.magnesiumMg ?? 0}mg
Tryptophan: ${dailyTotal?.tryptophanMg ?? 0}mg

Plant Diversity Window:
Seen This Week: ${plantWindow.seenThisWeek}
Unseen This Week: ${plantWindow.unseenThisWeek}
Remaining Slots Today: ${plantWindow.remainingSlots}
Rule: Identify the plant species in the meal. Prioritize matching them against the Unseen list to count towards diversity. If a species was already seen this week, it does not count towards the new species count, but you still list it. The new species count cannot exceed Remaining Slots Today.

Meal Slot: $mealSlot

You must return ONLY a JSON object with this exact structure:
{
  "mealName": "A catchy, appealing name for the meal",
  "mealSlot": "breakfast|lunch|dinner|snack",
  "plantSpeciesList": ["list", "of", "plant", "species", "names"],
  "plantSpeciesCount": 0, // Number of NEW species, capped at remainingSlots
  "fermentedServings": 0.0,
  "magnesiumMg": 0.0,
  "omega3G": 0.0,
  "prebioticFiberG": 0.0,
  "tryptophanMg": 0.0,
  "gutBrainRationale": "A short, encouraging 2-sentence explanation of how this meal supports their specific gut-brain context (e.g. mood, sleep, digestion)."
}
''';
  }
}
