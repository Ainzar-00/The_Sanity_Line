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

  // ── Suggestion flow ─────────────────────────────────────────────────────────

  /// AI-generates meal suggestions.
  ///
  /// [coverMyNeeds] == true  → returns one meal per remaining slot (JSON array).
  /// [coverMyNeeds] == false → returns exactly one meal for [mealSlot].
  static Future<List<AiMealResponse>> suggestMeal({
    required ProfileModel profile,
    required List<MentalConditionModel> conditions,
    required DailyStateModel? dailyState,
    required DailyNutrientTotal? dailyTotal,
    required PlantSpeciesWindow plantWindow,
    required bool coverMyNeeds,
    String? mealSlot,
    List<String> remainingSlots = const [],
  }) async {
    final systemPrompt = _buildSystemPrompt(
      profile: profile,
      conditions: conditions,
      dailyState: dailyState,
      dailyTotal: dailyTotal,
      plantWindow: plantWindow,
      mealSlot: mealSlot ?? 'any',
      forSuggestion: true,
    );

    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: _geminiApiKey,
      systemInstruction: Content.system(systemPrompt),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );

    final String userMessage;
    if (coverMyNeeds) {
      final slotsStr = remainingSlots.isNotEmpty
          ? 'Remaining meal slots today: ${remainingSlots.join(', ')}.'
          : 'All meal slots (breakfast, lunch, dinner, snack) are still open today.';
      userMessage =
          'Cover my nutritional gaps today. $slotsStr '
          'Look at my current nutrient progress vs targets and find what is missing. '
          'Suggest one meal per remaining unfilled slot. Each meal must target the biggest remaining gap. '
          'Return a JSON ARRAY of meal objects, each with the exact structure described in the system prompt.';
    } else {
      userMessage =
          'Suggest one meal for slot: ${mealSlot ?? 'any'}. '
          'Return a single JSON meal object with the exact structure described in the system prompt.';
    }

    try {
      final response = await model.generateContent([Content.text(userMessage)]);
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      if (coverMyNeeds) {
        final decoded = jsonDecode(text);
        if (decoded is List) {
          return decoded
              .map((e) => AiMealResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        // Graceful fallback: AI returned a single object → wrap it
        if (decoded is Map<String, dynamic>) {
          return [AiMealResponse.fromJson(decoded)];
        }
        throw Exception('Unexpected response format from Gemini');
      } else {
        final jsonMap = jsonDecode(text) as Map<String, dynamic>;
        return [AiMealResponse.fromJson(jsonMap)];
      }
    } catch (e) {
      print('Gemini suggestion failed: $e');
      rethrow;
    }
  }

  // ── Prompt builder ──────────────────────────────────────────────────────────

  static String _buildSystemPrompt({
    required ProfileModel profile,
    required List<MentalConditionModel> conditions,
    required DailyStateModel? dailyState,
    required DailyNutrientTotal? dailyTotal,
    required PlantSpeciesWindow plantWindow,
    required String mealSlot,
    bool forSuggestion = false,
  }) {
    final conditionsStr = conditions.map((c) => c.toJson().toString()).join(', ');

    final taskDescription = forSuggestion
        ? 'You are an expert gut-brain nutrition AI.\n'
          'Generate meal suggestions tailored to the user\'s gut-brain nutritional needs.\n'
          'Focus on filling nutrient gaps and supporting the user\'s mental and digestive health.'
        : 'You are an expert gut-brain nutrition AI.\n'
          'Analyze the user\'s free-text meal description and output a JSON object describing '
          'its nutritional value, focusing on gut-brain axis nutrients.';

    final jsonSchema = forSuggestion
        ? '''
You must return ONLY a JSON object (or array of JSON objects) with this exact structure per meal:
{
  "mealName": "A catchy, appealing name for the meal",
  "mealSlot": "breakfast|lunch|dinner|snack",
  "ingredients": ["ingredient 1 with quantity", "ingredient 2 with quantity"],
  "instructions": "Brief step-by-step preparation instructions (2-4 sentences).",
  "plantSpeciesList": ["list", "of", "plant", "species", "names"],
  "plantSpeciesCount": 0,
  "fermentedServings": 0.0,
  "magnesiumMg": 0.0,
  "omega3G": 0.0,
  "prebioticFiberG": 0.0,
  "tryptophanMg": 0.0,
  "gutBrainRationale": "A short, encouraging 2-sentence explanation of how this meal supports their specific gut-brain context."
}'''
        : '''
You must return ONLY a JSON object with this exact structure:
{
  "mealName": "A catchy, appealing name for the meal",
  "mealSlot": "breakfast|lunch|dinner|snack",
  "plantSpeciesList": ["list", "of", "plant", "species", "names"],
  "plantSpeciesCount": 0,
  "fermentedServings": 0.0,
  "magnesiumMg": 0.0,
  "omega3G": 0.0,
  "prebioticFiberG": 0.0,
  "tryptophanMg": 0.0,
  "gutBrainRationale": "A short, encouraging 2-sentence explanation of how this meal supports their specific gut-brain context (e.g. mood, sleep, digestion)."
}''';

    return '''
$taskDescription

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
Mood: ${dailyState?.currentMood ?? 5}/10
Energy: ${dailyState?.energyLevel ?? 5}/10
Stress: ${dailyState?.stressLevel ?? 5}/10
Digestion: ${dailyState?.currentDigestion ?? 5}/10
Sleep Quality: ${dailyState?.sleepQuality ?? 5}/10
Sleep Hours: ${dailyState?.sleepHoursPrevNight ?? 8}
Hunger: ${dailyState?.hungerLevel ?? 5}/10
Hours Since Last Meal: ${dailyState?.hoursSinceLastMeal ?? 'unknown'}
Physical Training: ${dailyState?.physicalTraining ?? false}
Training Type: ${dailyState?.trainingType}
Training Duration: ${dailyState?.trainingDurationMin}min
Training Intensity: ${dailyState?.trainingIntensity ?? 5}/10
Alcohol Prev Night: ${dailyState?.alcoholPrevNight ?? false}
Caffeine Today: ${dailyState?.caffeineTodayMg ?? 0}mg
Water Intake: ${dailyState?.waterIntakeMl ?? 0}ml
Craving: ${dailyState?.craving ?? 'none'}
Aversion: ${dailyState?.aversion ?? 'none'}
Cook Time Available: ${dailyState?.cookTimeAvailableMin}min

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

$jsonSchema
''';
  }
}
