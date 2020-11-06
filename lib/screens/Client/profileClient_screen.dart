import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/videoPage_screen.dart';
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
      home: ProfileClientPage(),
    );
  }
}

class ProfileClientPage extends StatefulWidget {
  @override
  _ProfileClientPageState createState() => _ProfileClientPageState();
}

class _ProfileClientPageState extends State<ProfileClientPage> {
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
                    height: 130,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bulk Sessions',
                          style: TextStyle(color: CustomColor.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '1',
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    ),
                                    Text(
                                      'X',
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    ),
                                    Text(
                                      'X',
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '30',
                                      style: TextStyle(color: CustomColor.grey),
                                    ),
                                    Text(
                                      '65',
                                      style: TextStyle(color: CustomColor.grey),
                                    ),
                                    Text(
                                      '110',
                                      style: TextStyle(color: CustomColor.grey),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      margin:
                          const EdgeInsets.only(top: 20, left: 20.0, right: 20),
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
                              backgroundImage: AssetImage('assets/trainer.jpg'),
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
                              backgroundImage: AssetImage('assets/trainer.jpg'),
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
                              backgroundImage: AssetImage('assets/trainer.jpg'),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPage()),
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
                                                color: CustomColor
                                                    .signUpButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              'View',
                                              style: TextStyle(
                                                  color: CustomColor.white),
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
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                color: CustomColor.white),
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
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                color: CustomColor.white),
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
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                color: CustomColor.white),
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
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            'View',
                                            style: TextStyle(
                                                color: CustomColor.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        )
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
}
