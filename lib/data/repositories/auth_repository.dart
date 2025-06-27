import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parent_wish/data/responses/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/user.dart';
import '../../utils/api_client.dart';

class AuthRepository {
  Future<RegisterResponse> registerManual({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      '/auth/register',
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    // response is a Map<String, dynamic>
    if (response['status_code'] == 201) {
      final data = response['data'];

      // Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);

      return RegisterResponse(
        user: User.fromJson(data),
        token: data['token'],
        statusCode: response['status_code'],
        message: response['message'] ?? '',
      );
    } else {
      throw Exception('Failed to register: ${response.toString()}');
    }
  }

  Future<SendEmailVerificationResponse> sendEmailVerification() async {
    final response = await ApiClient.post('/verif-code/request-code');

    if (response['status_code'] == 200) {
      final data = response['data'];

      return SendEmailVerificationResponse(
        statusCode: response['status_code'],
        message: response['message'] ?? '',
        code: data['code'],
        userId: data['user_id'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        expiredAt: data['expired_at'],
        idVerifCodeEmail: data['id_verif_code_email'],
        deletedAt: data['deleted_at'],
      );
    } else {
      throw Exception(
          'Failed to send email verification: ${response.toString()}');
    }
  }

  Future<SubmitEmailVerificationResponse> submitEmailVerification({
    required String smsCode,
  }) async {
    try {
      final response = await ApiClient.post(
        '/verif-code/validation-code',
        body: {
          'code': smsCode,
        },
      );

      return SubmitEmailVerificationResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to verify email: $e');
    }
  }

  Future<UploadImageProfileResponse> uploadImageProfile({
    required String file,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri =
        Uri.parse('${dotenv.env['API_BASE_URL']}/user/upload-image-profile');

    // Detect file extension and set mime subtype
    final extension = file.split('.').last.toLowerCase();
    String mimeSubtype;

    if (extension == 'png') {
      mimeSubtype = 'png';
    } else if (extension == 'jpg' || extension == 'jpeg') {
      mimeSubtype = 'jpeg';
    } else {
      throw Exception('Unsupported file extension: $extension');
    }

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          file,
          contentType: MediaType('image', mimeSubtype),
        ),
      );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UploadImageProfileResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to upload image profile: ${response.body}');
    }
  }

  Future<CompleteProfileResponse> completeProfile({
    required String fullname,
    required String dateOfBirth,
    required String parentType,
    required String timezone,
  }) async {
    final response = await ApiClient.post(
      '/user/complete-profile',
      body: {
        'fullname': fullname,
        'date_of_birth': dateOfBirth,
        'are_you_a': parentType,
        'timezone': timezone,
      },
    );

    if (response['status_code'] == 200) {
      return CompleteProfileResponse.fromJson(response);
    } else {
      throw Exception(
        'Failed to complete profile: ${response.toString()}',
      );
    }
  }

  Future<AddChildrenResponse> addChildren({
    required String fullname,
    required String gender,
    required String ageCategory,
    required String schoolDay,
    required String startSchoolTime,
    required String endSchoolTime,
    required String? image, // image as optional
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri = Uri.parse('${dotenv.env['API_BASE_URL']}/children/add');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['fullname'] = fullname
      ..fields['gender'] = gender
      ..fields['age_category'] = ageCategory
      ..fields['school_day'] = schoolDay
      ..fields['start_school_time'] = startSchoolTime
      ..fields['end_school_time'] = endSchoolTime;

    // Add image if available
    if (image != null && image.isNotEmpty) {
      final extension = image.split('.').last.toLowerCase();
      String mimeSubtype;

      if (extension == 'png') {
        mimeSubtype = 'png';
      } else if (extension == 'jpg' || extension == 'jpeg') {
        mimeSubtype = 'jpeg';
      } else {
        throw Exception('Unsupported image file extension: $extension');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // backend expects this key
          image,
          contentType: MediaType('image', mimeSubtype),
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return AddChildrenResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to add child: ${response.body}');
    }
  }

  Future<ListChildrenResponse> listChildren() async {
    final response = await ApiClient.get('/children/list');

    if (response['status_code'] == 200) {
      return ListChildrenResponse.fromJson(response);
    } else {
      throw Exception(
          'Failed to get children: ${response['message'] ?? 'Unknown error'}');
    }
  }

  Future<LoginResponse> loginManual({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      '/auth/login',
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
