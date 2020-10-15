import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/details_page.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box.dart/alert.dart';
import 'package:abora/widgets/dialog_box.dart/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
      home: AppointmentPage(),
    );
  }
}

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  double height;

  double width;

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
      body: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Theme.of(context).primaryColor,
          child: Column(

            children: [
              SizedBox(height: 20,),

              Row(children: [
                SizedBox(width: 25.w,),
                Container(
                    width: 180.w,
                    decoration: BoxDecoration(
                        color: CustomColor.backgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Weekly',
                            style:
                            TextStyle(color: CustomColor.red),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: CustomColor.red,
                          )
                        ],
                      ),
                    )),
                SizedBox(width: 25.w,),
                Container(
                    width: 180.w,
                    decoration: BoxDecoration(
                        color: CustomColor.backgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            '2020',
                            style:
                            TextStyle(color: CustomColor.red),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: CustomColor.red,
                          )
                        ],
                      ),
                    )),
              ],),
              SizedBox(height: 20,),
              TableCalendar(
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  weekdayStyle: dayStyle(FontWeight.normal),
                  weekendStyle: dayStyle(FontWeight.normal),
                  selectedColor: Color(0xff30374b),
                  todayColor: Color(0xff30374b),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  weekendStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Color(0xff30384c),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarController: _controller,
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
                    SizedBox(width: 10,),
                    Text('Session Booked', style: TextStyle(color: CustomColor.white,),)
                  ],
                ),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Theme.of(context).primaryColor,
          child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upcoming Appointments', style: TextStyle(color: CustomColor.red, fontSize: 18),),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: CustomColor.red
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage()),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                    Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                  ],
                                ),
                              ),
                            ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                              Text('3', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                              Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                              Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                            ],),

                        ],),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: CustomColor.red
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                              Row(
                                children: [
                                  Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                  Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                ],
                              ),
                            ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                              Text('3', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                              Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                              Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                            ],),

                        ],),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: CustomColor.red
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                              Row(
                                children: [
                                  Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                  Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                ],
                              ),
                            ],),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                              Text('3', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                              Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                            ],),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                              Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                            ],),

                        ],),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
              ],
            ),
          ),
            SizedBox(height: 20,),
        ],),),
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Theme.of(context).primaryColor,
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Previous Appointments', style: TextStyle(color: CustomColor.red, fontSize: 18),),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(

                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: CustomColor.red
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                                Row(
                                  children: [
                                    Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                    Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                  ],
                                ),
                              ],),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                                Text('3', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                                Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                                Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                              ],),

                          ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: CustomColor.red
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                                Row(
                                  children: [
                                    Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                    Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                  ],
                                ),
                              ],),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                                Text('3', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                                Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                                Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                              ],),

                          ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20, ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: CustomColor.red
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trainer Name', style: TextStyle(color: CustomColor.white),),
                                Row(
                                  children: [
                                    Text('View Details', style: TextStyle(color: CustomColor.blue),),
                                    Icon(Icons.arrow_forward_ios, size: 12, color: CustomColor.blue,)
                                  ],
                                ),
                              ],),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No of Bookings:', style: TextStyle(color: CustomColor.grey),),
                                Text('3', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session Type:', style: TextStyle(color: CustomColor.grey),),
                                Text('One-one-One', style: TextStyle(color: CustomColor.grey),)
                              ],),
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Goal:', style: TextStyle(color: CustomColor.grey),),
                                Text('Lose 4Kgs in 3 sessions', style: TextStyle(color: CustomColor.grey),)
                              ],),

                          ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  SizedBox(child: Container(height: 0.5, width: double.infinity, color: CustomColor.grey,),)
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],),),
        SizedBox(height: 20,),


      ],)
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
