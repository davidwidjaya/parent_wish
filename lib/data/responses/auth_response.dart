export 'auth_response.dart';
import 'package:parent_wish/data/models/child.dart';
import 'package:parent_wish/data/models/task.dart';

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
      statusCode: json['status_code'],
      message: json['message'],
      user: User.fromJson(data),
      token: data['token'],
    );
  }
}

class RegisterGoogleResponse {
  final String token;
  final int statusCode;
  final String message;

  RegisterGoogleResponse({
    required this.token,
    required this.statusCode,
    required this.message,
  });

  factory RegisterGoogleResponse.fromJson(Map<String, dynamic> json) {
    return RegisterGoogleResponse(
      token: json['data']['token'],
      statusCode: json['status_code'],
      message: json['message'] ?? '',
    );
  }
}

class SendEmailVerificationResponse {
  final int statusCode;
  final String message;
  final int code;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final String? expiredAt;
  final int idVerifCodeEmail;
  final String? deletedAt;

  SendEmailVerificationResponse({
    required this.statusCode,
    required this.message,
    required this.code,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.expiredAt,
    required this.idVerifCodeEmail,
    this.deletedAt,
  });

  factory SendEmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SendEmailVerificationResponse(
      statusCode: json['status_code'],
      message: json['message'],
      code: data['code'],
      userId: data['user_id'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      expiredAt: data['expired_at'],
      idVerifCodeEmail: data['id_verif_code_email'],
      deletedAt: data['deleted_at'],
    );
  }
}

class SubmitEmailVerificationResponse {
  final int statusCode;
  final String message;
  final User data;

  SubmitEmailVerificationResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SubmitEmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return SubmitEmailVerificationResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data: User.fromJson(json['data']),
    );
  }
}

class CompleteProfileResponse {
  final int statusCode;
  final String message;
  final User data;

  CompleteProfileResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data: User.fromJson(json['data']),
    );
  }
}

class UploadImageProfileResponse {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? data; // nullable

  UploadImageProfileResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory UploadImageProfileResponse.fromJson(Map<String, dynamic> json) {
    return UploadImageProfileResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}

class AddChildrenResponse {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? data;

  AddChildrenResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory AddChildrenResponse.fromJson(Map<String, dynamic> json) {
    return AddChildrenResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}

class ListChildrenResponse {
  final int statusCode;
  final String message;
  final List<Child> children;

  ListChildrenResponse({
    required this.statusCode,
    required this.message,
    required this.children,
  });

  factory ListChildrenResponse.fromJson(Map<String, dynamic> json) {
    final childrenData = json['data'] as List<dynamic>;
    final children =
        childrenData.map((child) => Child.fromJson(child)).toList();

    return ListChildrenResponse(
      statusCode: json['status_code'],
      message: json['message'],
      children: children,
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
      statusCode: json['status_code'],
      message: json['message'],
      token: data['token'],
    );
  }
}

class ForgotPasswordResponse {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? data;

  ForgotPasswordResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    // final data = json['data'];
    return ForgotPasswordResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}

class VerifyForgotPasswordResponse {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? data;

  VerifyForgotPasswordResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory VerifyForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    // final data = json['data'];
    return VerifyForgotPasswordResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}

class AddTaskResponse {
  final int statusCode;
  final String message;
  final Task? data;

  AddTaskResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory AddTaskResponse.fromJson(Map<String, dynamic> json) {
    return AddTaskResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null ? Task.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}
