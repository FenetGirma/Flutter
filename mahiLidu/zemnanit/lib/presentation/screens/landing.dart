import 'package:flutter/material.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Application/nav_bloc/navigation_bloc.dart';
import 'package:zemnanit/Application/salons/salons_bloc.dart';
import 'package:zemnanit/Infrastructure/Repositories/books_repo.dart';
import 'package:zemnanit/Infrastructure/Repositories/salons_repo.dart';
import 'package:zemnanit/presentation/Routes/generated_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<SalonsBloc>(
          create: (context) => SalonsBloc(SalonsRepo()),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(BookingRepo()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
              baseUrl: 'http://localhost:3000', httpClient: http.Client()),
        ),
      ],
      child: MyAppp(),
    ),
  );
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter BNB using BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
