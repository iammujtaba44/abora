import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:abora/screens/Trainer/courses_page.dart';
import 'package:abora/screens/Trainer/manage_screen.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:abora/screens/Trainer/upload_single_video_page.dart';
import 'package:abora/screens/settings_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/details_double_container.dart';
import 'package:abora/widgets/details_single_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  // List<Color> _colors = [Colors.deepOrange, Colors.yellow];

  //Auth

  //final AuthService _auth = AuthService();

  double width;
  double height;
  //var _selected;
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xFF30384c), fontWeight: fontWeight);
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void choiceAction(String choice) {
    if (choice == Constants.changeCard) {
      print('changeCard');
    } else if (choice == Constants.addNewCard) {
      print('addNewCard');
    }
  }

  void coursesAction(String value) {
    if (value == Constants.course) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CoursesPage();
      }));
    } else if(value == Constants.timings) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ManageScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = cal();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    final database = Provider.of<DatabaseService>(context);

    return StreamBuilder<TrainerUser>(
        stream: database.currentTrainerUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Constants.trainerUserData = snapshot.data;
            TrainerUser trainerData = snapshot.data;
            return Scaffold(
              backgroundColor: CustomColor.backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'HOME',
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: CustomColor.white),
                      color: Theme.of(context).primaryColor,
                      onSelected: coursesAction,
                      itemBuilder: (BuildContext context) {
                        return Constants.courses.map((String choice) {
                          return PopupMenuItem<String>(
                            textStyle: TextStyle(color: CustomColor.white),
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      }),
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                      // await database.reviewAsync(
                      //     imageURL: 'new image url',
                      //     review: 'It was so amazing working with him.',
                      //     reviewerName: 'Alex');
                    },
                    icon: Icon(
                      Icons.settings,
                      color: CustomColor.white,
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
                      background: _buildContent(
                          name: trainerData.name, bio: trainerData.bio),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          detailsDoubleContainer(context,
                              text: 'Total Views',
                              value: trainerData.totalViews ?? '0',
                              text2: 'This Month Views',
                              value2: trainerData?.thisMonthVisits ?? '0'),
                          SizedBox(
                            height: 20,
                          ),
                          detailsDoubleContainer(context,
                              text: 'Total Sessions Booked',
                              value: trainerData.totalSessionsBooked ?? '0',
                              text2: 'Total Booking This Month',
                              value2: trainerData.totalBookingThisMonth ?? '0'),
                          SizedBox(
                            height: 20,
                          ),
                          detailsSingleContainer(context,
                              text: 'Booking : Visit : Ratio : Conversion Rate',
                              value:
                                  '${trainerData.booking ?? '0'} : ${trainerData.visit ?? '0'} : ${trainerData.ratio ?? '0'} : ${trainerData.conversionRate ?? '0'}%'),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    //    borderRadius: BorderRadius.all(Radius.circular(20.0))
                                  ), //width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: _calendarCarouselNoHeader,
                                ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildContent({
    String name,
    String bio,
  }) {
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
                      name,
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
                          bio ?? '',
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

  // _tableContainer(String _label, Color _color) {
  //   return Container(
  //     padding: EdgeInsets.all(20.0),
  //     child: Text(_label,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: _color,
  //           fontSize: 20.0,
  //         )),
  //   );
  // }

  static Widget _presentIcon(String day) => Text(
        day,
        style: TextStyle(
          color: Colors.green,
        ),
      );

  static Widget _absentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

  evnetsFiller() {
    for (int i = 0; i < len; i++) {
      a = i + 1;
      presentDates.add(new DateTime(2020, 10, a));
    }
    a = 0;
    for (int i = 0; i < len; i++) {
      a = i + 1;
      absentDates.add(new DateTime(2020, 9, a));
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        new Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        new Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }
  }

  cal() {
    return CalendarCarousel<Event>(
      // height: cHeight / 2,
      // width: cwid / 1.2,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      showOnlyCurrentMonthDate: true,
      showHeader: false,
      // headerTextStyle: TextStyle(color: Color.fromRGBO(5, 115, 106, 10)),
      // headerTitleTouchable: true,
      //headerMargin: EdgeInsets.all(1),
      leftButtonIcon: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_left,
          color: Color.fromRGBO(5, 115, 106, 10),
        ),
      ),
      rightButtonIcon: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_right,
          color: Color.fromRGBO(5, 115, 106, 10),
        ),
      ),
      dayPadding: 6,
      daysTextStyle: TextStyle(color: Colors.grey),
      // weekDayBackgroundColor: Color.fromRGBO(228, 229, 230, 10),
      weekdayTextStyle: TextStyle(color: Colors.white),

      customGridViewPhysics: NeverScrollableScrollPhysics(),
      // selectedDateTime: _currentDate2,
      // todayButtonColor: Colors.blue[200],
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 0,

      markedDateMoreShowTotal: null,

      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.green,
      ),
      // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate2.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate2.add(Duration(days: 360)),
    );
  }
}
