import 'package:abora/screens/authenticate/multiuser_login_page.dart';
import 'package:abora/screens/authenticate/multiuser_signup_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  bool showSignIn;
  Authenticate({this.showSignIn});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  void toggleView() {
    setState(() {
      widget.showSignIn = !widget.showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showSignIn) {
      return MultiuserLoginPage(
        toggleView: toggleView,
      );
    } else {
      return MultiuserSignUpPage(
        toggleView: toggleView,
      );
    }
  }
}
