import 'package:abora/global/colors.dart';
import 'package:flutter/material.dart';

Widget bottomNavBar({IconData iconData1, Text text1, IconData iconData2, Text text2 , IconData iconData3, Text text3, IconData iconData4, Text text4}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
    child: Container(
      color: Colors.red,
      child: BottomNavigationBar(
        backgroundColor: CustomColor.signUpButtonColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.email), title: Text('Appointment')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.build,
              ),
              title: Text('My Courses')),
          BottomNavigationBarItem(
              icon: Icon(Icons.build), title: Text('My Courses')),
        ],
        selectedItemColor: CustomColor.white,
        unselectedItemColor: CustomColor.bottomNavInactiveColor,
      ),
    ),
  );
}