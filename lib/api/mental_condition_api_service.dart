import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mental_condition_model.dart';

class MentalConditionApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/mental-conditions';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  static Future<bool> saveCondition(MentalConditionModel condition) async {
    try {
      final response = await http.post(
        Uri.parse(_base),
        headers: _headers,
        body: jsonEncode(condition.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      print('Failed to save mental condition. Status code: ${response.statusCode}');
      return false;
    } catch (e) {
      print('Exception saving mental condition: $e');
      return false;
    }
  }
}
