// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';

// Mock class for http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('BookingRepo', () {
    test('fetchAppointments returns a list of bookings on successful request',
        () async {
      // Arrange
      final client = MockClient();
      final bookingRepo = BookingRepo();
      final bookingsJson = [
        {
          'id': '1',
          'hairstyle': 'Haircut',
          'date': '2023-06-17T10:00:00.000Z',
          'time': '10:00 AM',
          'comment': 'Regular haircut',
          // 'user': 'John Doe',
        },
        {
          'id': '2',
          'hairstyle': 'Haircut',
          'date': '2023-06-18T11:00:00.000Z',
          'time': '11:00 AM',
          'comment': 'Another haircut',
          // 'user': 'Jane Doe',
        },
      ];
      final bookingsResponse = jsonEncode(bookingsJson);

      when(client.get(Uri.parse('http://localhost:3000/appointments')))
          .thenAnswer((_) async => http.Response(bookingsResponse, 200));

      // Act
      final result = await BookingRepo.fetchAppointments();

      // Assert
      expect(result, isA<List<BookingModel>>());
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].id, '2');
    });

    test('fetchAppointments returns an empty list on error', () async {
      // Arrange
      final client = MockClient();
      final bookingRepo = BookingRepo();

      when(client.get(Uri.parse('http://localhost:3000/appointments')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final result = await BookingRepo.fetchAppointments();

      // Assert
      expect(result, isA<List<BookingModel>>());
      expect(result, isEmpty);
    });
  });
}
