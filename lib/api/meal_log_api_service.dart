import 'dart:convert';
import 'package:http/http.dart' as http;

// ── MealLogApiService ─────────────────────────────────────────────────────────
// Lightweight service for meal log checks (full CRUD lives on the backend).

class MealLogApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/meal-logs';

  /// Returns true if the user has at least one meal log for today.
  /// Used to gate the morning check-in — no logs means no eating yet.
  static Future<bool> hasMealLogToday(String userId) async {
    final today = DateTime.now().toIso8601String().split('T').first;
    try {
      final response = await http.get(
        Uri.parse('$_base/user/$userId/date/$today'),
      );
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List<dynamic>;
        return list.isNotEmpty;
      }
      if (response.statusCode == 404) return false;
      print('[MealLogApiService] hasMealLogToday failed: ${response.statusCode}');
      return false;
    } catch (e) {
      print('[MealLogApiService] Exception checking meal logs: $e');
      return false;
    }
  }
}
