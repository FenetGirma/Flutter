// import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/presentation/Routes/generated_routes.dart';
import 'package:zemnanit/presentation/screens/sam.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

// import 'package:flutter/widgets.dart';
void main() {
  runApp(
    Home(),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Container(
        // color: Color.fromARGB(255, 255, 205, 223),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight:
                        Radius.circular(70.0), // Adjust the radius as needed
                  ), // Adjust the radius as needed
                  child: Image(
                    image: AssetImage("assets/zemnanit.jpg"),
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cut),
                Text(
                  'Your Number 1 hair appointment app! ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.cut),
              ],
            ),
            Text(
              "We Connect you with quality salons of your area! ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Get ready to nurture your hair, with quality service!',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
