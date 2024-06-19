import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_state.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';

import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => BookingBloc(BookingRepo()),
    child: MaterialApp(
      home: AppointmentsPage(),
    ),
  ));
}

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<BookingBloc>().add(BookingInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: BlocConsumer<BookingBloc, BookingState>(
        listenWhen: (previous, current) => current is BookingActionState,
        buildWhen: (previous, current) => current is! BookingActionState,
        listener: (context, state) {
          if (state is BookingDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.Message)),
            );
          } else if (state is BookingDeletionErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookingSuccessful) {
            return Column(
              children: [
                Text(
                  'My Appointments',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.bookings.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.deepOrange[200],
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.cut),
                                  SizedBox(width: 10),
                                  Text(
                                    state.bookings[index].hairstyle.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.lock_clock),
                                  SizedBox(width: 10),
                                  Text(
                                    state.bookings[index].time.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: 10),
                                  Text(
                                    state.bookings[index].date,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final id = state.bookings[index].id;
                                      _editAppointmentDialog(context, id);
                                    },
                                    child: Text('Edit Appointment'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final id = state.bookings[index].id;
                                      context.read<BookingBloc>().add(
                                            BookingDeleteEvent(id: id),
                                          );
                                    },
                                    child: Text('Delete Appointment'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void _editAppointmentDialog(BuildContext context, id) {
    final dateController = TextEditingController();
    final commentController = TextEditingController();
    final hairstyleController = TextEditingController();

    String selectedTime = '1PM';
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Appointment'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      dateController.text =
                          picked.toIso8601String().split('T')[0];
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedTime,
                items: [
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
                ]
                    .map((time) => DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedTime = value;
                    });
                  }
                },
                decoration: InputDecoration(labelText: 'Time'),
              ),
              _buildTextField(commentController, 'comment', maxLines: 3),
              _buildTextField(hairstyleController, 'hairstyle', maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookingBloc>().add(BookingEditEvent(
                  id: id,
                  hairstyle: hairstyleController.text,
                  date: selectedDate.toIso8601String(),
                  time: selectedTime,
                  comment: commentController.text));
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
    );
  }
}
