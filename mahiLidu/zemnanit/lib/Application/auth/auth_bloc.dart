import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/Application/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final String baseUrl;
  final http.Client httpClient;

  AuthBloc({required this.baseUrl, required this.httpClient})
      : super(AuthInitial()) {
    on<SignupRequested>(_onSignupRequested);
    on<LoginRequested>(_onLoginRequested);
    on<DeleteUserRequested>(_onDeleteUserRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
  }

  Future<void> _onDeleteUserRequested(
      DeleteUserRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(loading: true));
    final email = event.email;

    try {
      final response = await httpClient.delete(
        Uri.parse('$baseUrl/users/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
        }),
      );

      if (response.statusCode == 200) {
        emit(AuthSuccess(message: "User deleted successfully"));
      } else if (response.statusCode == 404) {
        emit(AuthFailure(error: 'User not found'));
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage = responseBody['error'] ?? 'Failed to delete user';
        emit(AuthFailure(
          error:
              'Failed to delete user. Status code: ${response.statusCode}. Error: $errorMessage',
        ));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    } finally {
      emit(AuthLoading(loading: false));
    }
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(loading: true));
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
          'password': event.password,
          'fullname': event.fullname,
          'age': event.age,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuthSuccess(message: "User created successfully"));
      } else {
        emit(AuthFailure(
            error:
                'Failed to create user. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdatePasswordRequested(
      UpdatePasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(loading: true));

    try {
      final response = await httpClient.patch(
        Uri.parse('$baseUrl/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
          'password': event.oldPassword,
          'newPassword': event.newPassword,
        }),
      );

      if (response.statusCode == 200) {
        emit(AuthSuccess(message: "Password updated successfully"));
      } else if (response.statusCode == 400) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage =
            responseBody['error'] ?? 'Failed to update password';
        emit(AuthFailure(
          error:
              'Failed to update password. Status code: ${response.statusCode}. Error: $errorMessage',
        ));
      } else {
        emit(AuthFailure(
          error:
              'Failed to update password. Status code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    } finally {
      emit(AuthLoading(loading: false));
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(loading: true));

    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
          'password': event.password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final access_token = responseBody['access_token'];
        emit(AuthLoginSuccess(
          message: "Logged in successfully",
          email: event.email,
          access_token: access_token,
        ));
      } else if (response.statusCode == 401) {
        emit(AuthFailure(error: 'Invalid email or password'));
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage = responseBody['error'] ?? 'Failed to login';
        emit(AuthFailure(
          error:
              'Failed to login. Status code: ${response.statusCode}. Error: $errorMessage',
        ));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    } finally {
      emit(AuthLoading(loading: false));
    }
  }
}
