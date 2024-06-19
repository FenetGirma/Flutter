// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/nav_bloc/navigation_bloc.dart';
import 'package:zemnanit/presentation/screens/create_user.dart';
import 'package:zemnanit/presentation/screens/home_bf_login.dart';
import 'package:zemnanit/presentation/screens/common_widgets/navigation.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';

class RouteGenerator {
  final NavigationBloc navigationBloc = NavigationBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<NavigationBloc>.value(
                  value: navigationBloc,
                  child: LandingPage(),
                ));
      case '/logout':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<NavigationBloc>.value(
                  value: navigationBloc,
                  child: Log_in(),
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<NavigationBloc>.value(
                  value: navigationBloc,
                  child: Log_in(),
                ));
      case '/createAccount':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<NavigationBloc>.value(
                  value: navigationBloc,
                  child: User(),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: Center(
            child: Text('ERROR LOADING PAGE'),
          ));
    });
  }
}
