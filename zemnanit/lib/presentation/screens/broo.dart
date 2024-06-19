import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/screens/booking.dart';
import 'dart:convert';

import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

void main() {
  final String accessToken = ""; // Initialize your access token here
  final http.Client httpClient = http.Client();
  runApp(MaterialApp(
    home: SalonListScreen(accessToken: accessToken),
  ));
}

class SalonListScreen extends StatefulWidget {
  final String accessToken;

  SalonListScreen({required this.accessToken});

  @override
  _SalonListScreenState createState() => _SalonListScreenState();
}

class _SalonListScreenState extends State<SalonListScreen> {
  bool _isLoading = false;
  List _salons = [];

  @override
  void initState() {
    super.initState();
    _fetchSalons();
  }

  Future<void> _fetchSalons() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'http://localhost:3000/salons'; // Replace with your backend URL
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _salons = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load salons')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _editSalon(String salonId, String newName, String newLocation,
      String newPicturePath) async {
    final url =
        'http://localhost:3000/salons/$salonId'; // Adjust URL to your API endpoint

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': newName,
          'location': newLocation,
          'picturePath': newPicturePath,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salon updated successfully')),
        );
        // Refresh salon list or update UI as needed
        _fetchSalons();
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bad Request: Invalid data provided')),
        );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unauthorized: Invalid access token')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not Found: Salon does not exist')),
        );
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Internal Server Error: Please try again later')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to update salon: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteSalon(String salonId) async {
    final url =
        'http://localhost:3000/salons/$salonId'; // Adjust URL to your API endpoint

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salon deleted successfully')),
        );
        // Refresh salon list or update UI as needed
        _fetchSalons();
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unauthorized: Invalid access token')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not Found: Salon does not exist')),
        );
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Internal Server Error: Please try again later')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to delete salon: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _salons.length,
              itemBuilder: (context, index) {
                var salon = _salons[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(salon['picturePath'] ?? ''),
                        radius: 30,
                      ),
                      Text(
                        salon['name'] ?? '',
                      ),
                      Column(
                        children: [
                          Text(
                            salon['location'] ?? '',
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
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
                              textStyle:
                                  TextStyle(color: Colors.white), // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                              ),
                            ),
                            child: Text(
                              'Book Here',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
