part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthRegisterManual extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthRegisterManual(
      {required this.username, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSendEmailVerificationCode extends AuthEvent {
  AuthSendEmailVerificationCode();

  @override
  List<Object?> get props => [];
}

class AuthSubmitEmailVerificationCode extends AuthEvent {
  final String smsCode;

  AuthSubmitEmailVerificationCode({required this.smsCode});

  @override
  List<Object?> get props => [smsCode];
}

class AuthUploadImageProfile extends AuthEvent {
  final String file;

  AuthUploadImageProfile({
    required this.file,
  });

  @override
  List<Object?> get props => [
        file,
      ];
}

class AuthCompleteProfile extends AuthEvent {
  final String fullname;
  final String dateOfBirth;
  final String parentType;
  final String timezone;

  AuthCompleteProfile({
    required this.fullname,
    required this.dateOfBirth,
    required this.parentType,
    required this.timezone,
  });

  @override
  List<Object?> get props => [
        fullname,
        dateOfBirth,
        parentType,
        timezone,
      ];
}

class AuthAddChildren extends AuthEvent {
  final String fullname;
  final String gender;
  final String ageCategory;
  final String schoolDay;
  final String startSchoolTime;
  final String endSchoolTime;
  final String image;

  AuthAddChildren({
    required this.fullname,
    required this.gender,
    required this.ageCategory,
    required this.schoolDay,
    required this.startSchoolTime,
    required this.endSchoolTime,
    required this.image,
  });

  @override
  List<Object?> get props => [
        fullname,
        gender,
        ageCategory,
        schoolDay,
        startSchoolTime,
        endSchoolTime,
        image,
      ];
}

class AuthLoginManual extends AuthEvent {
  final String email;
  final String password;

  AuthLoginManual({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterGoogle extends AuthEvent {
  final String email;
  final String name;
  final String imageUrl;

  AuthRegisterGoogle({
    required this.email,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [email, name, imageUrl];
}

class AuthRegisterFacebook extends AuthEvent {
  final String email;
  final String name;
  final String imageUrl;

  AuthRegisterFacebook({
    required this.email,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [email, name, imageUrl];
}

class AuthLogout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
