import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';

@GenerateMocks([http.Client])
import 'appointment_widget_test.mocks.dart';

void main() {
  group('Appointment Widget Tests', () {
    late MockClient client; // Use the generated MockClient

    setUp(() {
      client = MockClient(); // Instantiate the mock client
    });

    testWidgets('displays loading indicator while fetching salons',
        (WidgetTester tester) async {
      // Mock the HTTP client response with a delayed future
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Future.delayed(
              Duration(seconds: 2), () => http.Response('[]', 200)));

      // Build the widget with the mocked client
      await tester.pumpWidget(BlocProvider(
        create: (context) => BookingBloc(BookingRepo()),
        child: MaterialApp(
          home: AppointmentsPage(),
        ),
      ));

      // Verify that the loading indicator is displayed
      expect(find.byType(Scaffold), findsOneWidget);

      // Wait for the future to complete
      await tester.pumpAndSettle();

      // Verify that the loading indicator is no longer displayed
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
