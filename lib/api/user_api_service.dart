import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

// ── UserApiService ────────────────────────────────────────────────────────────
// Service to consume the Spring Boot backend API for Users.

class UserApiService {
  static const String baseUrl = 'http://192.168.1.200:8080/api/users';

  // Create a new user in the backend
  static Future<UserModel?> createUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        print(
          '[UserApiService] Failed to create user: ${response.statusCode} - ${response.body}',
        );
        return null;
      }
    } catch (e, stack) {
      print('[UserApiService] Exception creating user: $e');
      print(stack);
      return null;
    }
  }

  // Get a user by ID
  static Future<UserModel?> getUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return UserModel.fromJson(jsonDecode(response.body));
        }
        return null;
      } else {
        print('[UserApiService] Failed to get user: ${response.statusCode}');
        return null;
      }
    } catch (e, stack) {
      print('[UserApiService] Exception getting user: $e');
      print(stack);
      return null;
    }
  }

  // Update last seen for a user
  static Future<void> updateLastSeen(String id) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/$id/last-seen'));
      if (response.statusCode != 200) {
        print(
          '[UserApiService] Failed to update last seen: ${response.statusCode}',
        );
      }
    } catch (e, stack) {
      print('[UserApiService] Exception updating last seen: $e');
      print(stack);
    }
  }

  // Deactivate a user
  static Future<void> deactivate(String id) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/$id/deactivate'));
      if (response.statusCode != 200) {
        print(
          '[UserApiService] Failed to deactivate user: ${response.statusCode}',
        );
      }
    } catch (e, stack) {
      print('[UserApiService] Exception deactivating user: $e');
      print(stack);
    }
  }
}
