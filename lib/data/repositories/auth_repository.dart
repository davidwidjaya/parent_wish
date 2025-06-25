import 'dart:convert';

import 'package:parent_wish/data/responses/auth_response.dart';

import '../models/user.dart';
import '../../utils/api_client.dart';

class AuthRepository {
  Future<RegisterResponse> registerManual({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      '/api/auth/register',
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return RegisterResponse(
        user: User.fromJson(data),
        token: data['token'],
        statusCode: response.statusCode,
        message: data['message'] ?? '',
      );
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<LoginResponse> loginManual({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      '/api/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse(
        token: data['token'],
        statusCode: response.statusCode,
        message: data['message'] ?? '',
      );
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
