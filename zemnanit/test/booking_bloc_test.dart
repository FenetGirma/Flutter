import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_state.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'booking_bloc_test.mocks.dart'; // Import the manually created mock class

void main() {
  late BookingRepo bookingRepo;
  late BookingBloc bookingBloc;

  setUp(() {
    bookingRepo = MockBookingRepo();
    bookingBloc = BookingBloc(bookingRepo);
  });

  tearDown(() {
    bookingBloc.close();
  });

  group('BookingBloc', () {
    final booking = BookingModel(
      id: 'temp',
      hairstyle: 'Test Hairstyle',
      date: DateTime.now().toIso8601String(),
      time: '1PM',
      comment: 'Test Comment',
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingSuccessful] when BookingInitialFetchEvent is added',
      build: () {
        when(BookingRepo.fetchAppointments())
            .thenAnswer((_) async => [booking]);

        return bookingBloc;
      },
      act: (bloc) => bloc.add(BookingInitialFetchEvent()),
      expect: () => [
        BookingSuccessful(bookings: [booking]),
      ],
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingAdditionSuccessState] when BookingAddEvent is added',
      build: () {
        when(BookingRepo.addAppointment(
          hairstyle: 'hairstyle',
          date: 'date',
          time: 'time',
          comment: 'comment',
        )).thenAnswer((_) async => true);
        return bookingBloc;
      },
      act: (bloc) => bloc.add(BookingAddEvent(booking)),
      expect: () => [
        BookingAdditionSuccessState(),
      ],
    );

    // Add more bloc tests for other events as needed
  });
}
