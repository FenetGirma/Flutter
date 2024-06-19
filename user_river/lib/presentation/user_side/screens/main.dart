import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/testing.dart';
import 'package:zemnanit/presentation/admin_side/screens/login_admin.dart';
import 'package:zemnanit/presentation/user_side/screens/booking.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/bottomnav.dart';
import 'package:zemnanit/presentation/user_side/screens/appointments.dart';
import 'package:zemnanit/presentation/user_side/screens/home.dart';
import 'package:zemnanit/presentation/user_side/screens/salonss.dart';
import 'package:zemnanit/presentation/user_side/screens/login_user.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/screens/profile_page.dart';
import 'package:zemnanit/presentation/user_side/screens/create_user.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ProviderScope(child: ZemnanitApp()));
}

class ZemnanitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/login_admin':(context) => AdminLoginPage(httpClient: http.Client()),
      },
      home: CreateUser(), // Set CreateUser as the initial screen
    );
  }
}
