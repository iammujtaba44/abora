import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:flutter/material.dart';

onAlertButtonsPressed(context, {@required String title}) {
  Alert(
    style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
    context: context,
    buttons: [],
    title: '',
    desc: title,
    image: Image.asset('assets/dialog_img.png'),
  ).show();
}
