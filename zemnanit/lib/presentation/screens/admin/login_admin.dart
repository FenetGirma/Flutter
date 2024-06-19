import 'package:flutter/material.dart';
import 'package:zemnanit/presentation/screens/admin/add_salon.dart';


void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoginAdmin()));
}

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  TextEditingController Controller = TextEditingController();
  TextEditingController Controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      body: Center(
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
            Text('Welcome Admin!',
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
                  controller: Controller,
                  decoration: InputDecoration(
                      labelText: 'Enter Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.person, color: Colors.grey[600])),
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
                  controller: Controller2,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSalon()),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(200, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red[400],
                    ),
                  ),
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}