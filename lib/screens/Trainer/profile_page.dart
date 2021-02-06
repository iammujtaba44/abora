import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/reviews.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:abora/screens/Trainer/edit_video_page.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';
import 'package:abora/screens/Trainer/upload_single_video_page.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/loading_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
          SizedBox(width: 20,)
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
    
     floatingActionButton: SpeedDial(
                child: Icon(Icons.add),
                animatedIconTheme: IconThemeData(size: 22.0),
                // this is ignored if animatedIcon is non null
                // child: Icon(Icons.add),

                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag',
                backgroundColor: CustomColor.signUpButtonColor,
                foregroundColor: CustomColor.white,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.add_circle),
                      backgroundColor: Colors.orange,
                      label: 'Post Ad',
                      onTap: () async {
                        // List<AppointmentModel> aa = database.apintmentStream;
                        // print(aa);
                        // 2020-10-25
                        // List<String> dates1 = [Helper.getDate(DateTime.now())];
                        // List<String> dates1 = [
                        //   '2020-10-10',
                        //   '2020-10-11',
                        //   '2020-10-12'
                        // ];
                        // database.uploadApointmentAsync(
                        //     clientName: 'RaheelZain',
                        //     imageUrl: 'XYZ',
                        //     goal: 'loose 4kg',
                        //     noOfBookings: '1',
                        //     sessionType: 'one-o-one',
                        //     dates: dates1);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostAdPage()),
                        );
                      }
                      // onTap: () async {
                      //   await _auth.signOut();
                      // },
                      ),
                  SpeedDialChild(
                    child: Icon(Icons.cloud_upload),
                    backgroundColor: CustomColor.white,
                    label: 'Upload Video',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadSingleVideoPage(),
                          ));
                    },
                  ),
                ],
              ),
              
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
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
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                Constants.trainerUserData.name,
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
      ),
    );
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
  TextEditingController parkTrainingTextController = new TextEditingController();
  TextEditingController pricePerSessionTextController =
      new TextEditingController();
  TextEditingController paymentMethodTextController =
      new TextEditingController();




  bool bioEnabled = false;
  bool areaEnabled = false;
  bool specialityEnabled = false;
  bool homeTrainingEnabled = false;
  bool gymTrainingEnabled = false;
  bool parkTrainingEnabled = false;
  bool pricePerSessionEnabled = false;
  bool paymentMethodEnabled = false;

  IconData editOrsaveIcon;
  IconData areaIconData;
  IconData specialityIconData;
  Container homeTrainingIconData;
  Container gymTrainingIconData;
  Container parkTrainingIconData;
  IconData pricePerSessionIconData;
  IconData paymentMethodIconData;



  

  List<TextEditingController> upperList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> bulkSessionTextFields = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];



  @override
  void initState() {
    super.initState();
    areaIconData = null;
    specialityIconData = null;
    homeTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
    gymTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
    parkTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
    pricePerSessionIconData = null;
    paymentMethodIconData = null;
    editOrsaveIcon = null;
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
            parkTrainingTextController.text = trainerData.parkTraining;
            pricePerSessionTextController.text = trainerData.pricePerSession;
            paymentMethodTextController.text = trainerData.paymentMethod;
            bulkSessionTextFields[0].text = trainerData.session1;
            bulkSessionTextFields[1].text = trainerData.session2;
            bulkSessionTextFields[2].text = trainerData.session3;
            upperList[0].text = trainerData.noOfSession1;
            upperList[1].text = trainerData.noOfSession2;
            upperList[2].text = trainerData.noOfSession3;



            if(trainerData.homeTraining == 'green' ) {
              homeTrainingIconData = Container(height: 20, width: 20, color: Colors.green,);
              homeTrainingEnabled = true;
            } else if(trainerData.homeTraining == 'black') {
              homeTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
              homeTrainingEnabled = false;
            } 

             if(trainerData.gymTraining == 'green' ) {
              gymTrainingIconData = Container(height: 20, width: 20, color: Colors.green,);
              gymTrainingEnabled = true;
            } else if(trainerData.gymTraining == 'black') {
              gymTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
              gymTrainingEnabled = false;
            } 

              if(trainerData.parkTraining == 'green' ) {
              parkTrainingIconData = Container(height: 20, width: 20, color: Colors.green,);
              parkTrainingEnabled = true;
            } else if(trainerData.parkTraining == 'black') {
              parkTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);
              parkTrainingEnabled = false;
            } 



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
                            style: TextStyle(color: CustomColor.white),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // bioEnabled = !bioEnabled;
                              // bioEnabled
                              //     ? editOrsaveIcon = Icons.check
                              //     : editOrsaveIcon = Icons.edit;

                              // if (!bioEnabled) {
                          
                              // }
                              // setState(() {});
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
                            border: InputBorder.none,
                              enabled: true,
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
                  height: 550,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(color: CustomColor.white),
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
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                      enabled: true,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Area"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                // areaEnabled = !areaEnabled;
                                // areaEnabled
                                //     ? areaIconData = Icons.check
                                //     : areaIconData = Icons.edit;

                                // if (!areaEnabled) {
                               //  }
                                // setState(() {});
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
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                      enabled: true,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Speciality"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                // specialityEnabled = !specialityEnabled;
                                // specialityEnabled
                                //     ? specialityIconData = Icons.check
                                //     : specialityIconData = Icons.edit;

                                // if (!specialityEnabled) {
                            //     }
                                // setState(() {});
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
                                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15, right: 10),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(

                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Home Training"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 5),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  homeTrainingEnabled = !homeTrainingEnabled;
                                  homeTrainingEnabled
                                      ? homeTrainingIconData = Container(height: 20, width: 20 color: Colors.green,):
                                      homeTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);


                                   homeTrainingEnabled ?
                                        await widget.database.updateSignleField(
                                            key: 'homeTraining',
                                            value:
                                                'green') :
                                                await widget.database.updateSignleField(key: 'homeTraining', value: 'black');

                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: homeTrainingIconData,
                                )
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
                                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15, right: 10),
                                child: TextField(

                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "GYM Training"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async {
                                  gymTrainingEnabled = !gymTrainingEnabled;
                                  gymTrainingEnabled
                                      ? gymTrainingIconData = Container(height: 20, width: 20, color: Colors.green,)
                                      : gymTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);


                                   gymTrainingEnabled ?
                                        await widget.database.updateSignleField(
                                            key: 'gymTraining',
                                            value:
                                                'green') :
                                                await widget.database.updateSignleField(key: 'gymTraining', value: 'black');





                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: gymTrainingIconData,
                                ),
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
                                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15, right: 10),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Park Training"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async {
                                  parkTrainingEnabled = !parkTrainingEnabled;
                                  parkTrainingEnabled
                                      ? parkTrainingIconData = Container(height: 20, width: 20, color: Colors.green,)
                                      : parkTrainingIconData = Container(height: 20, width: 20, color: Colors.black,);


                                   parkTrainingEnabled ?
                                        await widget.database.updateSignleField(
                                            key: 'parkTraining',
                                            value:
                                                'green') :
                                                await widget.database.updateSignleField(key: 'parkTraining', value: 'black');





                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: parkTrainingIconData,
                                ),
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
                                     border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                      enabled: true,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Price Per Session"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                // print('abc--------------');
                                // pricePerSessionEnabled =
                                //     !pricePerSessionEnabled;
                                // pricePerSessionEnabled
                                //     ? pricePerSessionIconData = Icons.check
                                //     : pricePerSessionIconData = Icons.edit;

                                // if (!pricePerSessionEnabled) {
                                
                                // }
                                // setState(() {});
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
                                     border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                      enabled: true,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Payment Method"),
                                  onChanged: (value) {},
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async {
                                // paymentMethodEnabled = !paymentMethodEnabled;
                                // paymentMethodEnabled
                                //     ? paymentMethodIconData = Icons.check
                                //     : paymentMethodIconData = Icons.edit;

                                // if (!paymentMethodEnabled) {
                            
                                // }
                                // setState(() {});
                              },
                              child: Icon(paymentMethodIconData,
                                  color: Colors.white, size: 30.h),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10),
              // Constants.isLoading
              // ? loadingWidget() :
                     blueButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Save Changes'.toUpperCase(),
                        style: TextStyle(color: CustomColor.white),
                      ),
                    ],
                  ),
                  func: () async {
                    // Constants.isLoading = true;
                    // setState(() {
                      
                    // });

                    customToast(text: 'Please wait....');


                    bulkSessionTextFields[0].text = await widget.database.updateSignleField(key: 'session1',
                        value: bulkSessionTextFields[0].text);

                    bulkSessionTextFields[1].text = await widget.database.updateSignleField(key: 'session2',
                        value: bulkSessionTextFields[1].text);

                    bulkSessionTextFields[2].text = await widget.database.updateSignleField(key: 'session3',
                        value: bulkSessionTextFields[2].text);

                    upperList[0].text = await widget.database.updateSignleField(key: 'noOfSession1',
                        value: upperList[0].text);
                    upperList[1].text = await widget.database.updateSignleField(key: 'noOfSession2',
                        value: upperList[1].text);
                    upperList[2].text = await widget.database.updateSignleField(key: 'noOfSession3',
                        value: upperList[2].text);







                    areaTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'area',
                                          value: areaTextController.text);
//                                                specialityTextController.text =
                           specialityTextController.text =           await widget.database.updateSignleField(
                                          key: 'speciality',
                                          value: specialityTextController.text);
                           
                                bioTextController.text = await widget.database
                                    .updateSignleField(
                                        key: 'bio',
                                        value: bioTextController.text);                

                                          pricePerSessionTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'pricePerSession',
                                          value: pricePerSessionTextController
                                              .text);

                                                    paymentMethodTextController.text =
                                      await widget.database.updateSignleField(
                                          key: 'paymentMethod',
                                          value:
                                              paymentMethodTextController.text);

                    Constants.bulkSessions.add(bulkSessionTextFields[0].text);
                    Constants.bulkSessions.add(bulkSessionTextFields[1].text);
                    Constants.bulkSessions.add(bulkSessionTextFields[2].text);
                    Constants.bulkSessions.add(upperList[0].text);
                    Constants.bulkSessions.add(upperList[1].text);
                    Constants.bulkSessions.add(upperList[2].text);


                                              customToast(text: 'updated successfully');



                                              // setState(() {
                                                
                                              // });
                              
                  }),
              
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
                          color: CustomColor.white,
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
                                  textEditingController: upperList[i], color: Colors.white,

                                  type: 2);
                            })),
                            TableRow(
                                children: List.generate(bulkSessionTextFields.length, (i) {
                                  return _tableContainer(
                                      textEditingController: bulkSessionTextFields[i],
                                      color: Colors.grey.withOpacity(0.5),type: 2,);
                                })),
                          ],
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
                  width: double.infinity,
                  child: StreamBuilder<List<Review>>(
                    stream: widget.database.reviewStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(color: CustomColor.white),
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
                                            fontSize: FontSize.h3FontSize - 3),
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
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _tableContainer({TextEditingController textEditingController, String label, Color color, int type} ) {
    return Container(
      padding: EdgeInsets.all(20.0.h),
      child: type == 1
          ? Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 20.0.h,
              ))
          : Container(
          alignment: Alignment.center,
          width: 30 ,height: 20,child: TextField(
controller: textEditingController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: TextStyle(color: Colors.grey, ),
        ),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 20.0.h,),
      ),)
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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
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
                      description: snapshot.data[index].description,
                      title: snapshot.data[index].title,
                      docId: snapshot.data[index].docId,
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
  final String docId;
  final String videoURL;
  final String title;
  final String description;

  VideoWidget(
      {this.play, this.videoURL, this.title, this.description, this.docId});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSingleVideoPage(
                                    docId: widget.docId,
                                    videoURL: widget.videoURL,
                                    title: widget.title,
                                    description: widget.description),
                              ));
                        },
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
