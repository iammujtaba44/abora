import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/loading_widget.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiuserLoginPage extends StatefulWidget {
  final Function toggleView;
  MultiuserLoginPage({this.toggleView});

  @override
  _MultiuserLoginPageState createState() => _MultiuserLoginPageState();
}

class _MultiuserLoginPageState extends State<MultiuserLoginPage> {
  int _index = 0;
  bool rememberMe;
  String email;
  String password;

  AuthService _auth = AuthService();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.1,
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
                    tabs(context),
                    SizedBox(
                      height: 20,
                    ),
                    login(context),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: CustomColor.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: CustomColor.red),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsRememberMe = prefs.getBool('rememberMe');
    final prefsEmail = prefs.getString('email');
    final prefsPassword = prefs.getString('password');

    if (prefsEmail != null) {
      emailTextEditingController.text = prefs.getString('email');
    }
    if (prefsPassword != null) {
      passwordTextEditingController.text = prefs.getString('password');
    }
    if (prefsRememberMe != null) {
      rememberMe = prefs.getBool('rememberMe');
    } else {
      rememberMe = false;
    }
    setState(() {});
  }

  rememberCredentials(String email, String password, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('rememberMe', rememberMe);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', rememberMe);
    }
  }

  Widget login(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customTextField(
              iconData: Icons.email,
              text: 'Email Address',
              controller: emailTextEditingController),
          SizedBox(
            height: 20,
          ),
          customTextField(
              iconData: Icons.lock_outline,
              text: 'Password',
              controller: passwordTextEditingController),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    rememberMe = !rememberMe;
                    rememberCredentials(emailTextEditingController.text,
                        passwordTextEditingController.text, rememberMe);
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: rememberMe ? CustomColor.green : null,
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
          Constants.isLoading
              ? loadingWidget()
              : blueButton(
                  func: () async {
                    setState(() {});
                    Constants.isLoading = true;
                    await _auth.signInWithEmailAndPassword(
                        emailTextEditingController.text,
                        passwordTextEditingController.text,
                        _index);
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

  Widget tabs(BuildContext context) {
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
