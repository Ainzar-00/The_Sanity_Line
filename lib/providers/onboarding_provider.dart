import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Onboarding pillar keys ─────────────────────────────────────────────────────
// Add new entries here as you introduce new onboarding pillars.
// The list ORDER defines the navigation sequence.
class OnboardingPillars {
  OnboardingPillars._();

  static const String appIntro = 'app_intro';
  static const String nutrition = 'nutrition';

  /// Ordered list of all pillars. The LAST one triggers onboardingCompletedAt.
  static const List<String> all = [appIntro, nutrition];

  static bool isLast(String pillar) => pillar == all.last;

  /// Returns the route to navigate to AFTER completing [pillar].
  static String? routeAfter(String pillar) {
    final idx = all.indexOf(pillar);
    if (idx < 0) return null;
    if (idx == all.length - 1) return '/home'; // last pillar → home
    // Map pillar key to route for the next pillar
    final next = all[idx + 1];
    return _pillarRoute[next];
  }

  static const Map<String, String> _pillarRoute = {
    appIntro: '/onboarding/app-intro',
    nutrition: '/onboarding/nutrition',
  };

  /// Returns the route for [pillar], or null if not mapped.
  static String? routeForPillar(String pillar) => _pillarRoute[pillar];
}

// ── SharedPreferences key ──────────────────────────────────────────────────────
const String _kFinishedPillars = 'onboarding_finished_pillars';

// ── OnboardingNotifier ─────────────────────────────────────────────────────────
// Holds the cumulative list of completed onboarding pillars in memory.
// Persists to SharedPreferences on every update.

class OnboardingNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  /// Load from SharedPreferences (call once after login).
  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kFinishedPillars);
    if (raw != null) {
      final list = (jsonDecode(raw) as List<dynamic>)
          .map((e) => e as String)
          .toList();
      state = list;
    }
  }

  /// Overwrite state from a list fetched from the server, and persist it.
  Future<void> loadFromServer(List<String> pillars) async {
    state = pillars;
    await _persist();
  }

  /// Append a pillar and persist.
  Future<void> complete(String pillar) async {
    if (state.contains(pillar)) return;
    state = [...state, pillar];
    await _persist();
  }

  /// Remove a pillar (rollback on API failure) and persist.
  Future<void> rollback(String pillar) async {
    if (!state.contains(pillar)) return;
    state = state.where((p) => p != pillar).toList();
    await _persist();
  }

  /// Returns true if the pillar has NOT been completed yet.
  bool isPending(String pillar) => !state.contains(pillar);

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kFinishedPillars, jsonEncode(state));
  }

  /// Clear persisted data (e.g. on logout).
  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kFinishedPillars);
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, List<String>>(OnboardingNotifier.new);
