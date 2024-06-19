import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_state.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';

part 'booking_event.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepo bookingRepo;

  BookingBloc(this.bookingRepo) : super(BookingInitial()) {
    on<BookingInitialFetchEvent>(bookingInitialFetchEvent);
    on<BookingAddEvent>(bookingsAddEvent);
    on<BookingDeleteEvent>(bookingDeleteEvent);
    on<BookingEditEvent>(bookingEditEvent);
  }

  FutureOr<void> bookingInitialFetchEvent(
      BookingInitialFetchEvent event, Emitter<BookingState> emit) async {
    List<BookingModel> bookings = await BookingRepo.fetchAppointments();
    emit(BookingSuccessful(bookings: bookings));
    //
    //
  }

  FutureOr<void> bookingsAddEvent(
      BookingAddEvent event, Emitter<BookingState> emit) async {
    bool success = await BookingRepo.addAppointment(
      hairstyle: event.booking.hairstyle,
      date: event.booking.date,
      time: event.booking.time,
      comment: event.booking.comment,
      // user: event.booking.user,
    );

    if (success) {
      emit(BookingAdditionSuccessState());
    } else {
      emit(BookingAdditionErrorState(
          'Failed to add appointment. Please try again.'));
    }
  }

  FutureOr<void> bookingEditEvent(
      BookingEditEvent event, Emitter<BookingState> emit) async {
    try {
      final success = await BookingRepo.editAppointment(
          event.id, event.hairstyle, event.comment, event.date, event.time);
      if (success) {
        emit(BookingEdited(Message: "Appointment edited successfully"));
        List<BookingModel> bookings = await BookingRepo.fetchAppointments();
        emit(BookingSuccessful(bookings: bookings));
      } else {
        emit(BookingError('Failed to edit appointment.'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> bookingDeleteEvent(
      BookingDeleteEvent event, Emitter<BookingState> emit) async {
    try {
      final success = await BookingRepo.deleteAppointment(event.id);
      if (success) {
        emit(BookingDeleted(Message: "Appointment deleted successfully"));
        List<BookingModel> bookings = await BookingRepo.fetchAppointments();
        emit(BookingSuccessful(bookings: bookings));
      } else {
        emit(BookingError('Failed to delete appointment.'));
      }
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
