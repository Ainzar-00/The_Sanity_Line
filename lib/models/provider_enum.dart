// ── Provider enum ─────────────────────────────────────────────────────────────
// Matches the Provider enum on the Spring Boot backend.

enum Provider {
  email,
  google;

  String get value => name;

  static Provider fromString(String s) =>
      Provider.values.firstWhere((e) => e.name == s.toLowerCase());
}
