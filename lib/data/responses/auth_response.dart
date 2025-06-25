export 'auth_response.dart';
import '../models/user.dart';
import '../models/verif_code_email.dart';

class RegisterResponse {
  final int statusCode;
  final String message;
  final User user;
  final String token;

  RegisterResponse({
    required this.statusCode,
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return RegisterResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      user: User.fromJson(data),
      token: data['token'],
    );
  }
}

class LoginResponse {
  final int statusCode;
  final String message;
  final String token;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      token: data['token'],
    );
  }
}

class VerificationCodeResponse {
  final int statusCode;
  final String message;
  final VerifCodeEmail code;

  VerificationCodeResponse({
    required this.statusCode,
    required this.message,
    required this.code,
  });

  factory VerificationCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerificationCodeResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      code: VerifCodeEmail.fromJson(json['data']),
    );
  }
}
