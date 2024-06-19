// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zemnanit/Application/auth/auth_bloc.dart';
import 'package:zemnanit/Application/auth/auth_event.dart';
import 'package:zemnanit/admin/Application/login_page/login_bloc.dart';
import 'package:zemnanit/admin/Infrastructure/Respositories/login_repository.dart';
import 'package:zemnanit/admin/Presentation/login_admin.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) =>
          AuthBloc(baseUrl: 'http://localhost:3000', httpClient: http.Client()),
      child: User(),
    ),
  ));
}

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool _obscurePassword = true;
  bool _obscureconfirm = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final httpClient = http.Client();
  final loginRepository = LoginRepository(httpClient: http.Client());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: <Widget>[
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Full Name:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: fullnameController,
              decoration: InputDecoration(
                labelText: "Enter your Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Age:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: "Enter your age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Password:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
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
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Confirm Password:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: confirmController,
              obscureText: _obscureconfirm,
              decoration: InputDecoration(
                labelText: "Confirm your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_obscureconfirm
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureconfirm = !_obscureconfirm;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    200, 50), // Adjust the width and height values as needed
              ),
              child: Text(
                "Create Account",
                style: TextStyle(color: Colors.red[400], fontSize: 18.0),
              ),
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    confirmController.text.isNotEmpty &&
                    fullnameController.text.isNotEmpty &&
                    ageController.text.isNotEmpty) {
                  if (passwordController.text == confirmController.text) {
                    context.read<AuthBloc>().add(
                          SignupRequested(
                            email: emailController.text,
                            password: passwordController.text,
                            fullname: fullnameController.text,
                            age: ageController.text,
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
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Password does not match!',
                        ),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill in all the required fields.',
                      ),
                    ),
                  );
                }
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? |',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              TextButton(
                child: Text(
                  "Login as User",
                  style: TextStyle(color: Colors.red[400], fontSize: 18.0),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AuthBloc(
                            baseUrl: 'http://localhost:3000',
                            httpClient: http.Client()),
                        child: Log_in(),
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                  child: Text(
                    "Login as admin",
                    style: TextStyle(color: Colors.red[400], fontSize: 18.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) =>
                              AdminLoginBloc(loginRepository: loginRepository),
                          child: AdminLoginPage(),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ])),
      ),
    );
  }
}
