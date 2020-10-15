import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
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
      home: UploadCoursePageExperiment(),
    );
  }
}

class UploadCoursePageExperiment extends StatefulWidget {
  @override
  _UploadCoursePageExperimentState createState() => _UploadCoursePageExperimentState();
}

class _UploadCoursePageExperimentState extends State<UploadCoursePageExperiment> {
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
        appBar: AppBar(
          title: Text('MY COURSES'),
          leading: Container(),
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/logo.png',
              width: 130,
              height: 130,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
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
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
        /*              Expanded(child: rectBorderWidget),
                      Expanded(child: rectBorderWidget),
                      Expanded(child: rectBorderWidget),
        */            ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
         /*             Expanded(child: rectBorderWidget),
                      Expanded(child: rectBorderWidget),
                      Expanded(child: rectBorderWidget),
        */            ],
                  ),
                  Spacer()
                ],
                
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.yellow,
            )),
          ],
        ));
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
