import 'dart:async';

import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/payment_page.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      home: PostAdPage(),
    );
  }
}

class PostAdPage extends StatefulWidget {
  @override
  _PostAdPageState createState() => _PostAdPageState();
}

class _PostAdPageState extends State<PostAdPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  double height;

  double width;
  List<String> years = <String>[
    "40 years",
    "50 years",
    "60 years",
    "70 years",
    "80 years"
  ];
  var _selectedyear;
  List<String> ex1 = <String>["Cardio", 'Lever', 'Thighs', 'Chest', 'Biceps'];
  List<int> _values = <int>[20, 30, 40, 50, 60];
  var _selected;

  var _selectedEx1;
  var _selectedEx2;
  int totalprice = 20;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POST AD',
          style: TextStyle(
              fontSize: FontSize.h3FontSize, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: CustomColor.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 130,
            height: 130,
          ),
        ],
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(20.0),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Target Audiance',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              width: 160.0,
                              height: 40.0,
                              // alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: CustomColor.orangeColor,
                                  ),
                                  iconSize: 20,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: CustomColor.red,
                                    letterSpacing: 1.2,
                                  ),
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.red,
                                  isDense: true,
                                  items: years.map((years) {
                                    return DropdownMenuItem(
                                      child: Text(years),
                                      value: years,
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedyear = newValue;
                                    });
                                  },
                                  value: _selectedyear,
                                  isExpanded: false,
                                  hint: new Text(
                                    "40 Years",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              width: 160.0,
                              height: 40.0,
                              // alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: CustomColor.orangeColor,
                                  ),
                                  iconSize: 20,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: CustomColor.red,
                                    letterSpacing: 1.2,
                                  ),
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.red,
                                  isDense: true,
                                  items: ex1.map((ex1) {
                                    return DropdownMenuItem(
                                      child: Text(ex1),
                                      value: ex1,
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedEx1 = newValue;
                                    });
                                  },
                                  value: _selectedEx1,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Cardio",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              width: 160.0,
                              height: 40.0,
                              // alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: CustomColor.orangeColor,
                                  ),
                                  iconSize: 20,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: CustomColor.red,
                                    letterSpacing: 1.2,
                                  ),
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.red,
                                  isDense: true,
                                  items: ex1.map((ex1) {
                                    return DropdownMenuItem(
                                      child: Text(ex1),
                                      value: ex1,
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedEx2 = newValue;
                                    });
                                  },
                                  value: _selectedEx2,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Lever",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Number of days',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50.0, right: 15.0),
                          width: 120.0,
                          height: 40.0,
                          // alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: CustomColor.orangeColor,
                              ),
                              iconSize: 20,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.red,
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
                                "60",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 5, bottom: 20),
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Area',
                  style: TextStyle(color: CustomColor.red),
                ),
                Text('Number of miles : 3',
                    style: TextStyle(color: CustomColor.white)),
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(300)),
                    height: 200,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    Text(
                      'Euro $totalprice',
                      style: TextStyle(color: CustomColor.green, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 30.0.h, right: 30.h),
            child: blueButton(
              child: Text(
                'POST ADD',
                style: TextStyle(color: Colors.white),
              ),
              func: _ontap,
            ),
          ),
        ],
      ),
    );
  }

  _ontap() {
    if (_selectedyear.toString().isNotEmpty &&
        _selectedEx1.toString().isNotEmpty &&
        _selectedEx2.toString().isNotEmpty &&
        _selected.toString().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentPage(
                  postAdData: {
                    'years': _selectedyear.toString(),
                    'ex': _selectedEx1.toString(),
                    'ex1': _selectedEx2.toString(),
                    'days': _selected.toString(),
                    'totalPrice': totalprice.toString()
                  },
                )),
      );
    }
  }
}
