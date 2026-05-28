enum Provider {
  google('GOOGLE'),
  email('EMAIL'),
  apple('APPLE');

  final String value;
  const Provider(this.value);

  // ✅ static method, not a constructor
  static Provider fromString(String value) =>
      Provider.values.firstWhere(
        (e) => e.value == value,
        orElse: () => throw ArgumentError('Unknown provider: $value'),
      );
}