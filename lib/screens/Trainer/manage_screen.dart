import 'package:abora/global/colors.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  DateTime _dateTime;
  bool _switchValue = true;

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

  bool dayTileColorMon = true;
  bool dayTileColorTues = true;
  bool dayTileColorWed = true;
  bool dayTileColorThurs = true;
  bool dayTileColorFri = true;
  bool dayTileColorSat = true;
  bool dayTileColorSun = true;

  Color colorMon;

  Color colorTues;

  Color colorWed;

  Color colorThurs;
  Color colorFri;

  Color colorSat;

  Color colorSun;

  TimeOfDay pickedMonFrom;
  TimeOfDay pickedMonTo;
  TimeOfDay pickedTuesFrom;
  TimeOfDay pickedTuesTo;
  TimeOfDay pickedWedFrom;
  TimeOfDay pickedWedTo;
  TimeOfDay pickedThurTo;
  TimeOfDay pickedThuFrom;
  TimeOfDay pickedFriTo;
  TimeOfDay pickedFriFrom;
  TimeOfDay pickedSatTo;
  TimeOfDay pickedSatFrom;
  TimeOfDay pickedSunTo;
  TimeOfDay pickedSunFrom;

  dayTileMon(String day) {
    return GestureDetector(
      onTap: () async {
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
      onTap: () async {
        dayTileColorTues = !dayTileColorTues;

        if (!dayTileColorTues) {
          /*pickedTues = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },);*/

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
      onTap: () async {
        dayTileColorWed = !dayTileColorWed;

        if (!dayTileColorWed) {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

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
      onTap: () async {
        dayTileColorThurs = !dayTileColorThurs;

        if (!dayTileColorThurs) {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

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
      onTap: () async {
        dayTileColorFri = !dayTileColorFri;

        if (!dayTileColorFri) {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

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
      onTap: () async {
        dayTileColorSat = !dayTileColorSat;

        if (!dayTileColorSat) {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

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
      onTap: () async {
        dayTileColorSun = !dayTileColorSun;

        if (!dayTileColorSun) {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
          );

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

  updateBtn(DatabaseService database) {
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

                    if(dayTileColorMon) {
                      database.updateSignleField(key: 'MondayFrom',
                          value: pickedMonFrom.format(context));
                      database.updateSignleField(
                          key: 'MondayTo', value: pickedMonTo.format(context));
                    }
                    if(dayTileColorTues) {
                      database.updateSignleField(key: 'TuesdayFrom',
                          value: pickedTuesFrom.format(context));
                      database.updateSignleField(key: 'TuesdayTo',
                          value: pickedTuesTo.format(context));
                    }

                    if(dayTileColorWed) {
                    database.updateSignleField(key: 'WednesdayFrom', value: pickedWedFrom.format(context));
                    database.updateSignleField(key: 'WednesdayTo', value: pickedWedTo.format(context)); }


                    if(dayTileColorThurs) {
                    database.updateSignleField(key: 'ThursdayFrom', value: pickedThuFrom.format(context));
                    database.updateSignleField(key: 'ThursdayTo', value: pickedThurTo.format(context)); }

                    if(dayTileColorFri) {
                    database.updateSignleField(key: 'FridayFrom', value: pickedFriFrom.format(context));
                    database.updateSignleField(key: 'FridayTo', value: pickedFriTo.format(context)); }

                    if(dayTileColorSat) {
                    database.updateSignleField(key: 'SaturdayFrom', value: pickedSatFrom.format(context));
                    database.updateSignleField(key: 'SaturdayTo', value: pickedSatTo.format(context)); }

                    if(dayTileColorSun) {
                    database.updateSignleField(key: 'SundayFrom', value:  pickedSunFrom.format(context));
                    database.updateSignleField(key: 'SundayTo', value:  pickedSunTo.format(context)); }


                    /*_onAlertButtonsPressed(context);*/
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
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
          /*Padding(
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
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: [
                _showTimeWidget(
                  'Monday: ',
                  CupertinoSwitch(
                    value: dayTileColorMon,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorMon = value;
                      });
                    },
                  ),
                ),
                dayTileColorMon
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedMonTo != null
                                    ? pickedMonTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedMonTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Tuesday: ',
                  CupertinoSwitch(
                    value: dayTileColorTues,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorTues = value;
                      });
                    },
                  ),
                ),
                dayTileColorTues
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedTuesFrom != null
                                    ? pickedTuesFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedTuesFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedTuesTo != null
                                    ? pickedTuesTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedTuesTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Wednesday: ',
                  CupertinoSwitch(
                    value: dayTileColorWed,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorWed = value;
                      });
                    },
                  ),
                ),
                dayTileColorWed
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedWedFrom != null
                                    ? pickedWedFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedWedFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedWedTo != null
                                    ? pickedWedTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedWedTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Thursday: ',
                  CupertinoSwitch(
                    value: dayTileColorThurs,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorThurs = value;
                      });
                    },
                  ),
                ),
                dayTileColorThurs
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedThuFrom != null
                                    ? pickedThuFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedThuFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedThurTo != null
                                    ? pickedThurTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedThurTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Friday: ',
                  CupertinoSwitch(
                    value: dayTileColorFri,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorFri = value;
                      });
                    },
                  ),
                ),
                dayTileColorFri
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedFriFrom != null
                                    ? pickedFriFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedFriFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedFriTo != null
                                    ? pickedFriTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedFriTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Saturday: ',
                  CupertinoSwitch(
                    value: dayTileColorSat,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorSat = value;
                      });
                    },
                  ),
                ),
                dayTileColorSat
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedSatFrom != null
                                    ? pickedSatFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedSatFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedSatTo != null
                                    ? pickedSatTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedSatTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),
                _showTimeWidget(
                  'Sunday: ',
                  CupertinoSwitch(
                    value: dayTileColorSun,
                    onChanged: (value) {
                      setState(() {
                        dayTileColorSun = value;
                      });
                    },
                  ),
                ),
                dayTileColorSun
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedSunFrom != null
                                    ? pickedSunFrom.format(context)
                                    : '-- : -- ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedSunFrom = await showTimePicker(
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
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                pickedSunTo != null
                                    ? pickedSunTo.format(context)
                                    : '-- : --',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    pickedSunTo = await showTimePicker(
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
                        ],
                      )
                    : Container(),

                /* _showTimeWidget('Tuesday: ', dayTileColorTues  ),
    _showTimeWidget('Wednesday: ', dayTileColorWed ),
    _showTimeWidget('Thursday: ', dayTileColorThurs ),
    _showTimeWidget('Friday: ', dayTileColorFri  ),
    _showTimeWidget('Saturday: ', dayTileColorSat),
    _showTimeWidget('Sunday: ', dayTileColorSun  ),*/
              ],
            ),
          ),
          Spacer(),
          updateBtn(database),
        ],
      ),
    );
  }

  _showTimeWidget(String day, CupertinoSwitch cupertinoSwitch) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
              color: CustomColor.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [cupertinoSwitch],
        )
      ],
    );
  }
}
