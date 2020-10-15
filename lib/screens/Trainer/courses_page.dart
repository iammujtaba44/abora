import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/upload_course.dart';

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
      home: CoursesPage(),
    );
  }
}

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  double height;

  double width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(640, 1134), allowFontScaling: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'MY COURSES',
          style: TextStyle(fontSize: FontSize.h3FontSize),
        ),
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
            children: List.generate(
                5,
                (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadCoursePage()),
                        );
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 180.h,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/trainer.jpg',
                                      ),
                                    )),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: CustomColor.signUpButtonColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    '\$49.50',
                                    style: TextStyle(color: CustomColor.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Course Title',
                            style: TextStyle(
                                color: CustomColor.red,
                                fontSize: FontSize.h3FontSize,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '20 videos',
                            style: TextStyle(
                                color: CustomColor.grey,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )),
          ),
        ),
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
