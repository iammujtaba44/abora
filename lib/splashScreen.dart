import 'dart:async';
import 'package:abora/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _bgVisible = false;
  bool _visible = false;

  _makeVisible() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _visible = true;
      });
    });
  }

  // _makeInvisible() {
  //   Timer(Duration(seconds: 4), () {
  //     setState(() {
  //       _visible = false;
  //     });
  //   });
  // }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _bgVisible = true;
      });
    });
    _makeVisible();
  }

  @override
  Widget build(BuildContext context) {
    // _makeInvisible();

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _bgVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1000),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.fill)),
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1000),
                child: Center(
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
