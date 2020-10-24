import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:abora/screens/Trainer/edit_video_page.dart';
import 'package:abora/services/constants.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
  DatabaseService database;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    database = Provider.of<DatabaseService>(context);

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
              ProfileListView(
                database: database,
              )
            ]),
          ),
        ],
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

class ProfileListView extends StatefulWidget {
  final DatabaseService database;

  ProfileListView({this.database});
  @override
  _ProfileListViewState createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  TextEditingController bioTextController = new TextEditingController();
  bool bioEnabled = false;
  IconData editOrsaveIcon;

  List<String> upperList = <String>['1', 'X', 'X'];
  List<String> lowerList = <String>['30', '65', '110'];

  @override
  void initState() {
    super.initState();
    editOrsaveIcon = Icons.edit;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TrainerUser>(
        stream: widget.database.currentTrainerUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TrainerUser trainerData = snapshot.data;
            bioTextController.text = trainerData.bio;
            return ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  padding: const EdgeInsets.all(20),
                  height: 290.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bio',
                            style: TextStyle(color: CustomColor.red),
                          ),
                          GestureDetector(
                            onTap: () async {
                              bioEnabled = !bioEnabled;
                              bioEnabled
                                  ? editOrsaveIcon = Icons.check
                                  : editOrsaveIcon = Icons.edit;

                              if (!bioEnabled) {
                                bioTextController.text = await widget.database
                                    .updateSignleField(
                                        key: 'bio',
                                        value: bioTextController.text);
                              }
                              setState(() {});
                            },
                            child: Icon(
                              editOrsaveIcon,
                              color: Colors.white,
                              size: 30.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 500.h,
                        child: TextField(
                          controller: bioTextController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabled: bioEnabled,
                              hintMaxLines: 5,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Type here..."),
                          onChanged: (value) {},
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
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
                  margin: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
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
                                children: List.generate(upperList.length, (i) {
                              return _tableContainer(
                                  upperList[i], Colors.white, 1);
                            })),
                            TableRow(
                                children: List.generate(lowerList.length, (i) {
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
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
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
}

class WrapperRow extends StatefulWidget {
  @override
  _WrapperRowState createState() => _WrapperRowState();
}

class _WrapperRowState extends State<WrapperRow> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController = new VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/abora-42865.appspot.com/o/videos?alt=media&token=1e28571f-84ad-4f3c-b4f2-0feba4628efb");
    _initializeVideoPlayerFuture =
        videoPlayerController.initialize().then((_) => {setState(() {})});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<List<UploadVideo>>(context);
    // print("------------ ${user[0].description}");
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
                    Chewie(
                      key: PageStorageKey(
                          "https://firebasestorage.googleapis.com/v0/b/abora-42865.appspot.com/o/videos?alt=media&token=1e28571f-84ad-4f3c-b4f2-0feba4628efb"),
                      controller: ChewieController(
                          videoPlayerController: videoPlayerController,
                          aspectRatio: 1.8.h,
                          autoInitialize: true,
                          showControls: false,
                          looping: true,
                          autoPlay: true,
                          errorBuilder: (context, errorMessage) {
                            return Center(
                                child: Text(
                              'abc',
                              style: TextStyle(color: Colors.white),
                            ));
                          }),
                    ),
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
