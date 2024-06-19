
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/screens/home.dart';
import 'package:zemnanit/presentation/user_side/screens/login_user.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'dart:convert';

import 'user_login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Log_in Widget Tests', () {
    late MockClient mockClient;
    late ProviderContainer container;

    setUp(() {
      mockClient = MockClient();
      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
        ],
      );
    });

    Future<void> pumpLoginWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
          ],
          child: MaterialApp(home: Log_in()),
        ),
      );
    }

    testWidgets('Displays login form', (WidgetTester tester) async {
      await pumpLoginWidget(tester);

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('Shows error message on login failure', (WidgetTester tester) async {
  when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
      .thenAnswer((_) async => http.Response('Unauthorized', 401));

  await pumpLoginWidget(tester);

  await tester.enterText(find.byType(TextField).first, 'test@example.com');
  await tester.enterText(find.byType(TextField).last, 'password');
  await tester.tap(find.byKey(ValueKey('loginButton')));
  await tester.pumpAndSettle();

  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text('Invalid email or password'), findsOneWidget);
});


    testWidgets('Navigates to HomePage on successful login', (WidgetTester tester) async {
      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(jsonEncode({'access_token': 'dummy_token'}), 200));

      await pumpLoginWidget(tester);

      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');
      await tester.tap(find.byKey(ValueKey('loginButton')));
      await tester.pumpAndSettle();

      expect(find.byType(Home), findsOneWidget);
    });
  });
}
