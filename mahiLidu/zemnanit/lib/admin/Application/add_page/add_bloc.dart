import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../Infrastructure/Respositories/add_salon_repository.dart';

class AddSalonBloc extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  late String _name;
  late String _location;
  FilePickerResult? _pictureResult = null; // Initialize with null
  late String _uploadedImagePath = '';
  bool _isLoading = false;
  String? _errorMessage;

  String get uploadedImagePath => _uploadedImagePath;
  bool get isLoading => _isLoading;
  FilePickerResult? get pictureResult => _pictureResult; // Updated getter
  String? get errorMessage => _errorMessage;

  final AddSalonRepository _repository =
      AddSalonRepository(); // Initialize the repository

  void setName(String? name) {
    _name = name!;
  }

  void setLocation(String? location) {
    _location = location!;
  }

  void pickPicture(BuildContext context) async {
    _pictureResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (_pictureResult != null && _pictureResult!.files.isNotEmpty) {
      _uploadedImagePath = ''; // Reset the uploaded image path
      notifyListeners();
    } else {
      _pictureResult = null; // Reset the picture result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  Widget displaySelectedImage() {
    if (_pictureResult != null && _pictureResult!.files.isNotEmpty) {
      print('Image bytes length: ${_pictureResult!.files.first.bytes!.length}');
      try {
        final image = Image.memory(
          _pictureResult!.files.first.bytes!,
          height: 200,
          fit: BoxFit.cover,
        );
        print('Image decoded successfully');
        return image;
      } catch (e) {
        print('Error decoding image: $e');
        return Container(); // Return an empty container if there's an error
      }
    } else {
      print('No image selected');
      return SizedBox
          .shrink(); // Return an empty widget if no image is selected
    }
  }

  void submitForm(BuildContext context, String accessToken) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_pictureResult == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image before submitting.')),
        );
        return; // Exit early if no image is selected
      }

      _isLoading = true;
      _errorMessage = null; // Reset error message
      notifyListeners();

      var result = await _repository.submitSalon(
        _name,
        _location,
        _pictureResult!,
        accessToken,
      );

      if (result['success']) {
        _uploadedImagePath = result['picturePath'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salon added successfully!')),
        );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Salon created successfully!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );

        _pictureResult = null; // Clear the selected image
        _formKey.currentState?.reset(); // Reset the form
      } else {
        _errorMessage = result['message']; // Capture error message
        notifyListeners();
      }

      _isLoading = false;
      notifyListeners();
    }
  }

  void validateAndSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  String? validateSalonName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a salon name';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a location';
    }
    return null;
  }
}
