// auth_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'dart:convert';

import 'appointments_unit_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthService authService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    authService = AuthService(client: mockClient);
  });

  group('AuthService', () {
    test('signup should update state with success message on 200 response', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3000/users/signup'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 200));

      await authService.signup('test@example.com', 'password', 'John Doe', '25');

      expect(authService.state.message, equals('User created successfully'));
      expect(authService.state.loading, isFalse);
    });

    test('signup should update state with error message on failure', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3000/users/signup'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 400));

      await authService.signup('test@example.com', 'password', 'John Doe', '25');

      expect(authService.state.error, contains('Failed to create user'));
      expect(authService.state.loading, isFalse);
    });

    test('login should update state with success message and token on 200 response', () async {
      final responseBody = jsonEncode({'access_token': 'test_token'});
      when(mockClient.post(
        Uri.parse('http://localhost:3000/users/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      await authService.login('test@example.com', 'password');

      expect(authService.state.message, equals('Logged in successfully'));
      expect(authService.state.accessToken, equals('test_token'));
      expect(authService.state.loading, isFalse);
    });

    test('login should update state with error message on failure', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:3000/users/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 401));

      await authService.login('test@example.com', 'password');

      expect(authService.state.error, contains('Invalid email or password'));
      expect(authService.state.loading, isFalse);
    });

    test('fetchAppointments should update state with appointments on 200 response', () async {
      final appointments = [
        {'_id': '1', 'hairstyle': 'Hairstyle A', 'date': '2023-06-15', 'time': '3PM', 'comment': 'Comment A'},
        {'_id': '2', 'hairstyle': 'Hairstyle B', 'date': '2023-06-16', 'time': '4PM', 'comment': 'Comment B'},
      ];
      final responseBody = jsonEncode(appointments);

      when(mockClient.get(
        Uri.parse('http://localhost:3000/appointments'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      await authService.fetchAppointments();

      expect(authService.state.appointments, equals(appointments));
    });

    test('fetchAppointments should update state with error message on failure', () async {
      when(mockClient.get(
        Uri.parse('http://localhost:3000/appointments'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 400));

      await authService.fetchAppointments();

      expect(authService.state.error, contains('Failed to fetch appointments'));
    });
  });
}
