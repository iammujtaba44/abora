import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/reviews.dart';
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
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Davei Samah',
                              style: TextStyle(
                                  fontSize: FontSize.h3FontSize + 5,
                                  color: CustomColor.white),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: WrapperRow(database: database),
                      )),
                  Expanded(flex: 1, child: Container()),
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
  TextEditingController areaTextController = new TextEditingController();
  TextEditingController specialityTextController = new TextEditingController();
  TextEditingController homeTrainingTextController =
      new TextEditingController();
  TextEditingController gymTrainingTextController = new TextEditingController();
  TextEditingController pricePerSessionTextController =
      new TextEditingController();
  TextEditingController paymentMethodTextController =
      new TextEditingController();

  bool bioEnabled = false;
  bool areaEnabled = false;
  bool specialityEnabled = false;
  bool homeTrainingEnabled = false;
  bool gymTrainingEnabled = false;
  bool pricePerSessionEnabled = false;
  bool paymentMethodEnabled = false;

  IconData editOrsaveIcon;
  IconData areaIconData;
  IconData specialityIconData;
  IconData homeTrainingIconData;
  IconData gymTrainingIconData;
  IconData pricePerSessionIconData;
  IconData paymentMethodIconData;

  List<String> upperList = <String>['1', 'X', 'X'];
  List<String> lowerList = <String>['30', '65', '110'];

  @override
  void initState() {
    super.initState();
    areaIconData = Icons.edit;
    specialityIconData = Icons.edit;
    homeTrainingIconData = Icons.edit;
    gymTrainingIconData = Icons.edit;
    pricePerSessionIconData = Icons.edit;
    paymentMethodIconData = Icons.edit;
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
            areaTextController.text = trainerData.area;
            specialityTextController.text = trainerData.speciality;
            homeTrainingTextController.text = trainerData.homeTraining;
            gymTrainingTextController.text = trainerData.gymTraining;
            pricePerSessionTextController.text = trainerData.pricePerSession;
            paymentMethodTextController.text = trainerData.paymentMethod;

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
                              hintText: "bio"),
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
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: areaTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: areaEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Area"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                areaEnabled = !areaEnabled;
                                areaEnabled
                                    ? areaIconData = Icons.check
                                    : areaIconData = Icons.edit;

                                if (!areaEnabled) {
                                  areaTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'area',
                                          value: areaTextController.text);
                                }
                                setState(() {});
                              },
                              child: Icon(areaIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: specialityTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: specialityEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Speciality"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                specialityEnabled = !specialityEnabled;
                                specialityEnabled
                                    ? specialityIconData = Icons.check
                                    : specialityIconData = Icons.edit;

                                if (!specialityEnabled) {
                                  specialityTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'speciality',
                                          value: specialityTextController.text);
                                }
                                setState(() {});
                              },
                              child: Icon(specialityIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: homeTrainingTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: homeTrainingEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Home Training"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                homeTrainingEnabled = !homeTrainingEnabled;
                                homeTrainingEnabled
                                    ? homeTrainingIconData = Icons.check
                                    : homeTrainingIconData = Icons.edit;

                                if (!homeTrainingEnabled) {
                                  homeTrainingTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'homeTraining',
                                          value:
                                              homeTrainingTextController.text);
                                }
                                setState(() {});
                              },
                              child: Icon(homeTrainingIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: gymTrainingTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: gymTrainingEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "GYM Training"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                print('abc--------------');
                                gymTrainingEnabled = !gymTrainingEnabled;
                                gymTrainingEnabled
                                    ? gymTrainingIconData = Icons.check
                                    : gymTrainingIconData = Icons.edit;

                                if (!gymTrainingEnabled) {
                                  gymTrainingTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'gymTraining',
                                          value:
                                              gymTrainingTextController.text);
                                }
                                setState(() {});
                              },
                              child: Icon(gymTrainingIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: pricePerSessionTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: pricePerSessionEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Price Per Session"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                print('abc--------------');
                                pricePerSessionEnabled =
                                    !pricePerSessionEnabled;
                                pricePerSessionEnabled
                                    ? pricePerSessionIconData = Icons.check
                                    : pricePerSessionIconData = Icons.edit;

                                if (!pricePerSessionEnabled) {
                                  pricePerSessionTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'pricePerSession',
                                          value: pricePerSessionTextController
                                              .text);
                                }
                                setState(() {});
                              },
                              child: Icon(pricePerSessionIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: paymentMethodTextController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: paymentMethodEnabled,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Payment Method"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                print('abc--------------');
                                paymentMethodEnabled = !paymentMethodEnabled;
                                paymentMethodEnabled
                                    ? paymentMethodIconData = Icons.check
                                    : paymentMethodIconData = Icons.edit;

                                if (!paymentMethodEnabled) {
                                  paymentMethodTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'paymentMethod',
                                          value:
                                              paymentMethodTextController.text);
                                }
                                setState(() {});
                              },
                              child: Icon(paymentMethodIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),

                      // descriptionContainer(
                      //   key: 'homeTraining',
                      //   controller: homeTrainingTextController,
                      //   enabled: homeTrainingEnabled,
                      //   iconData: iconData,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // descriptionContainer(
                      //   key: 'GYMTraining',
                      //   controller: gymTrainingTextController,
                      //   enabled: gymTrainingEnabled,
                      //   iconData: iconData,
                      // ),
                      // // SizedBox(
                      //   height: 10,
                      // ),
                      // descriptionContainer('Price Per Session (P/S)'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // descriptionContainer('Payment Method'),
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
                    child: StreamBuilder<List<Review>>(
                      stream: widget.database.reviewStream,
                      builder: (context, snapshot) {
                        return Container(
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
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: CustomColor.grey,
                                          backgroundImage:
                                              AssetImage('assets/trainer.jpg'),
                                          radius: 30,
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          snapshot.data[index].reviewerName,
                                          style: TextStyle(
                                              color: CustomColor.white,
                                              fontSize:
                                                  FontSize.h3FontSize - 3),
                                        ),
                                        subtitle: Text(
                                          snapshot.data[index].reivew,
                                          style: TextStyle(
                                              color: CustomColor.grey,
                                              fontSize: 13),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  );
                                },
                                // children: [

                                //   SizedBox(
                                //     height: 15,
                                //   ),
                                //   ListTile(
                                //     leading: CircleAvatar(
                                //       backgroundColor: CustomColor.grey,
                                //       backgroundImage: AssetImage('assets/trainer.jpg'),
                                //       radius: 30,
                                //     ),
                                //     contentPadding: EdgeInsets.all(0),
                                //     title: Text(
                                //       'Patricia Lucas',
                                //       style: TextStyle(
                                //           color: CustomColor.white,
                                //           fontSize: FontSize.h3FontSize - 3),
                                //     ),
                                //     subtitle: Text(
                                //       'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
                                //       style: TextStyle(
                                //           color: CustomColor.grey, fontSize: 13),
                                //     ),
                                //   ),
                                //   SizedBox(
                                //     height: 15,
                                //   ),
                                //   ListTile(
                                //     leading: CircleAvatar(
                                //       backgroundColor: CustomColor.grey,
                                //       backgroundImage: AssetImage('assets/trainer.jpg'),
                                //       radius: 30,
                                //     ),
                                //     contentPadding: EdgeInsets.all(0),
                                //     title: Text(
                                //       'Patricia Lucas',
                                //       style: TextStyle(
                                //           color: CustomColor.white,
                                //           fontSize: FontSize.h3FontSize - 3),
                                //     ),
                                //     subtitle: Text(
                                //       'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
                                //       style: TextStyle(
                                //           color: CustomColor.grey, fontSize: 13),
                                //     ),
                                //   )
                                // ],
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget descriptionContainer({
    String text,
    TextEditingController controller,
    bool enabled,
    IconData iconData,
    String key,
  }) {
    return Stack(
      children: [
        Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: CustomColor.backgroundColor,
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabled: enabled,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Bio"),
                onChanged: (value) {},
              ),
            )),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () async {
              enabled = !enabled;
              enabled ? iconData = Icons.check : iconData = Icons.edit;

              if (!enabled) {
                controller.text = await widget.database
                    .updateSignleField(key: key, value: controller.text);
              }
              setState(() {});
            },
            child: Icon(iconData, color: Colors.white, size: 30.h),
          ),
        )
      ],
    );
  }
}

class WrapperRow extends StatefulWidget {
  final DatabaseService database;

  WrapperRow({this.database});
  @override
  _WrapperRowState createState() => _WrapperRowState();
}

class _WrapperRowState extends State<WrapperRow> {
  @override
  Widget build(BuildContext context) {
    // final videos = Provider.of<List<UploadVideo>>(context) ?? [];

    return StreamBuilder<List<UploadVideo>>(
        stream: widget.database.uploadVideoStream,
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                key: PageStorageKey('keydata$index'),
                child: Row(
                  children: [
                    VideoWidget(
                      play: true,
                      videoURL: snapshot.data[index].video,
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String videoURL;

  VideoWidget({this.play, this.videoURL});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController = new VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                width: 130,
                height: 100,
                child: Stack(
                  children: [
                    Chewie(
                      key: PageStorageKey(widget.videoURL),
                      controller: ChewieController(
                          videoPlayerController: videoPlayerController,
                          aspectRatio: 1.8.h,
                          autoInitialize: true,
                          showControls: false,
                          looping: false,
                          autoPlay: false,
                          errorBuilder: (context, errorMessage) {
                            return Center(
                                child: Text(
                              errorMessage,
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
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
