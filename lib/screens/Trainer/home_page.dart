import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';

import 'package:abora/widgets/details_double_container.dart';
import 'package:abora/widgets/details_single_container.dart';
import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:preview/preview.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unicorndial/unicorndial.dart';

import 'courses_page.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  List<Color> _colors = [Colors.deepOrange, Colors.yellow];

  double width;
  double height;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),

        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: CustomColor.signUpButtonColor,
        foregroundColor: CustomColor.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.orange,
            label: 'Post Ad',
            onTap: () => print('Post Ad'),
          ),
          SpeedDialChild(
            child: Icon(Icons.cloud_upload),
            backgroundColor: Colors.red,
            label: 'Upload Video',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursesPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Colors.red,
          child: BottomNavigationBar(
            backgroundColor: CustomColor.signUpButtonColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text(
                    'Home',
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/appointment_menu_icon.png'),
                  title: Text('Appointment')),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/dumbbell_icon.png'),
                  title: Text('My Courses')),
              BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/profile_menu_icon.png',
                    color: Colors.red,
                  ),
                  icon: Image.asset('assets/profile_menu_icon.png'),
                  title: Text('My Courses')),
            ],
            selectedItemColor: CustomColor.white,
            unselectedItemColor: CustomColor.bottomNavInactiveColor,
          ),
        ),
      ),
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HOME',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: CustomColor.red,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: height / 3,
            leading: Container(),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildContent(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  detailsDoubleContainer(context,
                      text: 'Total Views',
                      value: '2.5K',
                      text2: 'This Month Visits',
                      value2: '45.6K'),
                  SizedBox(
                    height: 20,
                  ),
                  detailsDoubleContainer(context,
                      text: 'Total Views',
                      value: '2.5K',
                      text2: 'This Month Visits',
                      value2: '45.6K'),
                  SizedBox(
                    height: 20,
                  ),
                  detailsSingleContainer(context,
                      text: 'Booking : Visit : Ratio : Conversion Rate',
                      value: '16 : 16 : 16 : 48%'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TableCalendar(
                          headerVisible: false,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            weekdayStyle: dayStyle(FontWeight.normal),
                            weekendStyle: dayStyle(FontWeight.normal),
                            selectedColor: CustomColor.signUpButtonColor,
                            todayColor: Color(0xff30374b),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: CustomColor.white,
                              fontSize: 16,
                            ),
                            weekendStyle: TextStyle(
                                color: CustomColor.white, fontSize: 16),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: true,
                            titleTextStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          calendarController: _controller,
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/trainer.jpg'))),
              height: height / 3,
              width: double.infinity,
            ),
            Positioned(
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Davei Samah',
                      style: TextStyle(
                          fontSize: FontSize.h3FontSize,
                          color: CustomColor.white),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                        width: width / 1.1,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
                          style: TextStyle(color: CustomColor.white),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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
