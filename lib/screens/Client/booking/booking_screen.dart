import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/height.dart';

import 'package:abora/screens/Client/ClientPayment_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/utils/Helper.dart';
import 'package:abora/widgets/CustomToast.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final String name;
  final String bio;
  final String email;
  final String session1;
  final String session2;
  final String session3;
  final String noOfSession1;
  final String noOfSession2;
  final String noOfSession3;
  final String monTo, monFrom;
  final String tueTo, tueFrom;
  final String wedTo, wedFrom;
  final String thurTo, thurFrom;
  final String friTo, friFrom;
  final String satTo, satFrom;
  final String sunTo, sunFrom;

  BookingScreen(
      {this.name,
      this.bio,
      this.email,
      this.session1,
      this.session2,
      this.session3,
      this.noOfSession1,
      this.noOfSession2,
      this.noOfSession3,
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
  _BookingScreenState createState() => _BookingScreenState();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];

class _BookingScreenState extends State<BookingScreen> {
  TimeOfDay pickedMonFrom;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  TextEditingController goalTextFieldController = TextEditingController();
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a = 0;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<String> _selectedDates = [];
  List<int> _values;

  List<String> _timing;
  List<String> _goalString = <String>[
    'Face to face',
    'Video call',
  ];

  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');
  var _selected;
  var _selectedSession;

  List<String> numOfSessions;
  List<String> priceOfSessions;

  @override
  void initState() {
    super.initState();
    evenFiller();
    priceOfSessions = [
      '${widget.session1}',
      '${widget.session2}',
      '${widget.session3}'
    ];
    numOfSessions = [
      '${widget.noOfSession1}',
      '${widget.noOfSession2}',
      '${widget.noOfSession3}'
    ];
    _values = [
      int.parse(widget.noOfSession1),
      int.parse(widget.noOfSession2),
      int.parse(widget.noOfSession3),
    ];
    _timing = [
      widget.monTo,
      widget.monFrom,
      widget.tueFrom,
      widget.tueTo,
      widget.wedFrom,
      widget.wedTo,
      widget.thurFrom,
      widget.thurTo,
      widget.friFrom,
      widget.friTo,
      widget.satFrom,
      widget.satTo,
      widget.sunFrom,
      widget.sunTo
    ];
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);

    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    //evnetsFiller();
    _calendarCarouselNoHeader = cal2();

    //final database = Provider.of<DatabaseService>(context);

    return Scaffold(
      body: Container(
        height: getheight(context),
        color: CustomColor.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _mainContainer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: blueButton(
                    child: Text(
                      'Confirm Booking'.toUpperCase(),
                      style: TextStyle(color: CustomColor.white),
                    ),
                    func: () {
                      // print(_selectedDates);
                      if (_selected != null &&
                          _selectedSession != null &&
                          goalTextFieldController.text.isNotEmpty
                          ) {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientPaymentPage(
                                        addAp: {
                                          'clientEmail':
                                              Constants.clientUserData.email,
                                          'clientImageUrl': 'abc',
                                          'clientName':
                                              Constants.clientUserData.name,
                                          'dates': _selectedDates,
                                          'goal': goalTextFieldController.text,
                                          'noOfBookings': _selected,
                                          'sessionType': _selectedSession,
                                          'trainerEmail': widget.email,
                                          'trainerImageUrl': 'abc',
                                          'trainerName': widget.name,
                                          'noOfCompleteSession': "0",
                                          //'numOfSessionList': List<int>.generate(int.parse(_selected), (int index) => index )


                                        },
                                      )));

                      } else {
                        customToast(
                            text: 'please fill all the fields to continue');
                        customToast(
                            text:
                                'Select Dates from Calender by clicking dates');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _mainContainer() {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: [
          _topContainer(),
          _secondContainer(),
          _dropdownContainer(),
          _fields(),
          /*Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Availability calendar',
                  style:
                      TextStyle(color: CustomColor.orangeColor, fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    //    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ), //width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: _calendarCarouselNoHeader,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dot(CustomColor.green),
                    Text(
                      'Booked Sessions ',
                      style: TextStyle(color: Colors.white),
                    ),
                    dot(CustomColor.orangeColor),
                    Text('Not Working', style: TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  dot(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }

  _topContainer() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/trainer.jpg'),
                      fit: BoxFit.cover),
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.bio,
                      style: TextStyle(color: Colors.grey.withOpacity(0.5))),
                ],
              ))
        ],
      ),
    );
  }

  _secondContainer() {
    return Container(
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price",
              style: TextStyle(color: Color(0xFFD03D2A), fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              // margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(
                    color: Colors.grey.withOpacity(0.5), width: 1),
                children: [
                  TableRow(
                      children: List.generate(3, (index) {
                    return _tableContainer(
                        numOfSessions[index], Color(0xFF43810C));
                  })),
                  TableRow(
                      children: List.generate(3, (index) {
                    return _tableContainer(priceOfSessions[index] ?? '0',
                        Colors.grey.withOpacity(0.5));
                  })),
                ],
              ),
            ),
          ],
        ));
  }

  _fields() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      //padding: EdgeInsets.all(12.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtextfieldWithText(
            text: 'Goal',
            hintText: 'Type here...',
            controller: goalTextFieldController,
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            "Session Type",
            style: TextStyle(color: CustomColor.orangeColor, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 15.0),
            width: 400.0,
            height: 60.0,
            // alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              color: CustomColor.textFieldFilledColor,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              border: Border.all(color: CustomColor.textFieldBorderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: CustomColor.textFieldLabelColor,
                ),
                iconSize: 20,
                dropdownColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white, //CustomColor.textFieldLabelColor,
                  letterSpacing: 1.2,
                ),
                iconEnabledColor: Colors.grey,
                iconDisabledColor: CustomColor.white,
                isDense: true,
                items: _goalString.map((city) {
                  return DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSession = newValue;
                  });
                },
                value: _selectedSession,
                isExpanded: false,
                hint: new Text(
                  "Session Type",
                  style: TextStyle(
                      color: CustomColor.textFieldLabelColor, fontSize: 17.0),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Monday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.monTo == null || widget.monFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.monTo + ' ' + 'From: ' + widget.monFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Tuesday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.tueTo == null || widget.tueFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.tueTo + ' ' + 'From: ' + widget.tueFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Wednesday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.wedTo == null ||  widget.wedFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.wedTo + ' ' + 'From: ' + widget.wedFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Thursday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.thurTo == null ||  widget.thurFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.thurTo + ' ' + 'From: ' + widget.thurFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Friday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),/**/
              Row(
                children: [
                  widget.friTo == null || widget.friFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.friTo + ' ' + 'From: ' + widget.friFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Saturday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.satTo == null || widget.satFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.satTo + ' ' + 'From: ' + widget.satFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Sunday: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.sunTo == null || widget.sunFrom == null
                      ? Text('Unavailable',style: TextStyle(color: Colors.white))
                      : Text('To: ' + widget.sunTo + ' ' + 'From: ' + widget.sunFrom,
                      style: TextStyle(color: Colors.white)),
                ],
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  Text(
                    'Select start session time: ',
                    style: TextStyle(
                        color: CustomColor.blue, fontSize: 18),
                  ),
                  Text(
                    pickedMonFrom != null
                        ? pickedMonFrom.format(context)
                        : '-- : -- ',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18),
                  ),
                  GestureDetector(
                      onTap: () async {
                        pickedMonFrom = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder:
                              (BuildContext context, Widget child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: true),
                              child: child,
                            );
                          },
                        );
                        setState(() {});
                      },
                      child:
                      Icon(Icons.timer, color: Colors.white)),
                ],
              ),
              Row(children: [
                Text('Start Session: '),

              ],)
            ],
          ),

        //  _timingsWidget('Monday', widget.monTo, widget.monFrom),
        /*  _timingsWidget('Tuesday', widget.tueTo, widget.tueFrom),
          _timingsWidget('Wednesday', widget.wedTo, widget.wedFrom),
          _timingsWidget('Thursday', widget.thurTo, widget.thurFrom),
          _timingsWidget('Friday', widget.friTo, widget.friFrom),
          _timingsWidget('Saturday', widget.satTo, widget.satFrom),
          _timingsWidget('Sunday', widget.sunTo, widget.sunFrom),*/
        ],
      ),
    );
  }

/*  _timingsWidget(String day, String to, String from) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '$day: ',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            to == null
                ? Text('Unavailable',style: TextStyle(color: Colors.white))
                : Text('To: ' + to + ' ' + 'From: ' + from,
                    style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }*/

  _dropdownContainer() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 20.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: CustomColor.textFieldFilledColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pick no. Of sessions',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 50.0, right: 15.0),
            width: 120.0,
            height: 40.0,
            // alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: CustomColor.orangeColor,
                ),
                iconSize: 20,
                dropdownColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white, //Colors.grey.withOpacity(0.5),
                  letterSpacing: 1.2,
                ),
                iconEnabledColor: Colors.grey,
                iconDisabledColor: CustomColor.white,
                isDense: true,
                items: _values.map((value) {
                  return DropdownMenuItem(
                    child: Text(value.toString()),
                    value: value,
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selected = newValue;
                  });
                },
                value: _selected,
                isExpanded: false,
                hint: new Text(
                  "No.",
                  style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _tableContainer(String _label, Color _color) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(_label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _color,
            fontSize: 20.0,
          )),
    );
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
  List<String> getDates = List();

  evenFiller() async {
    // List<String> aa = widget.detailsData['dates'];
    // print(aa);
    await appointments
        .doc('upcomingApointments')
        .collection('data')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()['trainerEmail'] == widget.email) {
          // print(element.data()['dates']);
          for (int i = 0; i < element.data()['dates'].length; i++) {
            // print(element.data()['dates'][i]);
            getDates.add(element.data()['dates'][i]);
          }
        }
      });
    });
    // print(getDates);

    if (getDates.isNotEmpty) {
      for (int i = 0; i < getDates.length; i++) {
        var array = getDates[i].split('-');

        presentDates.add(new DateTime(
            int.parse(array[0]), int.parse(array[1]), int.parse(array[2])));
        //  a++;
      }

      for (int i = 0; i < getDates.length; i++) {
        _markedDateMap.add(
          DateTime.parse(getDates[i]),
          new Event(
            date: DateTime.parse(getDates[i]),
            title: 'Event 5',
            icon: _presentIcon(
              DateTime.parse(getDates[i]).day.toString(),
            ),
          ),
        );
      }
      setState(() {});
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      print(_time);
    });
  }

  cal2() {
    return CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);

        // selectTime(context);
        // print(_time);

        if (_selected != null) {
          if (_markedDateMap.events.length <= _selected) {
            if (_markedDateMap.events.isEmpty) {
              _selectedDates.add(Helper.getDate(date));
              _markedDateMap.add(
                date,
                new Event(
                  date: date,
                  title: 'Event 5',
                  icon: _presentIcon(
                    date.day.toString(),
                  ),
                ),
              );
            } else {
              for (int i = 0; i < _markedDateMap.events.keys.length; i++) {
                //  print(_markedDateMap.events.keys);
                if (!_markedDateMap.events.keys.contains(date)) {
                  _selectedDates.add(Helper.getDate(date));
                  _markedDateMap.add(
                    date,
                    new Event(
                      date: date,
                      title: 'Event 5',
                      icon: _presentIcon(
                        date.day.toString(),
                      ),
                    ),
                  );
                }
              }
            }
          } else
            customToast(text: 'Your sessions range is done');
        } else
          customToast(text: 'Pick No. of sessions first');

        //evnetsFiller();
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
      // markedDateIconMargin: 20.0,

      // markedDateShowIcon: true,
      markedDateIconMaxShown: 0,
      markedDateMoreShowTotal: null,

      markedDateCustomTextStyle: TextStyle(
        fontSize: 20,
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
