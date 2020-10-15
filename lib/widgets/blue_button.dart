import 'package:abora/global/colors.dart';
import 'package:flutter/material.dart';

SizedBox blueButton( {Widget child, Function func }) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: RaisedButton(
      color: CustomColor.signUpButtonColor,

      onPressed: func,
      child: child),
  );
}