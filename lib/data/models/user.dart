class User {
  final int id;
  final String username;
  final String email;
  final String? fullname;
  final String? dateOfBirth;
  final String? areYouA;
  final String? timezone;
  final String? profileImg;
  final DateTime? verifiedAt;
  final String? step;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.fullname,
    this.dateOfBirth,
    this.areYouA,
    this.timezone,
    this.profileImg,
    this.verifiedAt,
    this.step,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id_user'],
        username: json['username'],
        email: json['email'],
        fullname: json['fullname'],
        dateOfBirth: json['date_of_birth'],
        areYouA: json['are_you_a'],
        timezone: json['timezone'],
        profileImg: json['profile_img'],
        verifiedAt: json['verified_at'] != null
            ? DateTime.tryParse(json['verified_at'])
            : null,
        step: json['step'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': id,
        'username': username,
        'email': email,
        'fullname': fullname,
        'date_of_birth': dateOfBirth,
        'are_you_a': areYouA,
        'timezone': timezone,
        'profile_img': profileImg,
        'verified_at': verifiedAt?.toIso8601String(),
        'step': step,
      };
}
