part of 'booking_bloc.dart';

abstract class BookingEvent {}

class BookingInitialFetchEvent extends BookingEvent {}

class BookingAddEvent extends BookingEvent {
  final BookingModel booking;
  BookingAddEvent(this.booking);
}

class BookingDeleteEvent extends BookingEvent {
  final String id;
  BookingDeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class BookingEditEvent extends BookingEvent {
  final String id;
  final String hairstyle;
  final String date;
  final String time;
  final String comment;

  BookingEditEvent(
      {required this.id,
      required this.hairstyle,
      required this.date,
      required this.time,
      required this.comment});

  @override
  List<Object> get props => [id];
}

class Logout extends BookingEvent {}

class DeleteBooking extends BookingEvent {
  final String? id;

  DeleteBooking({required this.id});
}

class BookingDeleted extends BookingState {
  final String Message;

  BookingDeleted({required this.Message});
}

class BookingEdited extends BookingState {
  final String Message;

  BookingEdited({required this.Message});
}

class BookingUpdated extends BookingState {
  final String Message;

  BookingUpdated({required this.Message});
}

class BookingError extends BookingState {
  final String errorMessage;

  BookingError(this.errorMessage);
}
