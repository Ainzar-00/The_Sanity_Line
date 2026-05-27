import 'provider_enum.dart';

// ── UserModel ─────────────────────────────────────────────────────────────────
// Mirrors the Spring Boot User entity exactly.

class UserModel {
  final String userId;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final Provider provider;
  final String? timezone;
  final DateTime? createdAt;
  final DateTime? lastSeenAt;
  final bool isActive;

  const UserModel({
    required this.userId,
    required this.provider,
    this.email,
    this.displayName,
    this.photoUrl,
    this.timezone,
    this.createdAt,
    this.lastSeenAt,
    this.isActive = true,
  });

  UserModel copyWith({
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    Provider? provider,
    String? timezone,
    DateTime? createdAt,
    DateTime? lastSeenAt,
    bool? isActive,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      provider: provider ?? this.provider,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      isActive: isActive ?? this.isActive,
    );
  }

  // ── Deserialisation ─────────────────────────────────────────────────────────

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'] as String,
        email: json['email'] as String?,
        displayName: json['displayName'] as String?,
        photoUrl: json['photoUrl'] as String?,
        provider: Provider.fromString(json['provider'] as String),
        timezone: json['timezone'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt'] as String),
        lastSeenAt: json['lastSeenAt'] == null
            ? null
            : DateTime.tryParse(json['lastSeenAt'] as String),
        isActive: json['isActive'] as bool? ?? true,
      );

  // ── Serialisation ───────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'userId': userId,
        if (email != null) 'email': email,
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'photoUrl': photoUrl,
        'provider': provider.value,
        if (timezone != null) 'timezone': timezone,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (lastSeenAt != null) 'lastSeenAt': lastSeenAt!.toIso8601String(),
        'isActive': isActive,
      };
}
