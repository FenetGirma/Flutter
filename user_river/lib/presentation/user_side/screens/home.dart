import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/screens/booking.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/bottomnav.dart'; // Import the bottom navigation bar
import 'appointments.dart';
import 'salonss.dart';
import 'login_user.dart'; // Import your Login screen
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'profile_page.dart'; // Import your ProfilePage screen

class Home extends ConsumerStatefulWidget {
  final String email;

  Home({required this.email});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    // final selectedIndex = ref.watch(selectedIndexProvider);
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage("assets/zemnanit.jpg"),
                ),
                Positioned(
                    top: 170,
                    left: 80,
                    child: RichText(
                        text: TextSpan(
                            text: "Welcome to ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: "Zemnanit",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold))
                        ]))),
                Positioned(
                  top: 220,
                  left: 140,
                  child: Text(
                    "Beauty Salons!",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color.fromARGB(255, 249, 245, 245),
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          email: widget
                              .email), // Navigate to the ProfilePage with the email
                    ),
                  );
                },
                label: Text(
                  "Go to Profile",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
