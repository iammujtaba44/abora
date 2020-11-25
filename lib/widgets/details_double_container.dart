import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:flutter/material.dart';

Widget detailsDoubleContainer(BuildContext context,
    {String text, String value, String text2, String value2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15, bottom: 15, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: FontSize.h3FontSize - 2),
                ),
                Text(
                  value,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: FontSize.h3FontSize - 2),
                )
              ],
            ),
          ),
          Divider(
            color: CustomColor.textFieldBorderColor,
            thickness: 1,
            indent: 30,
            endIndent: 30,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15, bottom: 15, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text2,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: FontSize.h3FontSize - 2),
                ),
                Text(
                  value2,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: FontSize.h3FontSize - 2),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
