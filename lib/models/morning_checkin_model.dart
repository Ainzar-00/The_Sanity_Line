// ── MorningCheckinModel ───────────────────────────────────────────────────────
// Mirrors the morning_checkin DB table.
// All scale fields use 1-based integers matching the backend columns.

class MorningCheckinModel {
  final String? checkinId;
  final String userId;
  final DateTime date;

  /// 1–5 mood scale
  final int? mood;

  /// 1–5 energy scale
  final int? energy;

  /// 1–5 digestion quality scale
  final int? digestionQuality;

  /// 1–5 bloating scale (1 = none, 5 = severe)
  final int? bloating;

  /// Bristol Stool Scale 1–7
  final int? stoolFormBss;

  /// Optional free-text note
  final String? notes;

  final DateTime? recordedAt;

  const MorningCheckinModel({
    this.checkinId,
    required this.userId,
    required this.date,
    this.mood,
    this.energy,
    this.digestionQuality,
    this.bloating,
    this.stoolFormBss,
    this.notes,
    this.recordedAt,
  });

  // ── Deserialisation ─────────────────────────────────────────────────────────

  factory MorningCheckinModel.fromJson(Map<String, dynamic> json) {
    return MorningCheckinModel(
      checkinId: json['checkinId'] as String?,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      mood: json['mood'] as int?,
      energy: json['energy'] as int?,
      digestionQuality: json['digestionQuality'] as int?,
      bloating: json['bloating'] as int?,
      stoolFormBss: json['stoolFormBss'] as int?,
      notes: json['notes'] as String?,
      recordedAt: json['recordedAt'] == null
          ? null
          : DateTime.tryParse(json['recordedAt'] as String),
    );
  }

  // ── Serialisation ───────────────────────────────────────────────────────────
  // Nulls omitted — backend ignores missing optional fields.

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'date': date.toIso8601String().split('T').first, // yyyy-MM-dd only
        if (mood != null) 'mood': mood,
        if (energy != null) 'energy': energy,
        if (digestionQuality != null) 'digestionQuality': digestionQuality,
        if (bloating != null) 'bloating': bloating,
        if (stoolFormBss != null) 'stoolFormBss': stoolFormBss,
        if (notes != null && notes!.trim().isNotEmpty) 'notes': notes,
      };
}
