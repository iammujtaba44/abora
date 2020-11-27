import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/loading_widget.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

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
  final Function toggleView;
  MultiuserSignUpPage({this.toggleView});

  @override
  _MultiuserSignUpPageState createState() => _MultiuserSignUpPageState();
}

class _MultiuserSignUpPageState extends State<MultiuserSignUpPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController,
      lastNameController,
      emailController,
      passwordController,
      confirmPassowrdController;

  int _index = 0;
  bool isChecked = false;
  List<String> postcodes = List();
  String selectedPostcode;
  loadAsset() async {
    final myData = await rootBundle.loadString('assets/postcodes.txt');

    var datt = myData.split(',');
    postcodes = datt;
    // print(postcodes);
  }

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassowrdController = TextEditingController();
    loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.1,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
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
                tabs(context),
                SizedBox(
                  height: 20,
                ),
                signUp(context),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: CustomColor.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: CustomColor.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            customTextField(
                validator: 'Enter First Name',
                iconData: Icons.person,
                text: 'First Name',
                controller: firstNameController),
            SizedBox(
              height: 20,
            ),
            customTextField(
                validator: 'Enter Last Name',
                iconData: Icons.person,
                text: 'Last Name',
                controller: lastNameController),
            SizedBox(
              height: 20,
            ),
            customTextField(
                validator: 'Enter an Email',
                iconData: Icons.email,
                text: 'Email Address',
                controller: emailController),
            SizedBox(
              height: 20,
            ),
            customTextField(
                makeObscure: true,
                passwordValid: true,
                validator: 'Enter Your Password',
                iconData: Icons.lock_outline,
                text: 'Password',
                controller: passwordController),
            SizedBox(
              height: 20,
            ),
            customTextField(
                makeObscure: true,
                passwordValid: true,
                validator: 'Enter Confirm Password',
                iconData: Icons.lock_outline,
                text: 'Confirm Password',
                controller: confirmPassowrdController),
            SizedBox(
              height: 20,
            ),
            _index == 1
                ? Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      // padding: EdgeInsets.only(left: 50.0, right: 15.0),
                      //  width: 120.0,
                      //  height: 100.0,
                      // padding: const EdgeInsets.only(
                      //     left: 20.0, right: 20, top: 20.0, bottom: 20),
                      // alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          //color: Theme.of(context).primaryColor,
                          color: CustomColor.orangeColor,
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropDownField(
                          onValueChanged: (dynamic value) {
                            selectedPostcode = value.toString().toUpperCase();
                          },
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: CustomColor.white,
                            letterSpacing: 1.2,
                          ),
                          value: selectedPostcode,
                          required: false,
                          hintText: 'Choose a postcode',
                          labelText: 'Postcode',
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.5)),
                          items: postcodes,
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            color: CustomColor.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
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
                              color: CustomColor.white,
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
            Constants.isLoading
                ? loadingWidget()
                : blueButton(
                    func: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          confirmPassowrdController.text.isNotEmpty &&
                          selectedPostcode != null) {
                        if (passwordController.text ==
                            confirmPassowrdController.text) {
                          setState(() {
                            Constants.isLoading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              name:
                                  "${firstNameController.text + " " + lastNameController.text}",
                              index: _index,
                              area: selectedPostcode);

                          if (result == null) {
                            print('Sorry couldn\'t register');
                            setState(() {
                              Constants.isLoading = false;
                            });
                          } else if (result != null) {
                            emailController.clear();
                            passwordController..clear();
                            firstNameController..clear();
                            lastNameController.clear();
                            confirmPassowrdController.clear();
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) => HomePage()));
                          }
                        } else
                          customToast(text: 'Passwords does not match');
                      } else
                        customToast(text: 'Please fill all fiels first');

                      // if (_formKey.currentState.validate()) {

                      // }

                      // print('${firstNameController.text}');
                    },
                    child: Text(
                      'SIGN UP'.toUpperCase(),
                      style: TextStyle(color: CustomColor.white),
                    ),
                  ),
          ],
        ),
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
                            _index == 0 ? CustomColor.white : CustomColor.white,
                      ),
                      Text(
                        'I\'m a Trainer',
                        style: TextStyle(
                          color: _index == 0
                              ? CustomColor.white
                              : CustomColor.white,
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
                          color: CustomColor.white,
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
                            _index == 1 ? CustomColor.white : CustomColor.white,
                      ),
                      Text(
                        'I\'m a Client',
                        style: TextStyle(
                          color: _index == 1
                              ? CustomColor.white
                              : CustomColor.white,
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
                          color: CustomColor.white,
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
