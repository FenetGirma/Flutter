import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'user_login_unit_test.mocks.dart';
import 'package:mockito/annotations.dart';
@GenerateMocks([http.Client])
void main() {
  group('AuthService', () {
    late MockClient mockClient;
    late AuthService authService;
    late ProviderContainer container;

    setUp(() {
      mockClient = MockClient();
      authService = AuthService(client: mockClient);
      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWith((ref) => authService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state should be AuthState with default values', () {
      final authState = container.read(authServiceProvider);
      expect(authState.loading, false);
      expect(authState.message, '');
      expect(authState.error, isNull);
      expect(authState.accessToken, isNull);
    });

    test('Successful login updates state with access token', () async {
      final email = 'test@example.com';
      final password = 'password123';
      final mockAccessToken = 'mockAccessToken';

      // Mock the login method to return a successful response
      when(mockClient.post(
        any as Uri,
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"token": "$mockAccessToken"}', 200));

      // Call the login method
      await container.read(authServiceProvider.notifier).login(email, password);

      // Verify that the state has been updated correctly
      final authState = container.read(authServiceProvider);
      expect(authState.loading, false);
      expect(authState.accessToken, mockAccessToken);
      expect(authState.error, isNull);
    });

    test('Failed login updates state with error message', () async {
      final email = 'test@example.com';
      final password = 'wrongpassword';
      final mockErrorMessage = 'Invalid credentials';

      // Mock the login method to return a failed response
      when(mockClient.post(
        any as Uri,
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"error": "$mockErrorMessage"}', 401));

      // Call the login method
      await container.read(authServiceProvider.notifier).login(email, password);

      // Verify that the state has been updated correctly
      final authState = container.read(authServiceProvider);
      expect(authState.loading, false);
      expect(authState.accessToken, isNull);
      expect(authState.error, mockErrorMessage);
    });
  });
}
