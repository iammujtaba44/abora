import 'package:abora/models/user.dart';
import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Client/Home/first_page.dart';
import 'package:abora/screens/Client/Home/home_tab.dart';
import 'package:abora/screens/Client/Home/second_page.dart';
import 'package:abora/screens/Client/Home/thrid_page.dart';

import 'package:abora/screens/Client/rateSession_screen.dart';
import 'package:abora/screens/Client/videoPage_screen.dart';
import 'package:abora/screens/Trainer/appointment.dart';
import 'package:abora/screens/Trainer/courses_page.dart';
import 'package:abora/screens/Trainer/details_page.dart';
import 'package:abora/screens/Trainer/edit_video_page.dart';
import 'package:abora/screens/Trainer/home_page.dart';
import 'package:abora/screens/Trainer/login_page.dart';
import 'package:abora/screens/Trainer/multiuser_login_page.dart';
import 'package:abora/screens/Trainer/multiuser_signup_page.dart';
import 'package:abora/screens/Trainer/payment_page.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';
import 'package:abora/screens/Trainer/profile_page.dart';
import 'package:abora/screens/Trainer/settings_page.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:abora/screens/Trainer/upload_single_video_page.dart';
import 'package:abora/screens/authenticate/authenticate.dart';
import 'package:abora/screens/wrapper.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PrimaryColor = const Color(0xFF5190ED);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0XFF00001e),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Wrapper(),
        ));
  }
}
