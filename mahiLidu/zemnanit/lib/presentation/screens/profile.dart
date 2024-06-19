import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/Application/auth/auth_state.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/create_user.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/landing.dart';

void main() {
  runApp(BlocProvider(
    create: (context) =>
        AuthBloc(baseUrl: 'http://localhost:3000', httpClient: http.Client()),
    child: MaterialApp(home: Profile(email: 'test@example.com')),
  ));
}

class Profile extends StatelessWidget {
  final String email;
  Profile({super.key, required this.email});

  final passwordControler = TextEditingController();
  final newPasswordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Column(children: [
            Text(
              'Profile Page',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                Text('$email')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordControler,
              decoration: InputDecoration(
                labelText: "Enter your old password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: newPasswordControler,
              decoration: InputDecoration(
                labelText: "Enter your new password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        UpdatePasswordRequested(
                          email: '$email',
                          oldPassword: passwordControler.text,
                          newPassword: newPasswordControler.text,
                        ),
                      );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AuthBloc(
                                    baseUrl: 'http://localhost:3000',
                                    httpClient: http.Client()),
                                child: Log_in(),
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Background color
                  textStyle: TextStyle(color: Colors.lightBlue), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                ),
                child: Text(
                  'Update Password',
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            DeleteUserRequested(email: email),
                          );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => AuthBloc(
                                        baseUrl: 'http://localhost:3000',
                                        httpClient: http.Client()),
                                    child: User(),
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400], // Background color
                      textStyle: TextStyle(color: Colors.white), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyAppp()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400], // Background color
                      textStyle: TextStyle(color: Colors.white), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    child: Text(
                      'Go To Home Page',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
