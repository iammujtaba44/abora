import 'package:abora/global/colors.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
      context: context,
      buttons: [],
      title: '',
      content: Column(
        children: [
          Text(
            'Select time Range you will available on Mondays',
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          Row(
            children: [
              Expanded(
                child: customTextField(
                  validator: '10:00 AM',
                  suffixIcon: Icons.timer,
                  text: '10:00 AM',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'To',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: customTextField(
                  validator: '06:00 PM',
                  suffixIcon: Icons.timer,
                  text: '06:00 PM',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: FlatButton(
                onPressed: () {},
                child: Text('Cancel'),
                color: Colors.grey,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: RaisedButton(
                onPressed: () {},
                child: Text('Done'),
                color: Colors.blue,
              ))
            ],
          )
        ],
      ),
      desc: "Payment Successful !",
    ).show();
  }

  var titleStyle = TextStyle(color: Colors.red, fontSize: 18);

  var dayTileStyleMon = TextStyle(color: Colors.white);
  var dayTileStyleTues = TextStyle(color: Colors.white);
  var dayTileStyleWed = TextStyle(color: Colors.white);
  var dayTileStyleThurs = TextStyle(color: Colors.white);
  var dayTileStyleFri = TextStyle(color: Colors.white);
  var dayTileStyleSat = TextStyle(color: Colors.white);
  var dayTileStyleSun = TextStyle(color: Colors.white);

  bool dayTileColorMon = false;
  bool dayTileColorTues = false;
  bool dayTileColorWed = false;
  bool dayTileColorThurs = false;
  bool dayTileColorFri = false;
  bool dayTileColorSat = false;
  bool dayTileColorSun = false;

  Color colorMon = Colors.blue;
  Color colorTues = Colors.blue;
  Color colorWed = Colors.blue;
  Color colorThurs = Colors.blue;
  Color colorFri = Colors.blue;
  Color colorSat = Colors.blue;
  Color colorSun = Colors.blue;

  dayTileMon(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorMon = !dayTileColorMon;

        if (!dayTileColorMon) {
          colorMon = Colors.blue;
          dayTileStyleMon = TextStyle(color: Colors.white);
        } else {
          colorMon = null;
          dayTileStyleMon = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorMon,
          border: colorMon == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleMon,
        ),
      ),
    );
  }

  dayTileTues(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorTues = !dayTileColorTues;

        if (!dayTileColorTues) {
          colorTues = Colors.blue;
          dayTileStyleTues = TextStyle(color: Colors.white);
        } else {
          colorTues = null;
          dayTileStyleTues = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorTues,
          border: colorTues == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleTues,
        ),
      ),
    );
  }

  dayTileWed(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorWed = !dayTileColorWed;

        if (!dayTileColorWed) {
          colorWed = Colors.blue;
          dayTileStyleWed = TextStyle(color: Colors.white);
        } else {
          colorWed = null;
          dayTileStyleWed = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorWed,
          border: colorWed == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleWed,
        ),
      ),
    );
  }

  dayTileThurs(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorThurs = !dayTileColorThurs;

        if (!dayTileColorThurs) {
          colorThurs = Colors.blue;
          dayTileStyleThurs = TextStyle(color: Colors.white);
        } else {
          colorThurs = null;
          dayTileStyleThurs = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorThurs,
          border: colorThurs == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleThurs,
        ),
      ),
    );
  }

  dayTileFri(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorFri = !dayTileColorFri;

        if (!dayTileColorFri) {
          colorFri = Colors.blue;
          dayTileStyleFri = TextStyle(color: Colors.white);
        } else {
          colorFri = null;
          dayTileStyleFri = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorFri,
          border: colorFri == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleFri,
        ),
      ),
    );
  }

  dayTileSat(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorSat = !dayTileColorSat;

        if (!dayTileColorSat) {
          colorSat = Colors.blue;
          dayTileStyleSat = TextStyle(color: Colors.white);
        } else {
          colorSat = null;
          dayTileStyleSat = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorSat,
          border: colorSat == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleSat,
        ),
      ),
    );
  }

  dayTileSun(String day) {
    return GestureDetector(
      onTap: () {
        dayTileColorSun = !dayTileColorSun;

        if (!dayTileColorSun) {
          colorSun = Colors.blue;
          dayTileStyleSun = TextStyle(color: Colors.white);
        } else {
          colorSun = null;
          dayTileStyleSun = TextStyle(color: Colors.grey);
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorSun,
          border: colorSun == null ? Border.all(color: Colors.grey) : null,
        ),
        alignment: Alignment.center,
        height: 25,
        width: 100,
        child: Text(
          day,
          style: dayTileStyleSun,
        ),
      ),
    );
  }

  firstColumn() {
    return Expanded(
      child: Column(
        children: [
          dayTileMon('Monday'),
          SizedBox(
            height: 10,
          ),
          dayTileThurs('Thursday'),
          SizedBox(
            height: 10,
          ),
          dayTileSun('Sunday')
          /*dayTile('Thursday'),
          SizedBox(
            height: 10,
          ),
          dayTile('Sunday')*/
        ],
      ),
    );
  }

  secondColumn() {
    return Expanded(
      child: Column(
        children: [
          dayTileTues('Tuesday'),
          SizedBox(
            height: 10,
          ),
          dayTileFri('Friday'),
        ],
      ),
    );
  }

  thirdColumn() {
    return Expanded(
      child: Column(
        children: [
          dayTileWed('Wednesday'),
          SizedBox(
            height: 10,
          ),
          dayTileSat('Saturday'),
        ],
      ),
    );
  }

  updateBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'UPDATE',
                    style: dayTileStyleMon,
                  ),
                  onPressed: () {
                    _onAlertButtonsPressed(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text('Manage Availability'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.red,
              ),
              onPressed: null),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                height: 150,
                width: double.infinity,
                child: Column(children: [
                  Row(
                    children: [
                      Text('  Select days you will be available on',
                          style: titleStyle),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [firstColumn(), secondColumn(), thirdColumn()],
                  ),
                ])),
          ),
          Spacer(),
          updateBtn(),
        ],
      ),
    );
  }
}
