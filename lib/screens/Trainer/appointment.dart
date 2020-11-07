import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/models/trainer_models/apointmentModel.dart';
import 'package:abora/screens/Trainer/details_page.dart';
import 'package:abora/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      home: AppointmentPage(),
    );
  }
}

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  double height;
  double width;
  // ignore: unused_field
  CalendarController _controller;
  DatabaseService database;

  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xFF30384c), fontWeight: fontWeight);
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);
    database = Provider.of<DatabaseService>(context);
    // evnetsFiller();
    // _calendarCarouselNoHeader = cal();
    return Scaffold(
        appBar: AppBar(
          title: Text('APPOINTMENT'),
          leading: Container(),
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/logo.png',
              width: 40,
              height: 100,
            ),
          ],
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: StreamProvider<List<AppointmentModel>>.value(
          value: database.apintmentStream,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25.w,
                        ),
                        Container(
                            width: 180.w,
                            decoration: BoxDecoration(
                                color: CustomColor.backgroundColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Weekly',
                                    style: TextStyle(color: CustomColor.red),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: CustomColor.red,
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 25.w,
                        ),
                        Container(
                            width: 180.w,
                            decoration: BoxDecoration(
                                color: CustomColor.backgroundColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    '2020',
                                    style: TextStyle(color: CustomColor.red),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: CustomColor.red,
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Calender(
                      database: database,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 15.0),
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: CustomColor.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Session Booked',
                            style: TextStyle(
                              color: CustomColor.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Appointments',
                            style:
                                TextStyle(color: CustomColor.red, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          UpcomingSession(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Previous Appointments',
                            style:
                                TextStyle(color: CustomColor.red, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PreviousSession(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

class UpcomingSession extends StatefulWidget {
  _UpcomingSessionState createState() => _UpcomingSessionState();
}

class _UpcomingSessionState extends State<UpcomingSession> {
  @override
  Widget build(BuildContext context) {
    List<AppointmentModel> apoint =
        Provider.of<List<AppointmentModel>>(context);
    return Column(
      children: List.generate(apoint.length, (index) {
        if (apoint[index].trainerEmail == Constants.trainerUserData.email) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: CustomColor.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              apoint[index].clientName,
                              style: TextStyle(color: CustomColor.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            detailsData: {
                                              'clientName':
                                                  apoint[index].clientName,
                                              'noOfBookings':
                                                  apoint[index].noOfBookings,
                                              'sessionType':
                                                  apoint[index].sessionType,
                                              'goal': apoint[index].goal,
                                              'dates': apoint[index].dates
                                            },
                                          )),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyle(color: CustomColor.blue),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: CustomColor.blue,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No of Bookings:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].noOfBookings,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Session Type:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].sessionType,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Goal:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].goal,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: CustomColor.grey,
                ),
              )
            ],
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}

class PreviousSession extends StatefulWidget {
  _PreviousSessionState createState() => _PreviousSessionState();
}

class _PreviousSessionState extends State<PreviousSession> {
  @override
  Widget build(BuildContext context) {
    List<AppointmentModel> apoint =
        Provider.of<List<AppointmentModel>>(context);
    return Column(
      children: List.generate(apoint.length, (index) {
        if (apoint[index].trainerEmail == Constants.trainerUserData.email) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: CustomColor.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              apoint[index].clientName,
                              style: TextStyle(color: CustomColor.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            detailsData: {
                                              'clientName':
                                                  apoint[index].clientName,
                                              'noOfBookings':
                                                  apoint[index].noOfBookings,
                                              'sessionType':
                                                  apoint[index].sessionType,
                                              'goal': apoint[index].goal,
                                              'dates': apoint[index].dates
                                            },
                                          )),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyle(color: CustomColor.blue),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: CustomColor.blue,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No of Bookings:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].noOfBookings,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Session Type:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].sessionType,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Goal:',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Text(
                              apoint[index].goal,
                              style: TextStyle(color: CustomColor.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: CustomColor.grey,
                ),
              )
            ],
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}

class Calender extends StatefulWidget {
  // final double height;
  // //final double width;
  //
  // Calender({this.height});
  final DatabaseService database;

  Calender({this.database});

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a = 0;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<DateTime> presentDates = [];
  List<DateTime> absentDates = [];
  @override
  Widget build(BuildContext context) {
    //Stream<List<AppointmentModel>> apoint2 = widget.database.apintmentStream;
    List<AppointmentModel> apoint =
        Provider.of<List<AppointmentModel>>(context);

    // print(apoint.length);

    Widget _presentIcon(String day) => Container(
          width: 23,
          height: 27,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        );

    evnetsFiller() {
      for (int i = 0; i < apoint.length; i++) {
        if (apoint[i].trainerEmail == Constants.trainerUserData.email) {
          for (int j = 0; j < apoint[i].dates.length; j++) {
            var array = apoint[i].dates[j].split('-');
            presentDates.add(new DateTime(
                int.parse(array[0]), int.parse(array[1]), int.parse(array[2])));
            a++;
          }
        }
        //a = i + 1;

      }

      for (int i = 0; i < a; i++) {
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
    }

    cal2() {
      return CalendarCarousel<Event>(
        // height: cHeight / 2,
        // width: cwid / 1.2,
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate2 = date);
          events.forEach((event) => print(event.title));
        },
        showOnlyCurrentMonthDate: true,
        showHeader: false,
        weekdayTextStyle: TextStyle(color: Colors.white),
        dayPadding: 6,
        daysTextStyle: TextStyle(color: Colors.grey),
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),

        customGridViewPhysics: NeverScrollableScrollPhysics(),
        selectedDateTime: _currentDate2,
        todayButtonColor: Colors.blue[200],
        markedDatesMap: _markedDateMap,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        markedDateMoreShowTotal: null,

        markedDateCustomTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        // null for not showing hidden events indicator
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        minSelectedDate: _currentDate2.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate2.add(Duration(days: 360)),
      );
    }

    evnetsFiller();
    _calendarCarouselNoHeader = cal2();
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        //    borderRadius: BorderRadius.all(Radius.circular(20.0))
      ), //width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.7,
      child: _calendarCarouselNoHeader,
    );
  }
}
