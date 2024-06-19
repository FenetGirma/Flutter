// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/create_user.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home_bf_login',
      routes: {
        '/login': (context) => Log_in(),
        '/createAccount': (context) => User(),
      },
      home: Scaffold(
        backgroundColor: Color(0xFFF1CFC3),
        appBar: MyAppBar(),
        body: Container(
          // color: Color.fromARGB(255, 255, 205, 223),
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
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => User()))
                  },
                  label: Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.play_arrow,
                    size: 30,
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => User()))
                          },
                      child: Text('Create Account')),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Log_in()))
                          },
                      child: Text('Login')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
