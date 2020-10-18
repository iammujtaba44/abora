import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:flutter/material.dart';

Container customTextField(
    {IconData iconData,
    String text,
    bool curveContainer = false,
    EdgeInsets edgeInsets = const EdgeInsets.only(left: 10, right: 10),
    bool isPadding = false,
    TextEditingController controller}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        borderRadius: curveContainer ? BorderRadius.circular(5) : null,
        color: CustomColor.textFieldFilledColor,
        border: Border.all(color: CustomColor.textFieldBorderColor)),
    child: TextFormField(
      controller: controller == null ? null : controller,
      decoration: InputDecoration(
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: CustomColor.textFieldLabelColor,
                size: FontSize.h3FontSize + 2,
              )
            : null,
        hintText: text,
        contentPadding: isPadding ? edgeInsets : null,
        hintStyle: TextStyle(
            color: CustomColor.textFieldLabelColor,
            fontSize: FontSize.h3FontSize - 2),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      // onChanged: (value) {
      //   controller.text = value;
      // },
    ),
  );
}

CustomtextfieldWithText({String text, String, hintText, var controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(color: CustomColor.orangeColor, fontSize: 20.0),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        height: 60,
        // width: MediaQuery.of(context).size.width,
        color: CustomColor.textFieldFilledColor,
        child: TextFormField(
          maxLines: 1,
          autofocus: false,
          controller: controller == null ? null : controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: CustomColor.textFieldLabelColor, fontSize: 17.0),
            contentPadding: EdgeInsets.all(20.0),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: CustomColor.textFieldBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(2))),
          ),
        ),
      )
    ],
  );
}
