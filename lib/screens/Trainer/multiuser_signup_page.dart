import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/user.dart';
import 'package:abora/screens/Trainer/otp_page.dart';
import 'package:abora/services/auth.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/gestures.dart';
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
      home: MultiuserSignUpPage(),
    );
  }
}

class MultiuserSignUpPage extends StatefulWidget {
  @override
  _MultiuserSignUpPageState createState() => _MultiuserSignUpPageState();
}

class _MultiuserSignUpPageState extends State<MultiuserSignUpPage> {
  final AuthService _auth = AuthService();

  TextEditingController firstNameController,
      lastNameController,
      emailController,
      passwordController,
      confirmPassowrdController;

  int _index = 0;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassowrdController = TextEditingController();
  }

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
              Tabs(context),
              SizedBox(
                height: 20,
              ),
              SignUp(context),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: CustomColor.white),
                  ),
                  Text(
                    'Login',
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

  Widget SignUp(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CustomColor.textFieldFilledColor,
                border: Border.all(color: CustomColor.textFieldBorderColor)),
            child: TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: CustomColor.textFieldLabelColor,
                  size: FontSize.h3FontSize + 2,
                ),
                hintText: 'text',
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                hintStyle: TextStyle(
                    color: CustomColor.textFieldLabelColor,
                    fontSize: FontSize.h3FontSize - 2),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
              onChanged: (value) {
                setState(() => firstNameController.text = value);
              },
            ),
          ),
          // customTextField(
          //     iconData: Icons.person,
          //     text: 'First Name',
          //     controller: firstNameController),
          SizedBox(
            height: 20,
          ),
          customTextField(iconData: Icons.person, text: 'Last Name'),
          SizedBox(
            height: 20,
          ),
          customTextField(iconData: Icons.email, text: 'Email Address'),
          SizedBox(
            height: 20,
          ),
          customTextField(iconData: Icons.lock_outline, text: 'Password'),
          SizedBox(
            height: 20,
          ),
          customTextField(
              iconData: Icons.lock_outline, text: 'Confirm Password'),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: new RichText(
                  text: new TextSpan(
                    style: TextStyle(fontSize: FontSize.h5FontSize),
                    text:
                        'By signing up you indicate that you have read and agreed to the ',
                    children: [
                      new TextSpan(
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: CustomColor.red,
                            fontSize: FontSize.h5FontSize),
                        text: 'Terms of Service.',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => print('Tap Here onTap'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          blueButton(
            func: () async {
              print('${firstNameController.text}');
            },
            child: Text(
              'SIGN UP'.toUpperCase(),
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
