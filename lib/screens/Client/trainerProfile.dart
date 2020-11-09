import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/reviews.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:abora/screens/Client/booking/booking_tab.dart';
import 'package:abora/screens/Client/videoPage_screen.dart';
import 'package:abora/services/database.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TrainerProfilePage extends StatefulWidget {
  final trainerData;

  TrainerProfilePage({this.trainerData});
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerProfilePage> {
  double height;
  double width;
  DatabaseService database;

  Map data;
  @override
  void initState() {
    super.initState();
    data = widget.trainerData;
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
                data: data,
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
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/trainer.jpg'), fit: BoxFit.fill),
              ),
              height: height / 2.5,
              width: double.infinity,
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
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                        fontSize: FontSize.h3FontSize + 5,
                                        color: CustomColor.white),
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: FlatButton(
                                      color: CustomColor.signUpButtonColor,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookingTab(
                                                  bio: data['bio'],
                                                  email: data['email'],
                                                  name: data['name'])),
                                        );
                                      },
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.h5FontSize),
                                      ),
                                    ),
                                  )
                                ],
                              )),
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
                        child: WrapperRow(
                          database: database,
                          data: data,
                        ),
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
}

class ProfileListView extends StatefulWidget {
  final DatabaseService database;
  final Map data;

  ProfileListView({this.database, this.data});
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

  // IconData editOrsaveIcon;
  // IconData areaIconData;
  // IconData specialityIconData;
  Container homeTrainingIconData;
  Container gymTrainingIconData;
  // IconData pricePerSessionIconData;
  // IconData paymentMethodIconData;

  List<String> upperList = <String>['1', 'X', 'X'];
  List<String> lowerList = <String>['30', '65', '110'];
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');
  List dataList = List();
  @override
  void initState() {
    super.initState();

    bioTextController.text = widget.data['bio'];
    areaTextController.text = widget.data['area'];
    specialityTextController.text = widget.data['speciality'];
    homeTrainingTextController.text = widget.data['hometraining'];
    gymTrainingTextController.text = widget.data['gymtraining'];
    pricePerSessionTextController.text = widget.data['pricepersession'];
    paymentMethodTextController.text = widget.data['paymentmethod'];

    if (widget.data['hometraining'] == null) {
      homeTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.grey,
      );
    }

    if (widget.data['hometraining'] == 'green') {
      homeTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.green,
      );
      homeTrainingEnabled = true;
    } else if (widget.data['hometraining'] == 'red') {
      homeTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.red,
      );
      homeTrainingEnabled = false;
    }
    if (widget.data['gymtraining'] == null) {
      gymTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.grey,
      );
    }

    if (widget.data['gymtraining'] == 'green') {
      gymTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.green,
      );
      gymTrainingEnabled = true;
    } else if (widget.data['gymtraining'] == 'red') {
      gymTrainingIconData = Container(
        height: 20,
        width: 20,
        color: Colors.red,
      );
      gymTrainingEnabled = false;
    }
    getData();

    // areaIconData = Icons.edit;
    // specialityIconData = Icons.edit;
    // homeTrainingIconData = Icons.edit;
    // gymTrainingIconData = Icons.edit;
    // pricePerSessionIconData = Icons.edit;
    // paymentMethodIconData = Icons.edit;
    // editOrsaveIcon = Icons.edit;
  }

  Future getData() async {
    var querySnapshot =
        await trainer.where('email', isEqualTo: widget.data['email']).get();
    querySnapshot.docs.forEach((result) async {
      var querySnapshot2 =
          await trainer.doc(result.id).collection("reviews").get();

      querySnapshot2.docs.forEach((result) {
        //print(result.data());
        dataList.add(result.data());
        //print('--------------${Constants.globalCourses}');
      });
      print(dataList);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabled: false,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "Home Training"),
                          onChanged: (value) {},
                        ),
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: homeTrainingIconData,
                      ),
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabled: false,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "GYM Training"),
                          onChanged: (value) {},
                        ),
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: gymTrainingIconData,
                      ),
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
                ],
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
                          color: Colors.grey.withOpacity(0.5), width: 1)),
                  children: [
                    TableRow(
                        children: List.generate(upperList.length, (i) {
                      return _tableContainer(upperList[i], Colors.white, 1);
                    })),
                    TableRow(
                        children: List.generate(lowerList.length, (i) {
                      return _tableContainer(
                          lowerList[i], Colors.grey.withOpacity(0.5), 2);
                    })),
                  ],
                ),
              ),
            ],
          ),
        ),
        dataList.length == 0
            ? Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Container(
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
                    ],
                  ),
                ))
            : Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Container(
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
                        itemCount: dataList.length,
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
                                  dataList[index]['reviewerName'],
                                  style: TextStyle(
                                      color: CustomColor.white,
                                      fontSize: FontSize.h3FontSize - 3),
                                ),
                                subtitle: Text(
                                  dataList[index]['review'],
                                  style: TextStyle(
                                      color: CustomColor.grey, fontSize: 13),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )),
        SizedBox(
          height: 20.0,
        )
      ],
    );
    // return StreamBuilder<TrainerUser>(
    //     stream: widget.database.currentTrainerUserStream,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         TrainerUser trainerData = snapshot.data;
    //         bioTextController.text = trainerData.bio;
    //         areaTextController.text = trainerData.area;
    //         specialityTextController.text = trainerData.speciality;
    //         homeTrainingTextController.text = trainerData.homeTraining;
    //         gymTrainingTextController.text = trainerData.gymTraining;
    //         pricePerSessionTextController.text = trainerData.pricePerSession;
    //         paymentMethodTextController.text = trainerData.paymentMethod;
    //
    //
    //       }
    //       return Scaffold(body: Center(child: CircularProgressIndicator()));
    //     });

    // Expanded(
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Theme.of(context).primaryColor,
    //         borderRadius: BorderRadius.circular(5)),
    //     margin:
    //     const EdgeInsets.only(top: 20, left: 20.0, right: 20),
    //     padding: const EdgeInsets.all(20),
    //     width: double.infinity,
    //     child: StreamBuilder<List<Review>>(
    //       stream: widget.database.reviewStream,
    //       builder: (context, snapshot) {
    //         return Container(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Reviews',
    //                 style: TextStyle(color: CustomColor.red),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               ListView.builder(
    //                 itemCount: snapshot.data.length,
    //                 shrinkWrap: true,
    //                 itemBuilder: (context, index) {
    //                   return Column(
    //                     children: [
    //                       ListTile(
    //                         leading: CircleAvatar(
    //                           backgroundColor: CustomColor.grey,
    //                           backgroundImage:
    //                           AssetImage('assets/trainer.jpg'),
    //                           radius: 30,
    //                         ),
    //                         contentPadding: EdgeInsets.all(0),
    //                         title: Text(
    //                           snapshot.data[index].reviewerName,
    //                           style: TextStyle(
    //                               color: CustomColor.white,
    //                               fontSize:
    //                               FontSize.h3FontSize - 3),
    //                         ),
    //                         subtitle: Text(
    //                           snapshot.data[index].reivew,
    //                           style: TextStyle(
    //                               color: CustomColor.grey,
    //                               fontSize: 13),
    //                         ),
    //                       ),
    //                       SizedBox(height: 15),
    //                     ],
    //                   );
    //                 },
    //                 // children: [
    //
    //                 //   SizedBox(
    //                 //     height: 15,
    //                 //   ),
    //                 //   ListTile(
    //                 //     leading: CircleAvatar(
    //                 //       backgroundColor: CustomColor.grey,
    //                 //       backgroundImage: AssetImage('assets/trainer.jpg'),
    //                 //       radius: 30,
    //                 //     ),
    //                 //     contentPadding: EdgeInsets.all(0),
    //                 //     title: Text(
    //                 //       'Patricia Lucas',
    //                 //       style: TextStyle(
    //                 //           color: CustomColor.white,
    //                 //           fontSize: FontSize.h3FontSize - 3),
    //                 //     ),
    //                 //     subtitle: Text(
    //                 //       'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
    //                 //       style: TextStyle(
    //                 //           color: CustomColor.grey, fontSize: 13),
    //                 //     ),
    //                 //   ),
    //                 //   SizedBox(
    //                 //     height: 15,
    //                 //   ),
    //                 //   ListTile(
    //                 //     leading: CircleAvatar(
    //                 //       backgroundColor: CustomColor.grey,
    //                 //       backgroundImage: AssetImage('assets/trainer.jpg'),
    //                 //       radius: 30,
    //                 //     ),
    //                 //     contentPadding: EdgeInsets.all(0),
    //                 //     title: Text(
    //                 //       'Patricia Lucas',
    //                 //       style: TextStyle(
    //                 //           color: CustomColor.white,
    //                 //           fontSize: FontSize.h3FontSize - 3),
    //                 //     ),
    //                 //     subtitle: Text(
    //                 //       'Lorem losum door sit amet conseteur sadisping elitr, sed diam nonumy',
    //                 //       style: TextStyle(
    //                 //           color: CustomColor.grey, fontSize: 13),
    //                 //     ),
    //                 //   )
    //                 // ],
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // ),
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
  final Map data;

  WrapperRow({this.database, this.data});
  @override
  _WrapperRowState createState() => _WrapperRowState();
}

class _WrapperRowState extends State<WrapperRow> {
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');
  List dataList = List();

  Future getData() async {
    var querySnapshot =
        await trainer.where('email', isEqualTo: widget.data['email']).get();
    querySnapshot.docs.forEach((result) async {
      var querySnapshot2 =
          await trainer.doc(result.id).collection("uploadVideo").get();

      querySnapshot2.docs.forEach((result) {
        //print(result.data());
        dataList.add(result.data());
        //print('--------------${Constants.globalCourses}');
      });
      // print(dataList);
      setState(() {});
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // final videos = Provider.of<List<UploadVideo>>(context) ?? [];

    return dataList.length == 0
        ? Center(child: CircularProgressIndicator())
        : Container(
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  key: PageStorageKey('keydata$index'),
                  child: Row(
                    children: [
                      VideoWidget(
                        play: true,
                        videoURL: dataList[index]['video'],
                        title: dataList[index]['title'],
                        desc: dataList[index]['description'],
                        alldata: dataList,
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String videoURL;
  final String title;
  final String desc;
  final List alldata;

  VideoWidget({this.play, this.videoURL, this.title, this.desc, this.alldata});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // print("------------");
    // print(widget.alldata);
    videoPlayerController = new VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPage(
                                        videoData: {
                                          'videoUrl': widget.videoURL,
                                          'title': widget.title,
                                          'desc': widget.desc,
                                          'data': widget.alldata
                                        },
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: CustomColor.signUpButtonColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'view',
                            style: TextStyle(color: CustomColor.white),
                          ),
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
