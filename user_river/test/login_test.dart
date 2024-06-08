// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:zemnanit/presentation/screens/services/auth_service.dart';
// import 'package:zemnanit/presentation/screens/models/auth_state.dart';

// // Generate a MockHttpClient using the annotation
// @GenerateMocks([http.Client])
// import 'login_test.mocks.dart';

// void main() {
//   group('AuthService', () {
//     late MockClient mockClient;
//     late AuthService authService;

//     setUp(() {
//       mockClient = MockClient();
//       authService = AuthService(client: mockClient);
//     });

//     test('successful login', () async {
//       final response = {
//         'access_token': 'mockAccessToken',
//       };

//       // Mock the HTTP post response
//       when(mockClient.post(
//         Uri.parse('http://localhost:3000/users/login'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => http.Response(jsonEncode(response), 200));

//       await authService.login('test@example.com', 'password');

//       final state = authService.state;
//       expect(state.accessToken, 'mockAccessToken');
//       expect(state.email, 'test@example.com');
//       expect(state.message, 'Logged in successfully');
//       expect(state.error, isNull);
//     });

//     test('failed login with invalid credentials', () async {
//       // Mock the HTTP post response
//       when(mockClient.post(
//         Uri.parse('http://localhost:3000/users/login'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => http.Response('Invalid email or password', 401));

//       await authService.login('test@example.com', 'wrongpassword');

//       final state = authService.state;
//       expect(state.accessToken, isNull);
//       expect(state.email, isNull);
//       expect(state.error, 'Exception: Invalid email or password');
//     });

//     test('failed login with server error', () async {
//       // Mock the HTTP post response
//       when(mockClient.post(
//         Uri.parse('http://localhost:3000/users/login'),
//         headers: anyNamed('headers'),
//         body: anyNamed('body'),
//       )).thenAnswer((_) async => http.Response('Internal server error', 500));

//       await authService.login('test@example.com', 'password');

//       final state = authService.state;
//       expect(state.accessToken, isNull);
//       expect(state.email, isNull);
//       expect(state.error, 'Exception: Failed to login. Status code: 500. Error: Internal server error');
//     });
//   });
// }
