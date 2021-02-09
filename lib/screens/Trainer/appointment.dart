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
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 25.w,
                    //     ),
                    //     Container(
                    //         width: 180.w,
                    //         decoration: BoxDecoration(
                    //             color: CustomColor.backgroundColor,
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 15.0,
                    //               right: 15.0,
                    //               top: 8.0,
                    //               bottom: 8.0),
                    //           child: Row(
                    //             children: [
                    //               Text(
                    //                 'Weekly',
                    //                 style: TextStyle(color: CustomColor.white),
                    //               ),
                    //               Spacer(),
                    //               Icon(
                    //                 Icons.keyboard_arrow_down,
                    //                 size: 20,
                    //                 color: CustomColor.white,
                    //               )
                    //             ],
                    //           ),
                    //         )),
                    //     SizedBox(
                    //       width: 25.w,
                    //     ),
                    //     Container(
                    //         width: 180.w,
                    //         decoration: BoxDecoration(
                    //             color: CustomColor.backgroundColor,
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 15.0,
                    //               right: 15.0,
                    //               top: 8.0,
                    //               bottom: 8.0),
                    //           child: Row(
                    //             children: [
                    //               Text(
                    //                 '2020',
                    //                 style: TextStyle(color: CustomColor.white),
                    //               ),
                    //               Spacer(),
                    //               Icon(
                    //                 Icons.keyboard_arrow_down,
                    //                 size: 20,
                    //                 color: CustomColor.white,
                    //               )
                    //             ],
                    //           ),
                    //         )),
                    //   ],
                    // ),
                    SizedBox(
                      height: 22,
                    ),
                    /*Calender(
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
                    ),*/
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
                            style: TextStyle(
                                color: CustomColor.white, fontSize: 18),
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
                            style: TextStyle(
                                color: CustomColor.white, fontSize: 18),
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
              if (snapshot.data[index].trainerEmail ==
                  Constants.trainerUserData.email) {
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
                                    snapshot.data[index].clientName,
                                    style: TextStyle(color: CustomColor.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                  detailsData: {
                                                    'clientName': snapshot
                                                        .data[index].clientName,
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
                                                    'get': '0',
                                                    'noOfCompleteSession': snapshot.data[index].noOfCompletedSessions

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
                if (snapshot.data[index].trainerEmail ==
                    Constants.trainerUserData.email) {
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
                                      snapshot.data[index].clientName,
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    detailsData: {
                                                      'clientName': snapshot
                                                          .data[index]
                                                          .clientName,
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
                                                      'get': '1',

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

// class UpcomingSession extends StatefulWidget {
//   _UpcomingSessionState createState() => _UpcomingSessionState();
// }
//
// class _UpcomingSessionState extends State<UpcomingSession> {
//   @override
//   Widget build(BuildContext context) {
//     List<AppointmentModel> apoint =
//         Provider.of<List<AppointmentModel>>(context);
//     return Column(
//       children: List.generate(apoint.length, (index) {
//         if (apoint[index].trainerEmail == Constants.trainerUserData.email) {
//           return Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(360),
//                         color: CustomColor.white),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               apoint[index].clientName,
//                               style: TextStyle(color: CustomColor.white),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailPage(
//                                             detailsData: {
//                                               'clientName':
//                                                   apoint[index].clientName,
//                                               'noOfBookings':
//                                                   apoint[index].noOfBookings,
//                                               'sessionType':
//                                                   apoint[index].sessionType,
//                                               'goal': apoint[index].goal,
//                                               'dates': apoint[index].dates
//                                             },
//                                           )),
//                                 );
//                               },
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'View Details',
//                                     style: TextStyle(color: CustomColor.blue),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_ios,
//                                     size: 12,
//                                     color: CustomColor.blue,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'No of Bookings:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].noOfBookings,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Session Type:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].sessionType,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Goal:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].goal,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               SizedBox(
//                 child: Container(
//                   height: 0.5,
//                   width: double.infinity,
//                   color: CustomColor.grey,
//                 ),
//               )
//             ],
//           );
//         } else {
//           return SizedBox();
//         }
//       }),
//     );
//   }
// }
//
// class PreviousSession extends StatefulWidget {
//   _PreviousSessionState createState() => _PreviousSessionState();
// }
//
// class _PreviousSessionState extends State<PreviousSession> {
//   @override
//   Widget build(BuildContext context) {
//     List<AppointmentModel> apoint =
//         Provider.of<List<AppointmentModel>>(context);
//     return Column(
//       children: List.generate(apoint.length, (index) {
//         if (apoint[index].trainerEmail == Constants.trainerUserData.email) {
//           return Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(360),
//                         color: CustomColor.white),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               apoint[index].clientName,
//                               style: TextStyle(color: CustomColor.white),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailPage(
//                                             detailsData: {
//                                               'clientName':
//                                                   apoint[index].clientName,
//                                               'noOfBookings':
//                                                   apoint[index].noOfBookings,
//                                               'sessionType':
//                                                   apoint[index].sessionType,
//                                               'goal': apoint[index].goal,
//                                               'dates': apoint[index].dates
//                                             },
//                                           )),
//                                 );
//                               },
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'View Details',
//                                     style: TextStyle(color: CustomColor.blue),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_forward_ios,
//                                     size: 12,
//                                     color: CustomColor.blue,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'No of Bookings:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].noOfBookings,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Session Type:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].sessionType,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Goal:',
//                               style: TextStyle(color: CustomColor.grey),
//                             ),
//                             Text(
//                               apoint[index].goal,
//                               style: TextStyle(color: CustomColor.grey),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               SizedBox(
//                 child: Container(
//                   height: 0.5,
//                   width: double.infinity,
//                   color: CustomColor.grey,
//                 ),
//               )
//             ],
//           );
//         } else {
//           return SizedBox();
//         }
//       }),
//     );
//   }
// }

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
  bool caller = false;
  List<String> years = <String>[
    "Weekly",
    "Monthly",
  ];
  var _selectedyear;
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
        // onDayPressed: (DateTime date, List<Event> events) {
        //   this.setState(() => _currentDate2 = date);
        //   events.forEach((event) => print(event.title));
        // },
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

    if (apoint != null) {
      evnetsFiller();
    }
    _calendarCarouselNoHeader = cal2();

    return Column(
      children: [
        // Row(
        //   children: [
        //     SizedBox(
        //       width: 25.w,
        //     ),
        //     Container(
        //       padding: EdgeInsets.only(left: 10.0),
        //       width: 160.0,
        //       height: 40.0,
        //       // alignment: Alignment.bottomRight,
        //       decoration: BoxDecoration(
        //           color: CustomColor.backgroundColor,
        //           borderRadius: BorderRadius.all(Radius.circular(6.0))),
        //       child: DropdownButtonHideUnderline(
        //         child: DropdownButton(
        //           icon: Icon(
        //             Icons.keyboard_arrow_down,
        //             color: CustomColor.orangeColor,
        //           ),
        //           iconSize: 20,
        //           style: TextStyle(
        //             fontSize: 13.0,
        //             color: CustomColor.white,
        //             letterSpacing: 1.2,
        //           ),
        //           iconEnabledColor: CustomColor.white,
        //           iconDisabledColor: CustomColor.white,
        //           isDense: true,
        //           items: years.map((years) {
        //             return DropdownMenuItem(
        //               child: Text(years),
        //               value: years,
        //             );
        //           }).toList(),
        //           onChanged: (newValue) {
        //             setState(() {
        //               _selectedyear = newValue;
        //               _currentDate2 = DateTime(2021, 2, 1);
        //               // print(_currentDate2);
        //               // _calendarCarouselNoHeader = cal2();
        //               // if (_selectedyear == 'Weekly') {
        //               //   caller = true;
        //               // } else
        //               //   caller = false;
        //             });
        //           },
        //           value: _selectedyear,
        //           isExpanded: false,
        //           hint: new Text(
        //             "Weekly",
        //             style: TextStyle(color: CustomColor.white),
        //           ),
        //         ),
        //       ),
        //     ),
        //     // Container(
        //     //     width: 180.w,
        //     //     decoration: BoxDecoration(
        //     //         color: CustomColor.backgroundColor,
        //     //         borderRadius: BorderRadius.circular(5)),
        //     //     child: Padding(
        //     //       padding: const EdgeInsets.only(
        //     //           left: 15.0,
        //     //           right: 15.0,
        //     //           top: 8.0,
        //     //           bottom: 8.0),
        //     //       child: Row(
        //     //         children: [
        //     //           Text(
        //     //             'Weekly',
        //     //             style: TextStyle(color: CustomColor.white),
        //     //           ),
        //     //           Spacer(),
        //     //           Icon(
        //     //             Icons.keyboard_arrow_down,
        //     //             size: 20,
        //     //             color: CustomColor.white,
        //     //           )
        //     //         ],
        //     //       ),
        //     //     )),
        //     SizedBox(
        //       width: 25.w,
        //     ),
        //     Container(
        //         width: 180.w,
        //         decoration: BoxDecoration(
        //             color: CustomColor.backgroundColor,
        //             borderRadius: BorderRadius.circular(5)),
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //               left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
        //           child: Row(
        //             children: [
        //               Text(
        //                 '2020',
        //                 style: TextStyle(color: CustomColor.white),
        //               ),
        //               Spacer(),
        //               Icon(
        //                 Icons.keyboard_arrow_down,
        //                 size: 20,
        //                 color: CustomColor.white,
        //               )
        //             ],
        //           ),
        //         )),
        //   ],
        // ),
        SizedBox(
          height: 22,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            //    borderRadius: BorderRadius.all(Radius.circular(20.0))
          ), //width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.7,
          child: _calendarCarouselNoHeader,
        )
      ],
    );
  }
}
