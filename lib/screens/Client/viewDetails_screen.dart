import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewDetail extends StatefulWidget {
  @override
  _ViewDetailState createState() => _ViewDetailState();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];

class _ViewDetailState extends State<ViewDetail> {
  double height;

  double width;
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  CalendarController _controller;

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

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("'Trainer's name"),
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
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                                            '3',
                                            style: TextStyle(
                                                color: CustomColor.red),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
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
                                            'Lose 4Kgs in 3 sessions',
                                            style: TextStyle(
                                                color: CustomColor.red),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
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
                                            'One-one-One',
                                            style: TextStyle(
                                                color: CustomColor.red),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
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
                height: 5.0,
              ),
              _calenderContainer(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: blueButton(
                    child: Text(
                      'START SESSION',
                      style: TextStyle(color: CustomColor.white),
                    ),
                    func: () {}),
              )
            ],
          )),
    );
  }

  _calenderContainer() {
    evnetsFiller();
    _calendarCarouselNoHeader = cal();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment,
            children: [
              dot(CustomColor.green),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Sessions Booked',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
              Spacer(),
              Text('July, 2020',
                  style: TextStyle(color: Colors.white, fontSize: 17.0))
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              //    borderRadius: BorderRadius.all(Radius.circular(20.0))
            ), //width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: _calendarCarouselNoHeader,
          ),
        ],
      ),
    );
  }

  dot(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(1000))),
    );
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

  static Widget _presentIcon(String day) => Text(
        day,
        style: TextStyle(
          color: Colors.green,
        ),
      );

  static Widget _absentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
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
