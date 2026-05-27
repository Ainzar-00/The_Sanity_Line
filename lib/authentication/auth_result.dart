// ── AuthResult ────────────────────────────────────────────────────────────────
// Returned by every AuthService method so the UI layer never needs to
// catch Firebase exceptions or know about Firebase internals.

class AuthResult {
  final bool success;
  final String? errorMessage;

  /// On success, the route the screen should navigate to (e.g. '/home').
  final String? route;

  /// Optional arguments forwarded to the named route (e.g. userId for /assessment).
  final Object? routeArguments;

  const AuthResult._({
    required this.success,
    this.errorMessage,
    this.route,
    this.routeArguments,
  });

  factory AuthResult.ok({String? route, Object? routeArguments}) =>
      AuthResult._(success: true, route: route, routeArguments: routeArguments);

  factory AuthResult.error(String errorMessage) =>
      AuthResult._(success: false, errorMessage: errorMessage);
}
