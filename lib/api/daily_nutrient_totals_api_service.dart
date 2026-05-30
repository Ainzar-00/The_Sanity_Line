import 'dart:convert';
import 'package:http/http.dart' as http;

class DailyNutrientTotalsApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/daily-totals';

  static Future<bool> patchTotals(
      String userId, String date, Map<String, dynamic> body) async {
    try {
      final response = await http.patch(
        Uri.parse('$_base/user/$userId/date/$date'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }
      print(
          '[DailyNutrientTotalsApiService] patchTotals failed: ${response.statusCode}');
      return false;
    } catch (e) {
      print('[DailyNutrientTotalsApiService] Exception patching totals: $e');
      return false;
    }
  }
}
