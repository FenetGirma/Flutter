import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Infrastructure/Models/salon_model.dart';

class SalonsRepo {
  static Future<List<SalonModel>> fetchSalons() async {
    var client = http.Client();
    List<SalonModel> salons = [];
    try {
      var response =
          await client.get(Uri.parse('http://localhost:3000/salons'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        SalonModel salon =
            SalonModel.fromMap(result[i] as Map<String, dynamic>);
        salons.add(salon);
      }

      return salons;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
