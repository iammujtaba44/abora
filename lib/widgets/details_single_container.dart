import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:flutter/material.dart';

Widget detailsSingleContainer(context, {String text, String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 30.0, right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  text,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: FontSize.h3FontSize - 5),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      value,
                      style: TextStyle(
                          color: CustomColor.white,
                          fontSize: FontSize.h3FontSize - 3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
