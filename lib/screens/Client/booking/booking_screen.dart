import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/height.dart';
import 'package:abora/screens/Client/ClientPayment_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/utils/Helper.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final String name;
  final String bio;
  final String email;

  BookingScreen({this.name, this.bio, this.email});
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController goalTextFieldController = TextEditingController();
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a = 0;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<String> _selectedDates = [];
  List<int> _values = <int>[01, 02, 03, 04, 05];
  List<String> _goalString = <String>[
    'One-on-One',
    'FaceTime',
  ];

  var _selected;
  var _selectedSession;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    // evnetsFiller();
    _calendarCarouselNoHeader = cal2();
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
                      if (_selected != null &&
                          _selectedSession != null &&
                          goalTextFieldController.text.isNotEmpty &&
                          _selectedDates.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientPaymentPage(
                                      addAp: {
                                        'clientEmail':
                                            Constants.currentClientEmail,
                                        'clientImageUrl': 'abc',
                                        'clientName':
                                            Constants.currentClientName,
                                        'dates': _selectedDates,
                                        'goal': goalTextFieldController.text,
                                        'noOfBookings': _selected,
                                        'sessionType': _selectedSession,
                                        'trainerEmail': widget.email,
                                        'trainerImageUrl': 'abc',
                                        'trainerName': widget.name
                                      },
                                    )));
                      } else {
                        //  print(Helper.getDate(DateTime.now()));
                        // print(_selectedDates);
                        customToast(text: 'Please fill all fields');
                        customToast(
                            text:
                                'Select Dates from Calender by clicking dates');
                      }

                      // database.uploadApointmentAsync(
                      //     clientEmail: 'ak11@gmail.com',
                      //     clientImageUrl: 'abc',
                      //     clientName: 'ak',
                      //     dates: ["2", "3"],
                      //     goal: 'abc',
                      //     noOfBookings: '2',
                      //     sessionType: 'abc',
                      //     trainerEmail: widget.email,
                      //     trainerImageUrl: 'abc',
                      //     trainerName: 'abc');
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
          Container(
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
                      children: List.generate(4, (index) {
                    return _tableContainer('X', Color(0xFF43810C));
                  })),
                  TableRow(
                      children: List.generate(4, (index) {
                    return _tableContainer('Y', Colors.grey.withOpacity(0.5));
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
                style: TextStyle(
                  fontSize: 15.0,
                  color: CustomColor.textFieldLabelColor,
                  letterSpacing: 1.2,
                ),
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.red,
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
        ],
      ),
    );
  }

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
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey.withOpacity(0.5),
                  letterSpacing: 1.2,
                ),
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.red,
                isDense: true,
                items: _values.map((city) {
                  return DropdownMenuItem(
                    child: Text(city.toString()),
                    value: city,
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
                  "01",
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

  evnetsFiller() {
    // List<String> aa = widget.detailsData['dates'];
    // print(aa);

    if (_selectedDates.isNotEmpty) {
      print(_selectedDates);
      for (int i = 0; i < _selectedDates.length; i++) {
        var array = _selectedDates[i].split('-');

        presentDates.add(new DateTime(
            int.parse(array[0]), int.parse(array[1]), int.parse(array[2])));
        a++;
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
  }

  cal2() {
    return CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
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

        //evnetsFiller();
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
      //  markedDateShowIcon: true,
      markedDateIconMaxShown: 0,
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
