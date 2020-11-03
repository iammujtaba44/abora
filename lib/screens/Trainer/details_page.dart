import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/news_screen.dart';
import 'package:abora/screens/settings_page.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
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
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatefulWidget {
  final detailsData;
  const DetailPage({Key key, this.detailsData}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double height;

  double width;

  // ignore: unused_field
  CalendarController _controller;

  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xFF30384c), fontWeight: fontWeight);
  }

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

    // print(widget.DetailsData['dates']);
    evnetsFiller();
    _calendarCarouselNoHeader = cal2();
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: CustomColor.red),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsPage()),
                  );
                },
                child: Text(
                  widget.detailsData['clientName'],
                  style: TextStyle(
                      fontSize: 17,
                      color: CustomColor.white,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
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
              height: 20,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'No of Bookings:',
                                          style: TextStyle(
                                              color: CustomColor.white),
                                        ),
                                        Text(
                                          widget.detailsData['noOfBookings'],
                                          style:
                                              TextStyle(color: CustomColor.red),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Goal:',
                                          style: TextStyle(
                                              color: CustomColor.white),
                                        ),
                                        Text(
                                          widget.detailsData['goal'],
                                          style:
                                              TextStyle(color: CustomColor.red),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Session Type:',
                                          style: TextStyle(
                                              color: CustomColor.white),
                                        ),
                                        Text(
                                          widget.detailsData['sessionType'],
                                          style:
                                              TextStyle(color: CustomColor.red),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 30.0, left: 30.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                              width: 10,
                            ),
                            Text(
                              'Session Booked',
                              style: TextStyle(
                                color: CustomColor.white,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'July, 2020',
                          style: TextStyle(color: CustomColor.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      //    borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ), //width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.7,
                    child: _calendarCarouselNoHeader,
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: blueButton(
                  child: Text(
                    'START SESSION',
                    style: TextStyle(color: CustomColor.white),
                  ),
                  func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  }),
            )
          ],
        ));
  }

  Widget _presentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.green,
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

  // Widget _absentIcon(String day) => Container(
  //       decoration: BoxDecoration(
  //         color: Colors.red,
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(1000),
  //         ),
  //       ),
  //       child: Center(
  //         child: Text(
  //           day,
  //           style: TextStyle(
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //     );

  evnetsFiller() {
    List<String> aa = widget.detailsData['dates'];
    print(aa);
    for (int i = 0; i < aa.length; i++) {
      var array = aa[i].split('-');
      presentDates.add(new DateTime(
          int.parse(array[0]), int.parse(array[1]), int.parse(array[2])));
      a++;
      //a = i + 1;

    }
    // presentDates.forEach((element) {
    //   print(element);
    // });
    // print(a);
    // for (int i = 0; i < len; i++) {
    //   a = i + 1;
    //   absentDates.add(new DateTime(2020, 9, a));
    // }

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

    // for (int i = 0; i < len; i++) {
    //   _markedDateMap.add(
    //     absentDates[i],
    //     new Event(
    //       date: absentDates[i],
    //       title: 'Event 5',
    //       icon: _absentIcon(
    //         absentDates[i].day.toString(),
    //       ),
    //     ),
    //   );
    // }
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
