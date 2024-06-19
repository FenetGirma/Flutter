import 'dart:convert';

class BookingModel {
  final String id;
  final String hairstyle;
  final String date;
  final String time;
  final String comment;
  // final String user;

  BookingModel({
    required this.id,
    required this.hairstyle,
    required this.date,
    required this.time,
    required this.comment,
    // required this.user
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'hairstyle': hairstyle,
      'date': date,
      'time': time,
      'comment': comment,
      // 'user': user
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['_id'] ?? '',
      hairstyle: map['hairstyle'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      comment: map['comment'] ?? '',
      // user: map['user'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));
}
