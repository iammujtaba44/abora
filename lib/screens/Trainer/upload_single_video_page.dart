import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/mybookings_screen.dart';
import 'package:abora/screens/Client/news_screen.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/services/storage.dart';

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
import 'package:image_picker/image_picker.dart';
import 'package:preview/preview.dart';
import 'package:provider/provider.dart';

import '../../services/constants.dart';

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
      home: UploadSingleVideoPage(),
    );
  }
}

class UploadSingleVideoPage extends StatefulWidget {
  @override
  _UploadSingleVideoPageState createState() => _UploadSingleVideoPageState();
}

class _UploadSingleVideoPageState extends State<UploadSingleVideoPage> {
  double height;

  double width;
  
  

  Storage _storage ;

  @override
  void initState() {
    // TODO: implement initState
    _storage = Storage(uId: UserCredentials.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPLOAD VIDEO',
          style: TextStyle(fontSize: FontSize.h3FontSize),
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
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.all(20.0),
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: height / 12),
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
                        children: [],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  rectBorderWidget(context, height: 200, width: double.infinity,
                      func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostAdPage()),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mybookings()),
                      );
                    },
                    child: Text(
                      'Title',
                      style: TextStyle(
                          color: CustomColor.red,
                          fontSize: FontSize.h3FontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      text: 'Type here', curveContainer: true, isPadding: true),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                        color: CustomColor.red,
                        fontSize: FontSize.h3FontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: CustomColor.textFieldFilledColor,
                        border: Border.all(
                            color: CustomColor.textFieldBorderColor)),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon: null,
                          hintText: 'Type here',
                          contentPadding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
                  func: () async {

                _storage.uploadToStorage();

                    
                    // final user = Provider.of<User>(context, listen: false);
                    // // print('---------${user.uid}');
                    // await DatabaseService(uId: user.uid).uploadVideo(
                    //     title: 'Raheel', description: 'okay2', video: 'http2');
                  }, //_onAlertButtonsPressed(context),
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
      desc: "Video Uploaded Successfully !",
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
