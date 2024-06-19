import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddSalonRepository {
  Future<Map<String, dynamic>> submitSalon(
    String name,
    String location,
    FilePickerResult pictureResult,
    String accessToken,
  ) async {
    final url = 'http://localhost:3000/salons';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['name'] = name;
      request.fields['location'] = location;

      // Add image file bytes
      if (pictureResult.files.first.bytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            pictureResult.files.first.bytes!,
            filename: pictureResult.files.first.name,
          ),
        );
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        var responseBody = json.decode(responseData.body);
        return {'success': true, 'picturePath': responseBody['picturePath']};
      } else {
        var errorResponse = json.decode(responseData.body);
        return {'success': false, 'message': errorResponse['message']};
      }
    } catch (error) {
      return {'success': false, 'message': 'An error occurred: $error'};
    }
  }
}
