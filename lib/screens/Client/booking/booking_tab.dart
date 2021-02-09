import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/booking/book_course.dart';
import 'package:abora/screens/Client/booking/booking_screen.dart';

import 'package:flutter/material.dart';

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
  final String email;
  final String name;
  final String bio;
  final String session1;
  final String session2;
  final String session3;
  final String noOfSession1;
  final String noOfSession2;
  final String noOfSession3;
  final String monTo,monFrom;
  final String tueTo,tueFrom;
  final String wedTo,wedFrom;
  final String thurTo,thurFrom;
  final String friTo,friFrom;
  final String satTo,satFrom;
  final String sunTo,sunFrom;


  BookingTab({this.email, this.name, this.bio,
    this.session1, this.session2, this.session3,
    this.noOfSession1, this.noOfSession2, this.noOfSession3,
    this.monTo,
    this.monFrom,
    this.tueFrom,
    this.tueTo,
    this.wedFrom,
    this.wedTo,
    this.thurFrom,
    this.thurTo,
    this.friFrom,
    this.friTo,
    this.satFrom,
    this.satTo,
    this.sunFrom,
    this.sunTo});

  @override
  _BookingTabState createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text('BOOKING'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CustomColor.white,
              ),
              onPressed: () => Navigator.pop(context),
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
              labelColor: CustomColor.white,
              unselectedLabelColor: CustomColor.grey,
              indicatorColor: CustomColor.white,
              tabs: [
                Tab(child: Text('Book Session')),

              ],
            ),
          ),
          body: TabBarView(
            children: [
              BookingScreen(
                  email: widget.email, name: widget.name, bio: widget.bio,
                session1: widget.session1,
                session2: widget.session2,
                session3: widget.session3,
                noOfSession1: widget.noOfSession1,
                noOfSession2: widget.noOfSession2,
                noOfSession3: widget.noOfSession3,
                 monTo: widget.monTo ,
                  monFrom: widget.monFrom ,
                  tueFrom: widget.tueFrom ,
                  tueTo: widget.tueTo ,
                  wedFrom: widget.wedFrom ,
                  wedTo: widget.wedTo,
                  thurFrom: widget.thurFrom ,
                  thurTo: widget.thurTo ,
                  friFrom: widget.friFrom ,
                  friTo: widget.friTo ,
                  satFrom: widget.satFrom ,
                  satTo: widget.satTo ,
                  sunFrom: widget.sunFrom ,
                  sunTo: widget.sunTo



              ),

            ],
          ),
        ),
      ),
    );
  }
}
