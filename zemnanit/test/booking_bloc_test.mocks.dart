import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';
import 'package:mockito/mockito.dart';

class MockBookingRepo extends Mock implements BookingRepo {
  @override
  Future<List<BookingModel>> fetchAppointments() async {
    return super.noSuchMethod(Invocation.method(#fetchAppointments, []),
        returnValue: Future<List<BookingModel>>.value([]),
        returnValueForMissingStub: Future<List<BookingModel>>.value([]));
  }

  @override
  Future<bool> addAppointment(
      {required String hairstyle,
      required String date,
      required String time,
      required String comment}) async {
    return super.noSuchMethod(
      Invocation.method(#addAppointment, [],
          {#hairstyle: hairstyle, #date: date, #time: time, #comment: comment}),
      returnValue: Future<bool>.value(true),
      returnValueForMissingStub: Future<bool>.value(true),
    );
  }

  // Add more method implementations as needed
}
