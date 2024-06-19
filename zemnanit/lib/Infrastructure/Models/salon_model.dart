import 'dart:convert';
import 'dart:core';

class SalonModel {
  final String name;
  final String location;
  final String picturePath;

  // final String user;

  SalonModel({
    required this.name,
    required this.location,
    required this.picturePath,

    // required this.user
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'picturePath': picturePath,

      // 'user': user
    };
  }

  factory SalonModel.fromMap(Map<String, dynamic> map) {
    return SalonModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      picturePath: map['picturePath'] ?? '',

      // user: map['user'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory SalonModel.fromJson(String source) =>
      SalonModel.fromMap(json.decode(source));
}
