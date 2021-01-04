import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/news_screen.dart';
import 'package:abora/screens/Trainer/manage_screen.dart';
import 'package:abora/widgets/bottomNav_widget.dart';
import 'package:flutter/material.dart';

import 'appointment.dart';
import 'courses_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

void main() {
  runApp(MyApp());
}

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
      home: BottonNavControllerTrainer(),
    );
  }
}

class BottonNavControllerTrainer extends StatefulWidget {
  @override
  _BottonNavControllerTrainerState createState() =>
      _BottonNavControllerTrainerState();
}

class _BottonNavControllerTrainerState
    extends State<BottonNavControllerTrainer> {
  PageController pageController;

  int pageIndex = 0;

  onTapChangedPage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: PageView(
        children: [
          //ManageScreen(),
          HomePage(),
          AppointmentPage(),
          NewsPage(),
          ProfilePage(),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: bottomNavBar(
          onTapChangedPage: onTapChangedPage,
          pageIndex: pageIndex,
          imageURL: 'assets/home_icon.png',
          text: 'Home',
          imageURL2: 'assets/appointment_menu_icon.png',
          text2: 'Appointment',
          imageURL3: 'assets/news_icon.png',
          text3: 'News',
          imageURL4: 'assets/profile_menu_icon.png',
          text4: 'Me'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
