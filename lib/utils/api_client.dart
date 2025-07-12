import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static final _baseUrl = dotenv.env['API_BASE_URL'];
  static const _timeout = Duration(seconds: 30);

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Map<String, String>> _headers() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Uri _buildUri(String endpoint) {
    return Uri.parse('$_baseUrl$endpoint');
  }

  static Future<dynamic> get(String endpoint) async {
    final response = await http
        .get(_buildUri(endpoint), headers: await _headers())
        .timeout(_timeout);

    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final response = await http
        .post(
          _buildUri(endpoint),
          headers: await _headers(),
          body: jsonEncode(body ?? {}),
        )
        .timeout(_timeout);

    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    print('handle response: ');
    print(response.body);
    final decoded = jsonDecode(response.body);
    // print( "DECODED: $decoded");
    return decoded;

    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   return decoded;
    // } else if (response.statusCode == 401) {
    //   _clearToken(); // clear if unauthorized
    //   throw Exception('Unauthorized access. Please login again.');
    // } else {
    //   final message = decoded['message'] ?? 'Unexpected error occurred';
    //   throw Exception(message);
    // }
  }

  static Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
