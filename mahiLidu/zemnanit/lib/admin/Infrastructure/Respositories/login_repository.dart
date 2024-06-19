import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepository {
  final http.Client httpClient;

  LoginRepository({required this.httpClient});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, String> requestData = {
      'email': email,
      'password': password,
    };

    final Uri uri = Uri.parse('http://[::1]:3000/users/login');

    final http.Response response = await http.post(
      uri,
      body: jsonEncode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic>? responseData = jsonDecode(response.body);
      if (responseData != null && responseData.containsKey('access_token')) {
        return {'accessToken': responseData['access_token'], 'status': response.statusCode};
      } else {
        throw Exception('Invalid token received.');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    } else {
      throw Exception('An error occurred. Please try again later.');
    }
  }

  Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final Map<String, dynamic> decodedPayload = json.decode(payload);
    return decodedPayload;
  }

  String _decodeBase64(String str) {
    var output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
