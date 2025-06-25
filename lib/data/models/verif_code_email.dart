class VerifCodeEmail {
  final int id;
  final int code;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final String? expiredAt;
  final int? userId;

  const VerifCodeEmail({
    required this.id,
    required this.code,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    this.expiredAt,
    this.userId,
  });

  factory VerifCodeEmail.fromJson(Map<String, dynamic> json) => VerifCodeEmail(
        id: json['id_verif_code_email'],
        code: json['code'],
        createdAt: DateTime.parse(json['created_at']),
        deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
        updatedAt: DateTime.parse(json['updated_at']),
        expiredAt: json['expired_at'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'id_verif_code_email': id,
        'code': code,
        'created_at': createdAt.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'expired_at': expiredAt,
        'user_id': userId,
      };
}
