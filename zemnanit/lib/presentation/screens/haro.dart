import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Application/nav_bloc/navigation_bloc.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:http/http.dart' as http;

void main() async {
  MultiBlocProvider(
    providers: [
      BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
      ),
      BlocProvider<BookingBloc>(
        create: (context) => BookingBloc(BookingRepo as BookingRepo),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
            baseUrl: 'http://localhost:3000', httpClient: http.Client()),
      ),
    ],
    child: MyApppp(),
  );
}

class MyApppp extends StatelessWidget {
  const MyApppp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentsPage(),
    );
  }
}
