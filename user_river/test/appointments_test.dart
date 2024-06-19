// my_appointments_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/bottomnav.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/screens/appointments.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'appointments_test.mocks.dart';

@GenerateMocks([AuthService, http.Client])
void main() {
  group('MyAppointments Widget Tests', () {
    late MockAuthService mockAuthService;
    late ProviderContainer container;

    setUp(() {
      mockAuthService = MockAuthService();
      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWith((ref) => mockAuthService),
        ],
      );
    });

    Future<void> pumpMyAppointmentsWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
overrides: [
          authServiceProvider.overrideWith((ref) => mockAuthService),
        ],
          child: MaterialApp(
            home: MyAppointments(),
          ),
        ),
      );
    }

    testWidgets('Displays loading indicator while fetching appointments', (WidgetTester tester) async {
      when(mockAuthService.fetchAppointments()).thenAnswer((_) async {
        // Simulate delay
        await Future.delayed(Duration(milliseconds: 500));
      });

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Displays appointments after fetching', (WidgetTester tester) async {
      final appointments = [
        {
          '_id': '1',
          'hairstyle': 'Hairstyle A',
          'date': '2023-06-15',
          'time': '3PM',
          'comment': 'Comment A',
        },
        {
          '_id': '2',
          'hairstyle': 'Hairstyle B',
          'date': '2023-06-16',
          'time': '4PM',
          'comment': 'Comment B',
        },
      ];

      when(mockAuthService.fetchAppointments()).thenAnswer((_) async {
        container.read(authServiceProvider.notifier).state = AuthState(appointments: appointments);
      });

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree
      await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

      expect(find.text('Hairstyle A'), findsOneWidget);
      expect(find.text('Hairstyle B'), findsOneWidget);
    });

    testWidgets('Displays error message on fetch failure', (WidgetTester tester) async {
      when(mockAuthService.fetchAppointments()).thenThrow(Exception('Failed to fetch appointments'));

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree
      await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Error: Exception: Failed to fetch appointments'), findsOneWidget);
    });

    testWidgets('Displays edit and delete buttons', (WidgetTester tester) async {
      final appointments = [
        {
          '_id': '1',
          'hairstyle': 'Hairstyle A',
          'date': '2023-06-15',
          'time': '3PM',
          'comment': 'Comment A',
        },
      ];

      when(mockAuthService.fetchAppointments()).thenAnswer((_) async {
        container.read(authServiceProvider.notifier).state = AuthState(appointments: appointments);
      });

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree
      await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('Navigates to edit appointment dialog on edit button press', (WidgetTester tester) async {
      final appointments = [
        {
          '_id': '1',
          'hairstyle': 'Hairstyle A',
          'date': '2023-06-15',
          'time': '3PM',
          'comment': 'Comment A',
        },
      ];

      when(mockAuthService.fetchAppointments()).thenAnswer((_) async {
        container.read(authServiceProvider.notifier).state = AuthState(appointments: appointments);
      });

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree
      await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle(); // Wait for the dialog to open

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('Deletes appointment on delete button press', (WidgetTester tester) async {
      final appointments = [
        {
          '_id': '1',
          'hairstyle': 'Hairstyle A',
          'date': '2023-06-15',
          'time': '3PM',
          'comment': 'Comment A',
        },
      ];

      when(mockAuthService.fetchAppointments()).thenAnswer((_) async {
        container.read(authServiceProvider.notifier).state = AuthState(appointments: appointments);
      });

      when(mockAuthService.deleteAppointment(any)).thenAnswer((_) async => {});

      await pumpMyAppointmentsWidget(tester);
      await tester.pump(); // Initial pump to build the widget tree
      await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle(); // Wait for the deletion to complete

      verify(mockAuthService.deleteAppointment('1')).called(1);
    });
  });
}
