import 'package:flutter/material.dart';
import 'package:zemnanit/presentation/user_side/screens/profile_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.cut,
            color: Colors.red,
          ),
          Text(
            'Zemnanit Beauty Salons',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
         
          
        ],
      ),
       
    );
  }
}