import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/sam.dart';

import 'package:http/http.dart' as http;
import 'package:zemnanit/Application/nav_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:zemnanit/presentation/screens/home.dart';

// Initialize your access token here
final http.Client httpClient = http.Client();
List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
    ),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.spa,
    ),
    label: 'Salons',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.calendar_today,
    ),
    label: 'Appointments',
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      Icons.logout,
    ),
    label: 'Log Out',
  )
];

List<Widget> bottomNavScreen = <Widget>[
  Home(),
  MySalon(),
  AppointmentsPage(),
  Log_in()
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: Colors.red[400],
              unselectedItemColor: Colors.black,
              onTap: (index) {
                if (index == 3) {
                  // Navigate to the log out screen
                  Navigator.pushNamed(context, '/logout');
                } else {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(TabChange(tabIndex: index));
                }
              }),
        );
      },
    );
  }
}
