import 'dart:convert';
import 'package:http/http.dart' as http;

/// Matches the backend `DailyNutrientTotalRequest` DTO exactly.
class DailyNutrientTotalsApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/nutrient-totals';

  /// Build a `DailyNutrientTotalRequest`-compatible body map.
  static Map<String, dynamic> _buildBody({
    required String userId,
    required String date,
    int? plantSpeciesCount,
    double? fermentedServings,
    double? prebioticFiberG,
    double? omega3G,
    double? magnesiumMg,
    double? tryptophanMg,
    double? overallScorePct,
    int? targetPlantSpecies,
    double? targetFermented,
    double? targetFiberG,
    double? targetOmega3G,
    double? targetMagnesiumMg,
    double? targetTryptophanMg,
  }) =>
      {
        'userId': userId,
        'date': date,
        if (plantSpeciesCount != null) 'plantSpeciesCount': plantSpeciesCount,
        if (fermentedServings != null) 'fermentedServings': fermentedServings,
        if (prebioticFiberG != null) 'prebioticFiberG': prebioticFiberG,
        if (omega3G != null) 'omega3G': omega3G,
        if (magnesiumMg != null) 'magnesiumMg': magnesiumMg,
        if (tryptophanMg != null) 'tryptophanMg': tryptophanMg,
        if (overallScorePct != null) 'overallScorePct': overallScorePct,
        if (targetPlantSpecies != null) 'targetPlantSpecies': targetPlantSpecies,
        if (targetFermented != null) 'targetFermented': targetFermented,
        if (targetFiberG != null) 'targetFiberG': targetFiberG,
        if (targetOmega3G != null) 'targetOmega3G': targetOmega3G,
        if (targetMagnesiumMg != null) 'targetMagnesiumMg': targetMagnesiumMg,
        if (targetTryptophanMg != null) 'targetTryptophanMg': targetTryptophanMg,
      };

  /// Creates or updates today's daily nutrient totals row by sending a POST request to the backend.
  /// The backend's POST endpoint `/api/v1/nutrient-totals` handles upsert logic on the server.
  /// Returns true on success.
  static Future<bool> upsertTotals({
    required String userId,
    required String date,
    int? plantSpeciesCount,
    double? fermentedServings,
    double? prebioticFiberG,
    double? omega3G,
    double? magnesiumMg,
    double? tryptophanMg,
    double? overallScorePct,
    int? targetPlantSpecies,
    double? targetFermented,
    double? targetFiberG,
    double? targetOmega3G,
    double? targetMagnesiumMg,
    double? targetTryptophanMg,
  }) async {
    final body = _buildBody(
      userId: userId,
      date: date,
      plantSpeciesCount: plantSpeciesCount,
      fermentedServings: fermentedServings,
      prebioticFiberG: prebioticFiberG,
      omega3G: omega3G,
      magnesiumMg: magnesiumMg,
      tryptophanMg: tryptophanMg,
      overallScorePct: overallScorePct,
      targetPlantSpecies: targetPlantSpecies,
      targetFermented: targetFermented,
      targetFiberG: targetFiberG,
      targetOmega3G: targetOmega3G,
      targetMagnesiumMg: targetMagnesiumMg,
      targetTryptophanMg: targetTryptophanMg,
    );

    try {
      print('[DailyNutrientTotalsApiService] POSTing to $_base with body: ${jsonEncode(body)}');
      final response = await http.post(
        Uri.parse(_base),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        print('[DailyNutrientTotalsApiService] POST success: ${response.statusCode}');
        return true;
      }

      print('[DailyNutrientTotalsApiService] POST failed: ${response.statusCode} ${response.body}');
      return false;
    } catch (e) {
      print('[DailyNutrientTotalsApiService] Exception: $e');
      return false;
    }
  }

  /// Legacy helper kept for backward-compat with OfflineSyncService.
  static Future<bool> patchTotals(
      String userId, String date, Map<String, dynamic> body) async {
    return upsertTotals(
      userId: userId,
      date: date,
      plantSpeciesCount: body['plantSpeciesCount'] as int?,
      fermentedServings: (body['fermentedServings'] as num?)?.toDouble(),
      prebioticFiberG: (body['prebioticFiberG'] as num?)?.toDouble(),
      omega3G: (body['omega3G'] as num?)?.toDouble(),
      magnesiumMg: (body['magnesiumMg'] as num?)?.toDouble(),
      tryptophanMg: (body['tryptophanMg'] as num?)?.toDouble(),
      overallScorePct: (body['overallScorePct'] as num?)?.toDouble(),
      targetPlantSpecies: body['targetPlantSpecies'] as int?,
      targetFermented: (body['targetFermented'] as num?)?.toDouble(),
      targetFiberG: (body['targetFiberG'] as num?)?.toDouble(),
      targetOmega3G: (body['targetOmega3G'] as num?)?.toDouble(),
      targetMagnesiumMg: (body['targetMagnesiumMg'] as num?)?.toDouble(),
      targetTryptophanMg: (body['targetTryptophanMg'] as num?)?.toDouble(),
    );
  }

  /// Fetch today's daily nutrient totals row from the backend.
  static Future<Map<String, dynamic>?> fetchTotalsForDate(
      String userId, String date) async {
    final url = '$_base/user/$userId/date/$date';
    try {
      print('[DailyNutrientTotalsApiService] GETing from $url');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('[DailyNutrientTotalsApiService] GET success: ${response.body}');
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      print('[DailyNutrientTotalsApiService] GET failed or empty: ${response.statusCode}');
      return null;
    } catch (e) {
      print('[DailyNutrientTotalsApiService] Exception in fetchTotalsForDate: $e');
      return null;
    }
  }
}
