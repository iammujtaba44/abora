import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';

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
      home: UploadCoursePageCopy(),
    );
  }
}

class UploadCoursePageCopy extends StatefulWidget {
  @override
  _UploadCoursePageCopyState createState() => _UploadCoursePageCopyState();
}

class _UploadCoursePageCopyState extends State<UploadCoursePageCopy> {
  double height;

  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70.h,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: CustomColor.red,
                  ),
                  Text(
                    'UPLOAD COURSE',
                    style: TextStyle(
                        color: CustomColor.white,
                        fontSize: FontSize.h3FontSize + 4),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: CustomColor.red,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: new RichText(
                      text: new TextSpan(
                        style: TextStyle(
                            fontSize: FontSize.h3FontSize,
                            color: CustomColor.red),
                        text: 'Upload videos',
                        children: [
                          new TextSpan(
                            style: TextStyle(
                                color: CustomColor.grey,
                                fontSize: FontSize.h5FontSize,
                                fontWeight: FontWeight.w600),
                            text: ' (you can add multiple videos)',
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        color: CustomColor.dottedBorderColor,
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.textFieldFilledColor,
                            ),
                            child: Icon(Icons.cloud_upload,
                                size: 50, color: CustomColor.dottedBorderColor),
                            height: 100.h,
                            width: 100.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Course Title',
                    style: TextStyle(
                        color: CustomColor.red,
                        fontSize: FontSize.h3FontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: CustomColor.textFieldFilledColor,
                        border: Border.all(
                            color: CustomColor.textFieldBorderColor)),
                    child: TextField(
                        decoration: InputDecoration(
                      prefixIcon: null,
                      labelText: 'Type here',
                      labelStyle: TextStyle(
                          color: CustomColor.textFieldLabelColor,
                          fontSize: FontSize.h3FontSize - 2),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Course Title',
                    style: TextStyle(
                        color: CustomColor.red,
                        fontSize: FontSize.h3FontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: CustomColor.textFieldFilledColor,
                        border: Border.all(
                            color: CustomColor.textFieldBorderColor)),
                    child: TextField(
                        decoration: InputDecoration(
                      prefixIcon: null,
                      labelText: 'Type here',
                      labelStyle: TextStyle(
                          color: CustomColor.textFieldLabelColor,
                          fontSize: FontSize.h3FontSize - 2),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Course Title',
                    style: TextStyle(
                        color: CustomColor.red,
                        fontSize: FontSize.h3FontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: CustomColor.textFieldFilledColor,
                        border: Border.all(
                            color: CustomColor.textFieldBorderColor)),
                    child: TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          prefixIcon: null,
                          labelText: 'Type here',
                          labelStyle: TextStyle(
                              color: CustomColor.textFieldLabelColor,
                              fontSize: FontSize.h3FontSize - 2),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
            child: blueButton(
              child: Text(
                'UPLOAD COURSE',
                style: TextStyle(color: Colors.white),
              ),
              func: () => _onAlertButtonsPressed(context),
            ),
          ),
          Spacer(),
        ],
      ),
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
  String get title => 'IPad';
  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.ipadPro12,
          child: MyApp(),
        ),
      ];
}
