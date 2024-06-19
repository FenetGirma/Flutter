// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zemnanit/presentation/Routes/generated_routes.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking.dart';

class zemnanit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
              child: TextField(
                onChanged: (text) {
                  // Handle text changes
                },
                decoration: InputDecoration(
                  labelText: 'Search for a salon',
                  hintText: 'Zemnanit beauty Salon',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: TextEditingController(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 50, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("View all"), Icon(Icons.arrow_right)],
              ),
            ),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/img1.jpg',
                                width: 100,
                                height: 100,
                              ),
                              Text('Zoma Beauty Salon'),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text("4 kilo, Addis Ababa"),
                                ],
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingForm(), // Navigate to the second page
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                        255, 176, 55, 11), // Background color
                                    textStyle: TextStyle(
                                        color: Colors.white), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Book Here',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ])),
        ),
      ),
    );
  }
}
