import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/appointment.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:flutter/cupertino.dart';
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
      home: EditSingleVideoPage(),
    );
  }
}

class EditSingleVideoPage extends StatefulWidget {
  @override
  _EditSingleVideoPageState createState() => _EditSingleVideoPageState();
}

class _EditSingleVideoPageState extends State<EditSingleVideoPage> {
  double height;

  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDIT VIDEO',
          style: TextStyle(
              fontSize: FontSize.h3FontSize, fontWeight: FontWeight.w400),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.red,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 50,
            height: 120,
          ),
        ],
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.all(20.0),
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: height / 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: new RichText(
                          text: new TextSpan(
                            style: TextStyle(
                                fontSize: FontSize.h3FontSize,
                                color: CustomColor.red),
                            text: 'Upload videos',
                            children: [],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: FontSize.h3FontSize,
                              color: CustomColor.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  /*   DottedBorder(
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
                          size: 50,
                          color: CustomColor.dottedBorderColor),
                      height: 200.h,
                      width: double.infinity,
                    ),
                  ),
                ),*/
                  rectBorderWidget(context, height: 200, width: double.infinity,
                      func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostAdPage()),
                    );
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentPage()),
                          );
                        },
                        child: Container(
                          child: Text(
                            'Title',
                            style: TextStyle(
                                color: CustomColor.red,
                                fontSize: FontSize.h3FontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: FontSize.h3FontSize,
                              color: CustomColor.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customTextField(text: 'Title of Video', curveContainer: true),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            color: CustomColor.red,
                            fontSize: FontSize.h3FontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: FontSize.h3FontSize,
                            color: CustomColor.blue),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: CustomColor.textFieldFilledColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: CustomColor.textFieldBorderColor)),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          prefixIcon: null,
                          hintText:
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et',
                          hintStyle: TextStyle(
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
          Expanded(
              child: Column(
            children: [
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
            ],
          ))
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
