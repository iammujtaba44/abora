import 'package:abora/models/user_model.dart';
import 'package:abora/screens/Trainer/home_page.dart';
import 'package:abora/screens/Trainer/login_page.dart';
import 'package:abora/screens/authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    print('----------------$user');

    if (user == null) {
      return LoginPage();
    } else {
      print('${user.email}');
      return HomePage();
    }
  }
}
