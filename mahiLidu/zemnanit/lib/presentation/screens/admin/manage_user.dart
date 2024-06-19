// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:zemnanit/presentation/screens/admin/add_salon.dart';
import 'package:zemnanit/presentation/screens/admin/login_admin.dart';
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

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  int _selectedIndex = 0;

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
      body: ListView(
        children: [
          TextButton(onPressed: () {}, child: Text('Get All Users')),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.deepOrange[50],
            child: ListTile(
              leading: Icon(Icons.person),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Name"),
                    TextButton(
                        onPressed: () {},
                        child: Row(children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Delete User',
                              style: TextStyle(color: Colors.red))
                        ]))
                  ]),
              onTap: () {
                // Handle the onTap event for the ListTile
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.deepOrange[50],
            child: ListTile(
              leading: Icon(Icons.person),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Name"),
                    TextButton(
                        onPressed: () {},
                        child: Row(children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Delete User',
                              style: TextStyle(color: Colors.red))
                        ]))
                  ]),
              onTap: () {
                // Handle the onTap event for the ListTile
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.deepOrange[50],
            child: ListTile(
              leading: Icon(Icons.person),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Name"),
                    TextButton(
                        onPressed: () {},
                        child: Row(children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Delete User',
                              style: TextStyle(color: Colors.red))
                        ]))
                  ]),
              onTap: () {
                // Handle the onTap event for the ListTile
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.deepOrange[50],
            child: ListTile(
              leading: Icon(Icons.person),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Name"),
                    TextButton(
                        onPressed: () {},
                        child: Row(children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Delete User',
                              style: TextStyle(color: Colors.red))
                        ]))
                  ]),
              onTap: () {
                // Handle the onTap event for the ListTile
              },
            ),
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
