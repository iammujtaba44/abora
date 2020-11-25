import 'package:abora/global/colors.dart';
import 'package:flutter/material.dart';

Widget settingsListTile(BuildContext context, String imageURL, String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
    ),
    height: 70,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              imageURL,
              color: CustomColor.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(color: CustomColor.white, fontSize: 17),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: CustomColor.white,
        )
      ],
    ),
  );
}
