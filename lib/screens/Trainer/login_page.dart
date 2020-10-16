import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Client/Home/home_tab.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/Trainer/multiuser_login_page.dart';

import 'package:abora/widgets/blue_button.dart';
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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 30,
              ),
              Text(
                'Your Personal Trainer',
                style: TextStyle(
                    color: CustomColor.red,
                    fontSize: FontSize.h2FontSize,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'A platform to over 12 Million members around the global of the world',
                style: TextStyle(
                  color: CustomColor.white,
                  fontSize: FontSize.h3FontSize,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Click here to what platform want to join',
                style: TextStyle(
                  color: CustomColor.white,
                  fontSize: FontSize.h5FontSize,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              blueButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(color: CustomColor.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: CustomColor.white,
                      ),
                    ],
                  ),
                  func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottonNavControllerTrainer()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              blueButton(
                func: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottonNavControllerClient()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SIGN UP   ',
                      style: TextStyle(color: CustomColor.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: CustomColor.white,
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
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
