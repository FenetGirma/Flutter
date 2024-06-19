// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zemnanit/presentation/screens/admin/login_admin.dart';
import 'package:zemnanit/presentation/screens/admin/manage_user.dart';
import 'package:zemnanit/presentation/screens/admin/my_salon.dart';

void main() {
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddSalon(),
      routes: {
        '/login': (context) => LoginAdmin(),
        '/addSalon': (context) => AddSalon(),
        '/manageUser': (context) => Users(),
        '/manageSalon': (context) => MySalon(),
      },
    );
  }
}

class AddSalon extends StatefulWidget {
  const AddSalon({super.key});

  @override
  State<AddSalon> createState() => _AddSalonState();
}

class _AddSalonState extends State<AddSalon> {
  int _selectedIndex = 0;

  //assigning controllers
  TextEditingController salonName = TextEditingController();
  TextEditingController location = TextEditingController();

  //file picker variables
  String filePicked = '';

  List<IconData> _icons = [
    Icons.add_outlined,
    Icons.spa_outlined,
    Icons.event_outlined,
    Icons.logout_outlined,
  ];

  List<IconData> _selectedIcons = [
    Icons.add,
    Icons.spa,
    Icons.event,
    Icons.logout,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/addSalon');
        break;
      case 1:
        Navigator.pushNamed(context, '/manageSalon');
        break;
      case 2:
        Navigator.pushNamed(context, '/manageUser');
        break;
      case 3:
        Navigator.pushNamed(context, '/login');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cut, color: Colors.red[400]),
            SizedBox(width: 8.0),
            Text(
              'Zemnanit Beauty Salons',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset('../assets/salon.jpg', fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Add your Salon',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400])),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: salonName,
              decoration: InputDecoration(
                labelText: 'Salon Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: location,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange[100])),
                  onPressed: () {},
                  child: Text('Select File',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(width: 10.0),
              Text(filePicked),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Submit',
                      style: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold))),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.red[400], fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? _selectedIcons[0] : _icons[0]),
            label: 'Add Salon',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? _selectedIcons[1] : _icons[1]),
            label: 'Manage Salons',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2 ? _selectedIcons[2] : _icons[2]),
            label: 'Manage Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3 ? _selectedIcons[3] : _icons[3]),
            label: 'Log Out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black, // Color for unselected icons
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
