import 'package:admin_side/Application/login_page/login_bloc.dart';
import 'package:admin_side/Infrastructure/Respositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate the Mock class using the @GenerateMocks annotation
import '../Widget/Presentation/admin_login.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  group('AdminLoginBloc Tests', () {
    late MockLoginRepository mockLoginRepository;
    late AdminLoginBloc loginBloc;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginBloc = AdminLoginBloc(loginRepository: mockLoginRepository);
    });

    tearDown(() {
      loginBloc.dispose();
    });

    test('Initial state is correct', () {
      expect(loginBloc.isLoading, false);
      expect(loginBloc.errorMessage, '');
    });

    testWidgets('Login success with admin role', (WidgetTester tester) async {
      when(mockLoginRepository.login(any, any))
          .thenAnswer((_) async => {'accessToken': 'dummy_token'});
      when(mockLoginRepository.decodeToken('dummy_token'))
          .thenReturn({'role': 'Admin'});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                loginBloc.emailController.text = 'admin@email.com';
                loginBloc.passwordController.text = '12345678';

                // Trigger login
                loginBloc.loginAdmin(context);

                return Container();
              },
            ),
          ),
        ),
      );

      await tester.pump(); // Wait for the login process to complete

      expect(loginBloc.isLoading, false);
      expect(loginBloc.errorMessage, '');
      verify(mockLoginRepository.login('admin@email.com', '12345678'))
          .called(1);
    });

    testWidgets('Login failure with incorrect role',
        (WidgetTester tester) async {
      when(mockLoginRepository.login(any, any))
          .thenAnswer((_) async => {'accessToken': 'dummy_token'});
      when(mockLoginRepository.decodeToken('dummy_token'))
          .thenReturn({'role': 'User'});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                loginBloc.emailController.text = 'user@example.com';
                loginBloc.passwordController.text = '12345678';

                // Trigger login
                loginBloc.loginAdmin(context);

                return Container();
              },
            ),
          ),
        ),
      );

      await tester.pump(); // Wait for the login process to complete

      expect(loginBloc.isLoading, false);
      expect(loginBloc.errorMessage,
          'You are not authorized to access the admin panel.');
      verify(mockLoginRepository.login('user@example.com', '12345678'))
          .called(1);
    });

    testWidgets('Login failure with exception', (WidgetTester tester) async {
      when(mockLoginRepository.login(any, any))
          .thenThrow(Exception('Login failed'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                loginBloc.emailController.text = 'admin@email.com';
                loginBloc.passwordController.text = '12345678';

                // Trigger login
                loginBloc.loginAdmin(context);

                return Container();
              },
            ),
          ),
        ),
      );

      await tester.pump(); // Wait for the login process to complete

      expect(loginBloc.isLoading, false);
      expect(loginBloc.errorMessage, 'Exception: Login failed');
      verify(mockLoginRepository.login('admin@email.com', '12345678'))
          .called(1);
    });
  });
}
