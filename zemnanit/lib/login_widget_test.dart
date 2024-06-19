// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/Application/auth/auth_state.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/main.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  group('Log_in Widget', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = MockAuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    testWidgets('should show error if email or password is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          child: MaterialApp(
            home: Log_in(),
          ),
        ),
      );

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.text('Please enter both email and password'), findsOneWidget);
    });

    testWidgets('should navigate to MyAppp on successful login',
        (WidgetTester tester) async {
      whenListen(
        authBloc,
        Stream<AuthState>.fromIterable([
          AuthLoginSuccess(
              message: 'Logged in successfully',
              email: 'test@example.com',
              access_token: 'dummy_token')
        ]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          child: MaterialApp(
            home: Log_in(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.byType(MyAppp), findsOneWidget);
    });

    testWidgets('should show error message on login failure',
        (WidgetTester tester) async {
      whenListen(
        authBloc,
        Stream<AuthState>.fromIterable(
            [AuthFailure(error: 'Invalid credentials')]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          child: MaterialApp(
            home: Log_in(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
