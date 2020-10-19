import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/multiuser_signup_page.dart';
import 'package:abora/services/auth.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:preview/preview.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiuserLoginPage(),
    );
  }
}

class MultiuserLoginPage extends StatefulWidget {
  @override
  _MultiuserLoginPageState createState() => _MultiuserLoginPageState();
}

class _MultiuserLoginPageState extends State<MultiuserLoginPage> {
  int _index = 0;
  bool isChecked = false;

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 130,
                    height: 130,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Keep Connected',
                style: TextStyle(
                    color: CustomColor.red,
                    fontSize: FontSize.h3FontSize + 4,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 240,
                child: Text(
                  'Enter your email address and password to get access your account',
                  style: TextStyle(
                    color: CustomColor.white,
                    fontSize: FontSize.h5FontSize,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Tabs(context),
              SizedBox(
                height: 20,
              ),
              Login(context),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: CustomColor.white),
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(color: CustomColor.red),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Login(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customTextField(iconData: Icons.email, text: 'Email Address'),
          SizedBox(
            height: 20,
          ),
          customTextField(iconData: Icons.lock_outline, text: 'Password'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: isChecked ? CustomColor.red : null,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: CustomColor.white)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        color: CustomColor.white,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Forgot password?',
                style: TextStyle(color: CustomColor.white),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          blueButton(
            func: () async {
              var result =
                  _auth.signInWithEmailAndPassword('abc@gmail.com', '123123');
              if (result == null) {
                print('result is null------------');
              }
            },
            child: Text(
              'log in'.toUpperCase(),
              style: TextStyle(color: CustomColor.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget Tabs(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color:
                            _index == 0 ? CustomColor.red : CustomColor.white,
                      ),
                      Text(
                        'I\'m a Trainer',
                        style: TextStyle(
                          color:
                              _index == 0 ? CustomColor.red : CustomColor.white,
                          fontSize: FontSize.h3FontSize,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _index == 0
                      ? Container(
                          height: 2,
                          width: 40,
                          color: CustomColor.red,
                        )
                      : Container(),
                ],
              ),
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color:
                            _index == 1 ? CustomColor.red : CustomColor.white,
                      ),
                      Text(
                        'I\'m a Client',
                        style: TextStyle(
                          color:
                              _index == 1 ? CustomColor.red : CustomColor.white,
                          fontSize: FontSize.h3FontSize,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _index == 1
                      ? Container(
                          height: 2,
                          width: 40,
                          color: CustomColor.red,
                        )
                      : Container(),
                ],
              ),
              onTap: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IPhone5 extends PreviewProvider {
  @override
  String get title => 'iPhone 5';
  @override
  List<Preview> get previews => [
        Preview(
          key: Key('preview'),
          frame: Frames.iphone5,
          child: MyApp(),
        ),
      ];
}

class IPhoneX extends PreviewProvider {
  @override
  String get title => 'Iphone X';
  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.iphoneX,
          child: MyApp(),
        ),
      ];
}

class IPad extends PreviewProvider {
  @override
  String get title => 'IPad';
  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.ipadPro12,
          child: MyApp(),
        ),
      ];
}
