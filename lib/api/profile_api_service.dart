import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';

// ── ProfileApiService ─────────────────────────────────────────────────────────
// Consumes the Spring Boot /api/v1/profiles REST API.
// All methods are static and return null / false on failure so the caller
// can decide how to surface errors to the user.

class ProfileApiService {
  static const String _base = 'http://192.168.1.200:8080/api/v1/profiles';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  // ── GET /api/v1/profiles/user/{userId} ─────────────────────────────────────
  // Returns null when the profile genuinely doesn't exist (HTTP 404).
  // Throws an exception on network errors or unexpected status codes so the
  // caller can distinguish "no profile" from "API unreachable".

  static Future<ProfileModel?> getProfileByUserId(String userId) async {
    final response = await http.get(Uri.parse('$_base/user/$userId'));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return ProfileModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    if (response.statusCode == 404) return null;

    throw Exception(
      'getProfileByUserId — unexpected status ${response.statusCode}',
    );
  }

  // ── GET /api/v1/profiles/{profileId} ───────────────────────────────────────

  static Future<ProfileModel?> getProfileById(String profileId) async {
    try {
      final response = await http.get(Uri.parse('$_base/$profileId'));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return ProfileModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      _log('getProfileById', response);
      return null;
    } catch (e, st) {
      _logException('getProfileById', e, st);
      return null;
    }
  }

  // ── POST /api/v1/profiles ──────────────────────────────────────────────────
  // Creates a new profile — throws 409 if one already exists.
  // Prefer upsertProfile() for safety.

  static Future<ProfileModel?> createProfile(ProfileModel profile) async {
    try {
      final response = await http.post(
        Uri.parse(_base),
        headers: _headers,
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      _log('createProfile', response);
      return null;
    } catch (e, st) {
      _logException('createProfile', e, st);
      return null;
    }
  }

  // ── PUT /api/v1/profiles/upsert ────────────────────────────────────────────
  // Safe create-or-update: creates if no profile exists, otherwise updates.
  // Only fields present in the body overwrite existing values.

  static Future<ProfileModel?> upsertProfile(ProfileModel profile) async {
    try {
      final response = await http.put(
        Uri.parse('$_base/upsert'),
        headers: _headers,
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      _log('upsertProfile', response);
      return null;
    } catch (e, st) {
      _logException('upsertProfile', e, st);
      return null;
    }
  }

  // ── PUT /api/v1/profiles/user/{userId} ─────────────────────────────────────
  // Partial update — only fields present in the body overwrite existing values.
  // userId is always injected into the body since the DTO requires it.

  static Future<ProfileModel?> updateProfile(
    String userId,
    Map<String, dynamic> fields,
  ) async {
    try {
      final body = {
        'userId': userId,
        ...fields,
      };

      final response = await http.put(
        Uri.parse('$_base/user/$userId'),
        headers: _headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      _log('updateProfile', response);
      return null;
    } catch (e, st) {
      _logException('updateProfile', e, st);
      return null;
    }
  }

  // ── PATCH /api/v1/profiles/user/{userId}/onboarding ───────────────────────
  // Marks onboarding complete (sets onboarding_completed_at = now).
  // Returns true on success, false if already done (409) or on error.

  static Future<bool> markOnboardingComplete(String userId) async {
    try {
      final response = await http.patch(
        Uri.parse('$_base/user/$userId/onboarding'),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) return true;
      if (response.statusCode == 409) return true; // already marked — not an error
      _log('markOnboardingComplete', response);
      return false;
    } catch (e, st) {
      _logException('markOnboardingComplete', e, st);
      return false;
    }
  }

  // ── DELETE /api/v1/profiles/user/{userId} ──────────────────────────────────

  static Future<bool> deleteProfile(String userId) async {
    try {
      final response = await http.delete(Uri.parse('$_base/user/$userId'));

      if (response.statusCode == 204) return true;
      _log('deleteProfile', response);
      return false;
    } catch (e, st) {
      _logException('deleteProfile', e, st);
      return false;
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  static void _log(String method, http.Response res) {
    // ignore: avoid_print
    print('[ProfileApiService] $method — ${res.statusCode}: ${res.body}');
  }

  static void _logException(String method, Object e, StackTrace st) {
    // ignore: avoid_print
    print('[ProfileApiService] $method exception: $e\n$st');
  }
}