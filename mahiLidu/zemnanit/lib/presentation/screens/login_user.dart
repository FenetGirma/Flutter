// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/Application/auth/auth_state.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:zemnanit/presentation/screens/landing.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/screens/profile.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) =>
          AuthBloc(baseUrl: 'http://localhost:3000', httpClient: http.Client()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Log_in(),
      ),
    ),
  );
}

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  State<Log_in> createState() => _LoginState();
}

class _LoginState extends State<Log_in> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureconfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is AuthLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => AuthBloc(
                            baseUrl: 'http://localhost:3000',
                            httpClient: http.Client()),
                        child: Profile(email: state.email),
                      )),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zemnanit Beauty Salons',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[400]),
              ),
              SizedBox(height: 10),
              Text('Welcome User!',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Enter Email',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon:
                            Icon(Icons.person, color: Colors.grey[600])),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter both email and password'),
                      ),
                    );
                  } else {
                    context.read<AuthBloc>().add(
                          LoginRequested(
                              email: emailController.text,
                              password: passwordController.text),
                        );
                  }
                },
                child: Text('Login'),
              ),
              // if (authState.error != null) ...[
              //   SizedBox(height: 20),
              //   Text(authState.error!, style: TextStyle(color: Colors.red)),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
