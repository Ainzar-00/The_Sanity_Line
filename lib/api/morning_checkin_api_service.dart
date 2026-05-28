import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/morning_checkin_model.dart';

// ── MorningCheckinApiService ──────────────────────────────────────────────────
// Consumes the Spring Boot morning check-in endpoints.

class MorningCheckinApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/morning-checkins';

  // Submit a new morning check-in
  static Future<MorningCheckinModel?> submitCheckin(
      MorningCheckinModel checkin) async {
    try {
      final response = await http.post(
        Uri.parse(_base),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(checkin.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MorningCheckinModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
      print(
          '[MorningCheckinApiService] Submit failed: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e, stack) {
      print('[MorningCheckinApiService] Exception submitting check-in: $e');
      print(stack);
      return null;
    }
  }

  // Returns true if the backend already has a check-in for today
  static Future<bool> hasCheckinToday(String userId) async {
    final today = DateTime.now().toIso8601String().split('T').first;
    try {
      final response = await http.get(
        Uri.parse('$_base/user/$userId/date/$today'),
      );
      if (response.statusCode == 200) {
        // Backend returns the check-in object (or 404 if none)
        return response.body.isNotEmpty && response.body != 'null';
      }
      // 404 means no check-in today — that's fine
      if (response.statusCode == 404) return false;
      print(
          '[MorningCheckinApiService] hasCheckinToday failed: ${response.statusCode}');
      return false;
    } catch (e) {
      print('[MorningCheckinApiService] Exception checking today: $e');
      return false;
    }
  }
}
