import 'package:zemnanit/admin/Application/add_page/add_bloc.dart';

import '../Application/user_managment/user_bloc.dart';
import '../Infrastructure/Respositories/user_repository.dart';
import 'manage_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'add_ui.dart';
import 'salon_list_screen.dart';

void main() {
  final String accessToken = ""; // Initialize your access token here
  final http.Client httpClient = http.Client();

  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => AddSalonBloc(), // Provide the AddSalonBloc
        child: AdminDashboard(accessToken: accessToken, httpClient: httpClient),
      ),
    ),
  );
}

class AdminDashboard extends StatelessWidget {
  final String accessToken;
  final http.Client httpClient;

  AdminDashboard({required this.accessToken, required this.httpClient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => UserBloc(
                        userRepository: UserRepository(httpClient: httpClient),
                        accessToken: accessToken,
                      ),
                      child: ManageUsersPage(),
                    ),
                  ),
                );
              },
              child: Text('Manage Users'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20), // Button padding
                textStyle: TextStyle(fontSize: 20), // Text style
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Button border radius
                ),
                elevation: 5, // Elevation
              ),
            ),
            SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddSalonScreen(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Add Salon'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20), // Button padding
                textStyle: TextStyle(fontSize: 20), // Text style
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Button border radius
                ),
                elevation: 5, // Elevation
              ),
            ),
            SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SalonListScreen(accessToken: accessToken),
                  ),
                );
              },
              child: Text('View Salons'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20), // Button padding
                textStyle: TextStyle(fontSize: 20), // Text style
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Button border radius
                ),
                elevation: 5, // Elevation
              ),
            ),
          ],
        ),
      ),
    );
  }
}
