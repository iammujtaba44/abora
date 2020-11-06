import 'package:abora/global/colors.dart';
import 'package:abora/widgets/bottomNav_widget.dart';
import 'package:flutter/material.dart';

import '../../../global/colors.dart';
import '../Progress_screen.dart';
import '../mybookings_screen.dart';
import '../news_screen.dart';
import 'home_tab.dart';

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
      home: BottonNavControllerClient(),
    );
  }
}

class BottonNavControllerClient extends StatefulWidget {
  @override
  _BottonNavControllerClientState createState() =>
      _BottonNavControllerClientState();
}

class _BottonNavControllerClientState extends State<BottonNavControllerClient> {
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
        children: [HomeTabs(), Mybookings(), ProgressScreen(), NewsPage()],
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
          text2: 'My Bookings',
          imageURL3: 'assets/progress_icon.png',
          text3: 'Progress',
          imageURL4: 'assets/news_icon.png',
          text4: 'News'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
