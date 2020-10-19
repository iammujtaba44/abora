import 'package:abora/models/user_model.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/Trainer/home_page.dart';
import 'package:abora/screens/Trainer/login_page.dart';
import 'package:abora/screens/Trainer/settings_page.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:abora/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return BottonNavControllerTrainer();
    }
  }
}
