import 'package:abora/global/colors.dart';
import 'package:abora/global/height.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];

class _BookingScreenState extends State<BookingScreen> {
  DateTime _currentDate2 = DateTime.now();
  CalendarCarousel _calendarCarouselNoHeader;
  var len = 9;
  int a;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<int> _values = <int>[01, 02, 03, 04, 05];
  var _selected;
  @override
  Widget build(BuildContext context) {
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
                    func: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }

  _mainContainer() {
    evnetsFiller();
    _calendarCarouselNoHeader = cal();
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
                    "Mario Speedwagon",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et",
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
