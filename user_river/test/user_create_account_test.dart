import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/screens/home.dart';
import 'package:zemnanit/presentation/user_side/screens/create_user.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'dart:convert';

import 'user_create_account_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('CreateUser Widget Tests', () {
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

    Future<void> pumpCreateUserWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
          ],
          child: MaterialApp(home: CreateUser()),
        ),
      );
    }

    testWidgets('Displays create account form', (WidgetTester tester) async {
      await pumpCreateUserWidget(tester);

      expect(find.text('Enter your Full Name'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Enter your age'), findsOneWidget);
      expect(find.text('Enter your password'), findsOneWidget);
      expect(find.text('Confirm your password'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);
    });

    testWidgets('Shows error message on create account failure', (WidgetTester tester) async {
      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      await pumpCreateUserWidget(tester);

      await tester.enterText(find.widgetWithText(TextField, 'Enter your Full Name'), 'John Doe');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your email'), 'johndoe@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your age'), '25');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your password'), 'password123');
      await tester.enterText(find.widgetWithText(TextField, 'Confirm your password'), 'password123');

      await tester.ensureVisible(find.text('Create Account'));
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Failed to create account'), findsOneWidget);
    });

    testWidgets('Navigates to HomePage on successful account creation', (WidgetTester tester) async {
      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(jsonEncode({'access_token': 'dummy_token'}), 200));

      await pumpCreateUserWidget(tester);

      await tester.enterText(find.widgetWithText(TextField, 'Enter your Full Name'), 'John Doe');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your email'), 'johndoe@example.com');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your age'), '25');
      await tester.enterText(find.widgetWithText(TextField, 'Enter your password'), 'password123');
      await tester.enterText(find.widgetWithText(TextField, 'Confirm your password'), 'password123');

      await tester.ensureVisible(find.text('Create Account'));
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();

      expect(find.byType(Home), findsOneWidget);
    });
  });
}
