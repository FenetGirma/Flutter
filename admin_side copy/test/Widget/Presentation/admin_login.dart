import 'package:admin_side/Application/login_page/login_bloc.dart';
import 'package:admin_side/Presentation/admin_dashboard.dart';
import 'package:admin_side/Presentation/login_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:admin_side/Infrastructure/Respositories/login_repository.dart';
import 'admin_login.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  group('AdminLoginPage Tests', () {
    late AdminLoginBloc loginBloc;
    late MockLoginRepository mockLoginRepository;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginBloc = AdminLoginBloc(loginRepository: mockLoginRepository);
    });

    tearDown(() {
      loginBloc.dispose();
    });

    Future<void> buildLoginPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AdminLoginBloc>.value(
            value: loginBloc,
            child: AdminLoginPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('should display error message on login failure',
        (WidgetTester tester) async {
      when(mockLoginRepository.login(any, any))
          .thenThrow(Exception('Login failed'));

      await buildLoginPage(tester);

      // Enter email and password
      await tester.enterText(find.byType(TextField).at(0), 'admin@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap on 'Login' button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that error message is shown
      expect(find.text('Exception: Login failed'), findsOneWidget);
    });

    testWidgets('should navigate to AdminDashboard on successful login',
        (WidgetTester tester) async {
      when(mockLoginRepository.login(any, any)).thenAnswer((_) async {
        return {'accessToken': 'dummy_token'};
      });
      when(mockLoginRepository.decodeToken('dummy_token'))
          .thenReturn({'role': 'Admin'});

      await buildLoginPage(tester);

      // Enter email and password
      await tester.enterText(find.byType(TextField).at(0), 'admin@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap on 'Login' button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that we navigated to AdminDashboard
      expect(find.byType(AdminDashboard),
          findsOneWidget); // Replace with your actual navigation target
    });
  });
}
