import 'dart:convert';
import 'package:http/http.dart' as http;

class MealApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/meals';

  static Future<bool> createMeal(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(_base),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      print('[MealApiService] createMeal failed: ${response.statusCode}');
      return false;
    } catch (e) {
      print('[MealApiService] Exception creating meal: $e');
      return false;
    }
  }
}
