import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  final http.Client httpClient;

  UserRepository({required this.httpClient});

  Future<List> fetchUsers(String accessToken) async {
    final url = 'http://localhost:3000/users';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> updateUserRole(String accessToken, String email, String newRole) async {
    final url = 'http://localhost:3000/users/update-role';
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({'email': email, 'role': newRole}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user role');
    }
  }

  Future<void> deleteUser(String accessToken, String email) async {
    final url = 'http://localhost:3000/users/$email';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
