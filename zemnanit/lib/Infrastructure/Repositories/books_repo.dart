import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';

class BookingRepo {
  static Future<List<BookingModel>> fetchAppointments() async {
    var client = http.Client();
    List<BookingModel> bookings = [];
    try {
      var response =
          await client.get(Uri.parse('http://localhost:3000/appointments'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        BookingModel booking =
            BookingModel.fromMap(result[i] as Map<String, dynamic>);
        bookings.add(booking);
      }

      return bookings;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //
  //
  //
  //
  static Future<bool> addAppointment({
    required String hairstyle,
    required String date,
    required String time,
    required String comment,
    // required String user,
  }) async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('http://localhost:3000/appointments'), body: {
        "hairstyle": hairstyle,
        "date": date,
        "time": time,
        "comment": comment,
        // "user": user
      });

      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        return true;
      } else {
        return false;
      } //try ends here
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

//
//
//
  static Future<bool> editAppointment(String id, String hairstyle, String date,
      String time, String comment) async {
    try {
      final response = await http.patch(
        Uri.parse('http://localhost:3000/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hairstyle': hairstyle,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception(
            'Failed to update appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

//
//
//
  static Future<bool> deleteAppointment(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception(
            'Failed to delete appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
