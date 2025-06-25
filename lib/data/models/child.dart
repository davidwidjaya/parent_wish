class Child {
  final int id;
  final String fullname;
  final String gender;
  final String ageCategory;
  final String schoolDay;
  final String startSchoolTime;
  final String endSchoolTime;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final int? userId;

  const Child({
    required this.id,
    required this.fullname,
    required this.gender,
    required this.ageCategory,
    required this.schoolDay,
    required this.startSchoolTime,
    required this.endSchoolTime,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    this.userId,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json['id_children'],
        fullname: json['fullname'],
        gender: json['gender'],
        ageCategory: json['age_category'],
        schoolDay: json['school_day'],
        startSchoolTime: json['start_school_time'],
        endSchoolTime: json['end_school_time'],
        createdAt: DateTime.parse(json['created_at']),
        deletedAt: json['deleted_at'] != null
            ? DateTime.tryParse(json['deleted_at'])
            : null,
        updatedAt: DateTime.parse(json['updated_at']),
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'id_children': id,
        'fullname': fullname,
        'gender': gender,
        'age_category': ageCategory,
        'school_day': schoolDay,
        'start_school_time': startSchoolTime,
        'end_school_time': endSchoolTime,
        'created_at': createdAt.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'user_id': userId,
      };
}
