import 'package:flutter/material.dart';
import '../Application/add_page/add_bloc.dart';

class AddSalonScreen extends StatefulWidget {
  final String accessToken;

  AddSalonScreen({required this.accessToken});

  @override
  _AddSalonScreenState createState() => _AddSalonScreenState();
}

class _AddSalonScreenState extends State<AddSalonScreen> {
  final AddSalonBloc _bloc = AddSalonBloc(); // Instantiate the bloc

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Salon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _bloc.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salon Name'),
                  validator: _bloc.validateSalonName,
                  onSaved: (value) {
                    _bloc.setName(value);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: _bloc.validateLocation,
                  onSaved: (value) {
                    _bloc.setLocation(value);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      _bloc.isLoading ? null : () => _bloc.pickPicture(context),
                  child: Text('Select Picture'),
                ),
                SizedBox(height: 20),
                if (_bloc.uploadedImagePath.isNotEmpty)
                  Column(
                    children: [
                      Image.memory(
                        _bloc.pictureResult!.files.first.bytes!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Selected Image: ${_bloc.uploadedImagePath}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (_bloc.pictureResult != null &&
                    _bloc.pictureResult!.files.isNotEmpty)
                  Column(
                    children: [
                      _bloc
                          .displaySelectedImage(), // Display the selected image
                      SizedBox(height: 10),
                      Text(
                        'Selected Image: ${_bloc.pictureResult!.files.first.name}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _bloc.isLoading
                      ? null
                      : () => _bloc.submitForm(context, widget.accessToken),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
