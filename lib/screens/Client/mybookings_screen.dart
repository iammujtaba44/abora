import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/models/trainer_models/apointmentModel.dart';
import 'package:abora/screens/Client/clientDetailPage.dart';
import 'package:abora/screens/Trainer/details_page.dart';
import 'package:abora/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Mybookings extends StatefulWidget {
  @override
  _MybookingsState createState() => _MybookingsState();
}

class _MybookingsState extends State<Mybookings> {
  double height;

  double width;

  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xFF30384c), fontWeight: fontWeight);
  }

  @override
  void initState() {
    super.initState();
  }

  DatabaseService database;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);
    database = Provider.of<DatabaseService>(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('MY BOOKINGS'),
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
          body: Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 16.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upcoming Appointments',
                                style: TextStyle(
                                    color: CustomColor.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //  _mainContainer(),
                              UpcomingSession()
                            ]),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 16.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Previous Appointments',
                                style: TextStyle(
                                    color: CustomColor.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              PreviousSession()
                            ]),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}

class UpcomingSession extends StatefulWidget {
  _UpcomingSessionState createState() => _UpcomingSessionState();
}

class _UpcomingSessionState extends State<UpcomingSession> {
  DatabaseService database;
  @override
  Widget build(BuildContext context) {
    database = Provider.of<DatabaseService>(context);
    //  List<AppointmentModel> apoint =
    //  List<AppointmentModel> apoint =
    //  Provider.of<List<AppointmentModel>>(context);
    // print(apoint[0].clientEmail);

    return StreamBuilder(
      stream: database.apintmentStream,
      builder: (context, snapshot) {
        //  print('--------- ${snapshot.data[0].trainerName}');

        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return Column(
            children: List.generate(snapshot.data.length, (index) {
              if (snapshot.data[index].clientEmail ==
                  Constants.clientUserData.email) {
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
                              color: CustomColor.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data[index].trainerName,
                                    style: TextStyle(color: CustomColor.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ClientDetailPage(
                                                  detailsData: {
                                                    'clientName': snapshot
                                                        .data[index]
                                                        .trainerName,
                                                    'noOfBookings': snapshot
                                                        .data[index]
                                                        .noOfBookings,
                                                    'sessionType': snapshot
                                                        .data[index]
                                                        .sessionType,
                                                    'goal': snapshot
                                                        .data[index].goal,
                                                    'dates': snapshot
                                                        .data[index].dates,
                                                    'trainerEmail': snapshot
                                                        .data[index]
                                                        .trainerEmail,
                                                    'trainerUrl': snapshot
                                                        .data[index]
                                                        .trainerImageUrl,
                                                    'docId': snapshot
                                                        .data[index].docId,
                                                    'get': '0'
                                                  },
                                                )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'View Details',
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
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'No of Bookings:',
                                    style: TextStyle(color: CustomColor.grey),
                                  ),
                                  Text(
                                    snapshot.data[index].noOfBookings,
                                    style: TextStyle(color: CustomColor.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Session Type:',
                                    style: TextStyle(color: CustomColor.grey),
                                  ),
                                  Text(
                                    snapshot.data[index].sessionType,
                                    style: TextStyle(color: CustomColor.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Goal:',
                                    style: TextStyle(color: CustomColor.grey),
                                  ),
                                  Text(
                                    snapshot.data[index].goal,
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
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class PreviousSession extends StatefulWidget {
  _PreviousSessionState createState() => _PreviousSessionState();
}

class _PreviousSessionState extends State<PreviousSession> {
  DatabaseService database;
  @override
  Widget build(BuildContext context) {
    // List<AppointmentModel> apoint =
    //     Provider.of<List<AppointmentModel>>(context);
    database = Provider.of<DatabaseService>(context);

    return StreamBuilder(
        stream: database.apintmentPreviousStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: List.generate(snapshot.data.length, (index) {
                if (snapshot.data[index].clientEmail ==
                    Constants.clientUserData.email) {
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
                                color: CustomColor.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data[index].trainerName,
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClientDetailPage(
                                                    detailsData: {
                                                      'clientName': snapshot
                                                          .data[index]
                                                          .trainerName,
                                                      'noOfBookings': snapshot
                                                          .data[index]
                                                          .noOfBookings,
                                                      'sessionType': snapshot
                                                          .data[index]
                                                          .sessionType,
                                                      'goal': snapshot
                                                          .data[index].goal,
                                                      'dates': snapshot
                                                          .data[index].dates,
                                                      'trainerEmail': snapshot
                                                          .data[index]
                                                          .trainerEmail,
                                                      'trainerUrl': snapshot
                                                          .data[index]
                                                          .trainerImageUrl,
                                                      'docId': snapshot
                                                          .data[index].docId,
                                                      'get': '1'
                                                    },
                                                  )),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'View Details',
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'No of Bookings:',
                                      style: TextStyle(color: CustomColor.grey),
                                    ),
                                    Text(
                                      snapshot.data[index].noOfBookings,
                                      style: TextStyle(color: CustomColor.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Session Type:',
                                      style: TextStyle(color: CustomColor.grey),
                                    ),
                                    Text(
                                      snapshot.data[index].sessionType,
                                      style: TextStyle(color: CustomColor.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Goal:',
                                      style: TextStyle(color: CustomColor.grey),
                                    ),
                                    Text(
                                      snapshot.data[index].goal,
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
          } else {
            return SizedBox();
          }
        });
  }
}
