import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Infrastructure/Models/booking_model.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController comments = TextEditingController();
  final TextEditingController hairstyle = TextEditingController();

  String selectedTime = '1PM';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Salon'),
        backgroundColor: Color(0xE6FFFFFF),
      ),
      backgroundColor: Color(0xFFF1CFC3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(hairstyle, 'hairstyle',
                  'Provide any specific instruction or additional comment'),
              SizedBox(height: 10),
              _buildDropdown('Select Time', selectedTime, [
                '1PM',
                '2PM',
                '3PM',
                '4PM',
                '5PM',
                '6PM',
                '7PM',
                '9PM',
                '10PM',
                '11PM'
              ], (newTime) {
                setState(() {
                  selectedTime = newTime!;
                });
              }),
              SizedBox(height: 10),
              _buildDatePicker(context),
              SizedBox(height: 10),
              _buildTextField(comments, 'Comments',
                  'Provide any specific instruction or additional comment'),
              SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Text(
          'Select a date:',
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final booking = BookingModel(
          id: 'temp',
          hairstyle: hairstyle.text,
          date: selectedDate.toIso8601String(),
          time: selectedTime,
          comment: comments.text,
          // user: 'currentUser',
        );
        context.read<BookingBloc>().add(BookingAddEvent(booking));
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFB0300B),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Book',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
