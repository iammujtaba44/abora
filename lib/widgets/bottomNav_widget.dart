import 'package:abora/global/colors.dart';
import 'package:flutter/material.dart';

Widget bottomNavBar(
    {String imageURL,
    String text,
    String imageURL2,
    String text2,
    String imageURL3,
    String text3,
    String imageURL4,
    String text4,
    int pageIndex,
    Function onTapChangedPage}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
    child: Container(
      color: CustomColor.white,
      child: BottomNavigationBar(
        backgroundColor: CustomColor.signUpButtonColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(imageURL),
              ),
              label: text),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(imageURL2),
              ),
              label: text2),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(imageURL3),
              ),
              label: text3),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(imageURL4),
              ),
              label: text4),
        ],
        currentIndex: pageIndex,
        onTap: onTapChangedPage,
        selectedItemColor: CustomColor.white,
        unselectedItemColor: CustomColor.bottomNavInactiveColor,
      ),
    ),
  );
}
