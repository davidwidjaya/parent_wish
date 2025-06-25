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

class AuthSendVerificationCode extends AuthEvent {
  final String phoneNumber;

  AuthSendVerificationCode({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthVerifyCode extends AuthEvent {
  final String verificationId;
  final String smsCode;

  AuthVerifyCode({required this.verificationId, required this.smsCode});

  @override
  List<Object?> get props => [verificationId, smsCode];
}

class AuthLogout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
