import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/screens/booking.dart';
import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:zemnanit/presentation/screens/home.dart';
import 'package:zemnanit/presentation/screens/salonss.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/auth_service.dart';
import 'package:zemnanit/presentation/screens/profile_page.dart';
import 'package:zemnanit/presentation/screens/create_user.dart';

void main() {
  runApp(ProviderScope(child: ZemnanitApp()));
}

class ZemnanitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zemnanit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => Home(email: ''),
        '/salons': (context) => SalonListScreen(),
        '/appointments': (context) => MyAppointments(),
        '/logout': (context) => Login(),
        '/login': (context) => Login(),
        '/book': (context) => ZemnanitDrop(),
        '/create_user': (context) => CreateUser(),
      },
      home: CreateUser(), // Set CreateUser as the initial screen
    );
  }
}
