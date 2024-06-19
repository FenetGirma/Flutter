import 'package:zemnanit/Infrastructure/Models/booking_model.dart';

import './booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingActionState extends BookingState {}

class BookingAdditionSuccessState extends BookingActionState {}

class BookingAdditionErrorState extends BookingActionState {
  final String error;

  BookingAdditionErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class BookingLoaded extends BookingState {
  final List<BookingModel> bookings;

  BookingLoaded(this.bookings);
}

class BookingSuccessful extends BookingState {
  final List<BookingModel> bookings;

  BookingSuccessful({required this.bookings});
}

class AppointmentState {
  final String? message;
  final String? error;

  AppointmentState._({this.message, this.error});

  factory AppointmentState.initial() {
    return AppointmentState._(message: null, error: null);
  }

  factory AppointmentState.success(String message) {
    return AppointmentState._(message: message, error: null);
  }

  factory AppointmentState.failure(String error) {
    return AppointmentState._(message: null, error: error);
  }
}

class BookingDeletionErrorState extends BookingActionState {
  final String error;

  BookingDeletionErrorState(this.error);

  @override
  List<Object> get props => [error];
}
