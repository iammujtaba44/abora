import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/login_page.dart';
import 'package:abora/services/auth.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box.dart/alert.dart';
import 'package:abora/widgets/dialog_box.dart/alert_style.dart';
import 'package:abora/widgets/settings_list_tile.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';
import 'package:table_calendar/table_calendar.dart';

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
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double height;

  double width;

  CalendarController _controller;
  AuthService _auth = AuthService();

  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xFF30384c), fontWeight: fontWeight);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SETTING',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          leading: Container(),
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/logo.png',
              width: 50,
              height: 130,
            ),
          ],
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            settingsListTile(
                context, 'assets/user_icon.png', 'Account Settings'),
            settingsListTile(
                context, 'assets/card_icon.png', 'Payment Settings'),
            settingsListTile(context, 'assets/refund_icon.png', 'Refund'),
            settingsListTile(context, 'assets/help_icon.png', 'FAQ\'s'),
            settingsListTile(context, 'assets/report_icon.png', 'Report'),
            GestureDetector(
                onTap: () async {
                  await _auth.signOut();
                },
                child: settingsListTile(
                    context, 'assets/logout_icon.png', 'Logout')),
          ],
        ));
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
      context: context,
      buttons: [],
      title: '',
      desc: "Video Updated Successful !",
      image: Image.asset('assets/dialog_img.png'),
    ).show();
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
  String get title => 'Iphone X';
  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.ipadPro12,
          child: MyApp(),
        ),
      ];
}
