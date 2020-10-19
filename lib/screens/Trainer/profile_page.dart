import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/screens/Trainer/edit_video_page.dart';
import 'package:abora/services/constants.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box.dart/alert.dart';
import 'package:abora/widgets/dialog_box.dart/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';
import 'package:provider/provider.dart';

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
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double height;

  double width;

  List<String> upperList = <String>['1', 'X', 'X'];
  List<String> lowerList = <String>['30', '65', '110'];

  @override
  void initState() {
    print(UserCredentionl.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return StreamProvider<List<UploadVideo>>.value(
      value: DatabaseSerivce(uId: UserCredentionl.userId).uploadVideoStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PROFILE',
            style: TextStyle(fontSize: 17),
          ),
          leading: Container(),
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/logo.png',
              width: 40,
              height: 130,
            ),
          ],
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: height / 2.5,
              leading: Container(),
              flexibleSpace: FlexibleSpaceBar(
                background: _buildContent(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      margin:
                          const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                      padding: const EdgeInsets.all(20),
                      height: 230.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bio',
                            style: TextStyle(color: CustomColor.red),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et',
                            style: TextStyle(color: CustomColor.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      margin:
                          const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                      padding: const EdgeInsets.all(20),
                      height: 420,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(color: CustomColor.red),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('Area'),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('Speciality'),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('Home Training'),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('GYM Training'),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('Price Per Session (P/S)'),
                          SizedBox(
                            height: 10,
                          ),
                          descriptionContainer('Payment Method'),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      margin:
                          const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                      padding: const EdgeInsets.all(20),
                      height: 240.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bulk Sessions',
                            style: TextStyle(
                              color: CustomColor.red,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            // margin: EdgeInsets.all(10),
                            child: Table(
                              border: TableBorder.symmetric(
                                  inside: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1)),
                              children: [
                                TableRow(
                                    children:
                                        List.generate(upperList.length, (i) {
                                  return _tableContainer(
                                      upperList[i], Colors.white, 1);
                                })),
                                TableRow(
                                    children:
                                        List.generate(lowerList.length, (i) {
                                  return _tableContainer(lowerList[i],
                                      Colors.grey.withOpacity(0.5), 2);
                                })),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(
                            top: 20, left: 20.0, right: 20),
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(color: CustomColor.red),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: CustomColor.grey,
                                backgroundImage:
                                    AssetImage('assets/trainer.jpg'),
                                radius: 30,
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                'Patricia Lucas',
                                style: TextStyle(
                                    color: CustomColor.white,
                                    fontSize: FontSize.h3FontSize - 3),
                              ),
                              subtitle: Text(
                                'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
                                style: TextStyle(
                                    color: CustomColor.grey, fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: CustomColor.grey,
                                backgroundImage:
                                    AssetImage('assets/trainer.jpg'),
                                radius: 30,
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                'Patricia Lucas',
                                style: TextStyle(
                                    color: CustomColor.white,
                                    fontSize: FontSize.h3FontSize - 3),
                              ),
                              subtitle: Text(
                                'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
                                style: TextStyle(
                                    color: CustomColor.grey, fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: CustomColor.grey,
                                backgroundImage:
                                    AssetImage('assets/trainer.jpg'),
                                radius: 30,
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                'Patricia Lucas',
                                style: TextStyle(
                                    color: CustomColor.white,
                                    fontSize: FontSize.h3FontSize - 3),
                              ),
                              subtitle: Text(
                                'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
                                style: TextStyle(
                                    color: CustomColor.grey, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  _tableContainer(String _label, Color _color, int type) {
    return Container(
      padding: EdgeInsets.all(20.0.h),
      child: type == 1
          ? Text(_label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _color,
                fontSize: 20.0.h,
              ))
          : Text(_label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _color,
                fontSize: 20.0.h,
              )),
    );
  }

  Widget descriptionContainer(String text) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: CustomColor.backgroundColor,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(text, style: TextStyle(color: CustomColor.white)),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: height / 2.5,
              width: double.infinity,
              color: Colors.grey,
            ),
            Container(
              height: height / 2.5,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Davei Samah',
                          style: TextStyle(
                              fontSize: FontSize.h3FontSize + 5,
                              color: CustomColor.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        WrapperRow()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
      context: context,
      buttons: [],
      title: '',
      desc: "Course added Successfully !",
      image: Image.asset('assets/dialog_img.png'),
    ).show();
  }
}

class WrapperRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<List<UploadVideo>>(context);
    print("------------ ${user[0].description}");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditSingleVideoPage()),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                width: 130,
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: CustomColor.signUpButtonColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: CustomColor.white),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              width: 130,
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          color: CustomColor.signUpButtonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            width: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              width: 130,
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          color: CustomColor.signUpButtonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            width: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              width: 130,
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          color: CustomColor.signUpButtonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            width: 8,
          ),
          Container(
              decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              width: 130,
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          color: CustomColor.signUpButtonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
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
