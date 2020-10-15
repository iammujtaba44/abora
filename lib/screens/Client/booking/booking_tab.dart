import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/Home/first_page.dart';
import 'package:abora/screens/Client/Home/second_page.dart';
import 'package:abora/screens/Client/Home/thrid_page.dart';
import 'package:abora/screens/Client/booking/book_course.dart';
import 'package:abora/screens/Client/booking/booking_screen.dart';

import 'package:abora/screens/Client/mybookings_screen.dart';
import 'package:abora/screens/Trainer/courses_page.dart';
import 'package:abora/widgets/bottomNav_widget.dart';
import 'package:flutter/material.dart';
import 'package:preview/preview.dart';

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
      home: BookingTab(),
    );
  }
}

class BookingTab extends StatefulWidget {
  @override
  _BookingTabState createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('BOOKING'),
            centerTitle: true,
            leading: Icon(
              Icons.arrow_back_ios,
              color: CustomColor.red,
            ),

            actions: [
              Image.asset(
                'assets/logo.png',
                width: 50,
                height: 50,
              ),
            ],

            //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottom: TabBar(
              labelColor: CustomColor.red,
              unselectedLabelColor: CustomColor.grey,
              indicatorColor: CustomColor.red,
              tabs: [
                Tab(child: Text('Book Sesson')),
                Tab(child: Text('Book Course')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BookingScreen(),
              BookCourse(),
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
