import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      home: BookCourse(),
    );
  }
}

class BookCourse extends StatefulWidget {
  final String email;

  BookCourse({this.email});
  @override
  _BookCourseState createState() => _BookCourseState();
}

class _BookCourseState extends State<BookCourse> {
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');

  double height = 0;

  double width;
  List dataList = List();
  @override
  void initState() {
    super.initState();

    getData();
    // print(widget.email);
    // DatabaseService().getTrainerCoursesOnce(widget.email);
    // print(DatabaseService(email: widget.email).getTrainerCoursesOnce.isEmpty);
    // getData();
    // print(dataList);
  }

  Future getData() async {
    var querySnapshot =
        await trainer.where('email', isEqualTo: widget.email).get();
    querySnapshot.docs.forEach((result) async {
      var querySnapshot2 =
          await trainer.doc(result.id).collection("courses").get();

      querySnapshot2.docs.forEach((result) {
        //  print(result.data());
        dataList.add(result.data());
        //print('--------------${Constants.globalCourses}');
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: dataList.length == 0
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 5,
                    children: List.generate(
                        dataList.length,
                        (index) => GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 180.h,
                                        width: width,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            '\$${dataList[index]['cost']}',
                                            style: TextStyle(
                                                color: CustomColor.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    dataList[index]['title'],
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontSize: FontSize.h3FontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${dataList[index]['courseVideosLink'].length}',
                                    style: TextStyle(
                                        color: CustomColor.grey,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )),
                  ),
                ),
              ));
  }
}
