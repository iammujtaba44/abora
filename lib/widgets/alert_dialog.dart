import 'dart:async';

import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
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

  Timer.periodic(new Duration(seconds: 2), (timer) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottonNavControllerTrainer(),
        ));

    timer.cancel();
  });
}
