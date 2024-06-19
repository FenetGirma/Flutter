
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'dart:convert';

class AuthService extends StateNotifier<AuthState> {
  final http.Client client;

  AuthService({required this.client}) : super(AuthState());

  final String baseUrl = 'http://localhost:3000';

  Future<void> signup(String email, String password, String fullname, String age) async {
    try {
      print('Signup started');
      state = state.copyWith(loading: true);
      final response = await client.post(
        Uri.parse('$baseUrl/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'fullname': fullname,
          'age': age,
        }),
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = state.copyWith(
          message: "User created successfully",
          loading: false,
        );
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        throw Exception('Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        loading: false,
      );
      print('Signup error: $e');
    }
    print('Signup finished with state: ${state.message}, loading: ${state.loading}, error: ${state.error}');
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true); // Set loading state

    try {
      final response = await client.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final accessToken = responseBody['access_token']; // Ensure this key exists in response
        state = state.copyWith(
          message: "Successful",
          email: email,
          accessToken: accessToken,
          loading: false,
        );
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage = responseBody['error'] ?? 'Failed to login';
        throw Exception('Failed to login. Status code: ${response.statusCode}. Error: $errorMessage');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> bookSalon(String hairstyle, String date, String time, String comment) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hairstyle': hairstyle,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AuthState(message: "Booking successful");
      } else {
        throw Exception('Failed to book salon. Status code: ${response.statusCode}. Response body: ${response.body}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> fetchAppointments() async {
   
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final appointments = json.decode(response.body);
        state = AuthState(appointments: appointments);
      } else {
        throw Exception('Failed to fetch appointments. Status code: ${response.statusCode}');
        }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> fetchSalons() async {
    state = state.copyWith(loading: true); // Set loading state

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/salons'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final salons = json.decode(response.body);
        state = state.copyWith(salons: salons, loading: false);
      } else {
        throw Exception('Failed to fetch salons. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> editAppointment(String id, String hairstyle, String date, String time, String comment) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hairstyle': hairstyle,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "Appointment updated successfully");
      } else {
        throw Exception('Failed to update appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> deleteAppointment(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "Appointment deleted successfully");
      } else {
        throw Exception('Failed to delete appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> updatePassword(String newPassword, oldPassword) async {
  final email = state.email;
  if (email == null) {
    state = state.copyWith(error: "No user logged in");
    return;
  }

  try {
    print('Updating password for email: $email');
    final response = await client.patch(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': oldPassword,
        'newPassword':newPassword,
      }),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      state = state.copyWith(message: "Password updated successfully", error: null);
    } else {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      final errorMessage = responseBody['error'] ?? 'Failed to update password';
      throw Exception('Failed to update password. Status code: ${response.statusCode}. Error: $errorMessage');
    }
  } catch (e) {
    print('Error updating password: $e');
    state = state.copyWith(error: e.toString());
  }
}

  Future<void> deleteUser() async {
    final email = state.email;
    if (email == null) {
      state = state.copyWith(error: "No user logged in");
      return;
    }

    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/users/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "User deleted successfully");
      } else {
        throw Exception('Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  void logout() {
    state = AuthState();
  }
}