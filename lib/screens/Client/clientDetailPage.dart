import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/screens/Client/news_screen.dart';
import 'package:abora/screens/Client/rateSession_screen.dart';
import 'package:abora/screens/settings_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClientDetailPage extends StatefulWidget {
  final detailsData;
  const ClientDetailPage({Key key, this.detailsData}) : super(key: key);
  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final CollectionReference client =
      FirebaseFirestore.instance.collection('client');

  final CollectionReference appointments =
  FirebaseFirestore.instance.collection('appointments');

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
  int listCount;
  int noOfCompleteSession;

  @override
  void initState() {
    super.initState();
    // print(widget.detailsData['docId']);
    listCount = int.parse(widget.detailsData['noOfBookings']) - int.parse(widget.detailsData['noOfCompleteSession']);
    noOfCompleteSession = int.parse(
        widget.detailsData['noOfCompleteSession']);
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<DatabaseService>(context);
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
                    color: CustomColor.white),
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
                                          style: TextStyle(
                                              color: CustomColor.white),
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
                                          style: TextStyle(
                                              color: CustomColor.white),
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
                                          style: TextStyle(
                                              color: CustomColor.white),
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
            Center(child: Text('Remaining Session(s): $listCount', style: TextStyle(color: Colors.white),)),
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listCount,
                itemBuilder: (context, index) {
                  return Column(
                    children: [

                    Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Session $index',
                        style:
                        TextStyle(color: CustomColor.white),
                      ),
                      GestureDetector(
                        onTap: () async {

                          _showModalBottomSheet(context);

                        }

                          ,
                        child: Row(
                          children: [
                            Text(
                              'Mark As Complete',
                              style: TextStyle(
                                  color: CustomColor.blue),
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

                      SizedBox(height: 10,),
                    ],
                  );
                }),
            /*Container(
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
            ),*/
            ( widget.detailsData['get'] == '0' && (int.parse(widget.detailsData['noOfBookings']) == int.parse(widget.detailsData['noOfCompleteSession']) ) )
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: blueButton(
                        child: Text(
                          'Give Review',
                          style: TextStyle(color: CustomColor.white),
                        ),
                        func: () async {
                          var document = await client
                              .doc(Constants.currentUserID)
                              .collection('progress')
                              .doc('weight')
                              .get();

                          if (!document.exists) {
                            print('there is not weight data');
                            onAlertWithCustomContentPressed(context);
                          } else {
                            print('weight data is there');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RateSession(
                                        trainerData: {
                                          'email': widget
                                              .detailsData['trainerEmail'],
                                          'url':
                                              widget.detailsData['trainerUrl'],
                                          'docId': widget.detailsData['docId']
                                        },
                                      )),
                            );
                          }
                        }),
                  )
                : SizedBox()
          ],
        ));
  }

  Widget _presentIcon(String day) => Container(
        width: 23,
        height: 27,
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
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      );

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

  TextEditingController initialWeightController = TextEditingController();
  TextEditingController initialBenchpressController = TextEditingController();
  TextEditingController initialdeadliftsController = TextEditingController();
  TextEditingController initialLegPressController = TextEditingController();

  _showModalBottomSheet(context, {var cartItem, var user, var index}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: CustomColor.blue,
        isScrollControlled: true,
        builder: (BuildContext ctxz) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Are you sure you want to delete this item? ', style: TextStyle(color: CustomColor.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: FlatButton(
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(child: RaisedButton(child: Text('Yes'), onPressed: () async {

                                  setState(() {
                                    listCount--;
                                  });

                                  customToast(text: 'Please wait...', bgcolor: Colors
                                      .black);
                                  await appointments
                                      .doc('upcomingApointments')
                                      .collection('data').doc(
                                      widget.detailsData['docId']).update({
                                    'noOfCompleteSession': ( int.parse(widget.detailsData['noOfBookings']) - listCount )
                                        .toString() + ""
                                  });

                                  customToast(
                                      text: 'Session completed...', bgcolor: Colors
                                      .black);

                                  Navigator.of(context).pop();
                                },))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  onAlertWithCustomContentPressed(context) {
    Alert(
        style: AlertStyle(
            titleStyle: TextStyle(color: CustomColor.white),
            backgroundColor: CustomColor.backgroundColor),
        context: context,
        title: "Session Started",
        content: Column(
          children: <Widget>[
            TextField(
              controller: initialWeightController,
              style: TextStyle(color: CustomColor.white),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  labelText: 'Enter you current weight',
                  labelStyle: TextStyle(color: CustomColor.white)),
            ),
            TextField(
              controller: initialBenchpressController,
              style: TextStyle(color: CustomColor.white),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  labelText: 'Enter you current Benchpress weight',
                  labelStyle: TextStyle(color: CustomColor.white)),
            ),
            TextField(
              controller: initialdeadliftsController,
              style: TextStyle(color: CustomColor.white),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  labelText: 'Enter you current Deadlifts weight',
                  labelStyle: TextStyle(color: CustomColor.white)),
            ),
            TextField(
              controller: initialLegPressController,
              style: TextStyle(color: CustomColor.white),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.white)),
                  labelText: 'Enter you current Legpress weight',
                  labelStyle: TextStyle(color: CustomColor.white)),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              print(initialWeightController.text);
              print(initialBenchpressController.text);
              print(initialLegPressController.text);
              print(initialdeadliftsController.text);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RateSession(
                          trainerData: {
                            'isFirstTime': true,
                            'initialWeight': initialWeightController.text,
                            'initialbenchpressWeight':
                                initialBenchpressController.text,
                            'initialdeadliftsWeight':
                                initialdeadliftsController.text,
                            'initiallegpressWeight':
                                initialLegPressController.text,
                            'email': widget.detailsData['trainerEmail'],
                            'url': widget.detailsData['trainerUrl'],
                            'docId': widget.detailsData['docId']
                          },
                        )),
              );
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
        color: CustomColor.white,
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
// Widget _absentIcon(String day) => Container(
//       decoration: BoxDecoration(
//         color: CustomColor.white,
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
}
