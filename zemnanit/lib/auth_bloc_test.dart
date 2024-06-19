import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/Application/auth/auth_state.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockHttpClient mockHttpClient;

    const String baseUrl = 'http://localhost:3000';
    const String email = 'test@example.com';
    const String password = 'password';
    const String token = 'dummy_token';

    setUp(() {
      mockHttpClient = MockHttpClient();
      authBloc = AuthBloc(baseUrl: baseUrl, httpClient: mockHttpClient);
    });

    tearDown(() {
      authBloc.close();
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthLoginSuccess] when login is successful',
      build: () {
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/users/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(
              jsonEncode({'access_token': token}),
              200,
              headers: {'content-type': 'application/json; charset=utf-8'},
            ));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(email: email, password: password)),
      expect: () => [
        AuthLoginSuccess(
          message: 'Logged in successfully',
          email: email,
          access_token: token,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails with invalid credentials',
      build: () {
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/users/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(
              jsonEncode({'error': 'Invalid email or password'}),
              401,
              headers: {'content-type': 'application/json; charset=utf-8'},
            ));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(email: email, password: password)),
      expect: () => [
        AuthFailure(error: 'Invalid email or password'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [ AuthFailure] when login fails with other errors',
      build: () {
        when(mockHttpClient.post(
          Uri.parse('$baseUrl/users/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(
              jsonEncode({'error': 'Server error'}),
              500,
              headers: {'content-type': 'application/json; charset=utf-8'},
            ));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(email: email, password: password)),
      expect: () => [
        AuthFailure(
          error: 'Failed to login. Status code: 500. Error: Server error',
        ),
      ],
    );
  });
}
