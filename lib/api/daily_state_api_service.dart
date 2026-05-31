import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/daily_state_model.dart';

class DailyStateApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/daily-states';

  static Future<DailyStateModel?> getForDate(String userId, String date) async {
    try {
      final response = await http.get(
        Uri.parse('$_base/user/$userId/date/$date'),
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return DailyStateModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
      if (response.statusCode == 404) return null;
      print('[DailyStateApiService] getForDate failed: ${response.statusCode}');
      return null;
    } catch (e) {
      print('[DailyStateApiService] Exception getting daily state: $e');
      return null;
    }
  }

  /// POST /daily-states — create or update today's daily state.
  /// Returns the server-assigned model (with stateId) on success, null on failure.
  /// Callers should warn the user but NOT block the flow on null.
  static Future<DailyStateModel?> post(
      String userId, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$_base'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({...body, 'userId': userId}),
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.body.isNotEmpty) {
        return DailyStateModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
      print('[DailyStateApiService] post failed: ${response.statusCode}');
      return null;
    } catch (e) {
      print('[DailyStateApiService] Exception posting daily state: $e');
      return null;
    }
  }
}
