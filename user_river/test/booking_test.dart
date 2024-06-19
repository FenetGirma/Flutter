import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:zemnanit/presentation/user_side/screens/appointments.dart';
import 'package:zemnanit/presentation/user_side/screens/booking.dart';
import 'package:zemnanit/presentation/user_side/screens/home.dart';
import 'package:zemnanit/presentation/user_side/screens/login_user.dart';
import 'package:zemnanit/presentation/user_side/screens/salonss.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';

import 'booking_test.mocks.dart';
@GenerateMocks([AuthService])
void main() {
  group('ZemnanitDrop Widget Tests', () {
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

    Future<void> pumpZemnanitDropWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWith((ref) => mockAuthService),
          ],
          child: MaterialApp(home: ZemnanitDrop()),
        ),
      );
    }

    testWidgets('Displays booking form', (WidgetTester tester) async {
      await pumpZemnanitDropWidget(tester);

      expect(find.text('Book a Salon'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Select Time'), findsOneWidget);
      expect(find.text('Select a date:'), findsOneWidget);
      expect(find.text('Book'), findsOneWidget);
    });

    testWidgets('Shows confirmation dialog on successful booking', (WidgetTester tester) async {
      await pumpZemnanitDropWidget(tester);

      await tester.enterText(find.widgetWithText(TextField, 'hairstyle'), 'Curly');
      await tester.enterText(find.widgetWithText(TextField, 'Comments'), 'No comments');

      await tester.tap(find.text('Select Time'));
      await tester.pumpAndSettle();
      
      expect(find.text('2PM'), findsOneWidget);  // Ensure the item exists before tapping
      await tester.tap(find.text('2PM'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Select a date:'));
      await tester.pumpAndSettle();
      
      // Choose a date from the date picker
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Book'));
      await tester.pumpAndSettle();

      expect(find.text('Booking Confirmed'), findsOneWidget);
      expect(find.text('Your booking has been successfully submitted.'), findsOneWidget);
    });

    testWidgets('Clears form after booking confirmation', (WidgetTester tester) async {
      await pumpZemnanitDropWidget(tester);

      await tester.enterText(find.widgetWithText(TextField, 'hairstyle'), 'Curly');
      await tester.enterText(find.widgetWithText(TextField, 'Comments'), 'No comments');

      await tester.tap(find.text('Select Time'));
      await tester.pumpAndSettle();
      
      expect(find.text('2PM'), findsOneWidget);  // Ensure the item exists before tapping
      await tester.tap(find.text('2PM'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Select a date:'));
      await tester.pumpAndSettle();
      
      // Choose a date from the date picker
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Book'));
      await tester.pumpAndSettle();

      expect(find.text('Booking Confirmed'), findsOneWidget);
      expect(find.text('Your booking has been successfully submitted.'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text(''), findsNothing);
      expect(find.text(''), findsNothing);
      expect(find.text('1PM'), findsOneWidget);
      expect(find.text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'), findsOneWidget);
    });
  });
}
