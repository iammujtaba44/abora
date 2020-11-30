import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Client/Progress_screen.dart';
import 'package:abora/screens/Client/mybookings_screen.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateSession extends StatefulWidget {
  final trainerData;

  RateSession({@required this.trainerData});
  @override
  _RateSessionState createState() => _RateSessionState();
}

class _RateSessionState extends State<RateSession> {
  TextEditingController loseCtr = TextEditingController(),
      reviewCtr = TextEditingController(),
      benchCtr = TextEditingController(),
      legCtr = TextEditingController(),
      dumbbellCtr = TextEditingController();
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');
  List dataList = List();
  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  double _rateTrainer = 3.0;
  double _rateSession = 3.0;
  @override
  void initState() {
    super.initState();
    // print(widget.trainerData);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);

    ScreenUtil.init(context,
        designSize: Size(640, 1134), allowFontScaling: false);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Rate Session"),
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
            backgroundColor: CustomColor.backgroundColor,
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customtextfieldWithText(
                          controller: loseCtr,
                          text: 'Enter you Current Weight',
                          hintText: '0.00'),
                      customtextfieldWithText(
                          controller: dumbbellCtr,
                          text: 'Enter you current dumbbell weight',
                          hintText: '0.00'),
                      customtextfieldWithText(
                          controller: benchCtr,
                          text: 'Enter your current benchpress weight',
                          hintText: '0.00'),
                      customtextfieldWithText(
                          controller: legCtr,
                          text: 'Enter your current legpress weight',
                          hintText: '0.00'),
                      SizedBox(
                        height: 30.0,
                      ),
                      _ratingWithText('Rate The Session'),
                      SizedBox(
                        height: 30.0,
                      ),
                      _ratingWithText2('Rate The Trainer'),
                      SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Write A Review',
                            style: TextStyle(
                                color: CustomColor.orangeColor, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          _fields()
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: blueButton(
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: TextStyle(color: CustomColor.white),
                      ),
                      func: () {
                        print(_rateSession);
                        print(_rateTrainer);

                        if (loseCtr.text.isNotEmpty &&
                            reviewCtr.text.isNotEmpty &&
                            dumbbellCtr.text.isNotEmpty &&
                            benchCtr.text.isNotEmpty &&
                            legCtr.text.isNotEmpty) {
                          submitReview(database: database);
                          customToast(
                              text:
                                  'Your review has been submitted. Thank You!');
                        } else
                          customToast(text: 'Please fill the fileds');
                      }),
                )
              ]),
            )));
  }

  submitReview({DatabaseService database}) async {
    await database.clientProgressAsync(
        initialWeight: widget.trainerData['initialWeight'],
        endWeight: loseCtr.text,
        initialBenchPressWeight: widget.trainerData['initialbenchpressWeight'],
        endBenchPressWeight: benchCtr.text,
        initialDumbbellWeight: widget.trainerData['initialdeadliftsWeight'],
        endDumbbellWeight: dumbbellCtr.text,
        initialLegPressWeight: widget.trainerData['initiallegpressWeight'],
        endLegPressWeight: legCtr.text);

    await appointments
        .doc('upcomingApointments')
        .collection('data')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        //----------------------- why is there trainerData named varialbe?
        if (element.data()['docId'] == widget.trainerData['docId']) {
          print(element.data());

          await appointments
              .doc('previousApointments')
              .collection('data')
              .doc(widget.trainerData['docId'])
              .set({
            'clientEmail': element.data()['clientEmail'],
            'trainerEmail': element.data()['trainerEmail'],
            'trainerImageUrl': element.data()['trainerImageUrl'],
            'clientImageUrl': element.data()['clientImageUrl'],
            'trainerName': element.data()['trainerName'],
            'clientName': element.data()['clientName'],
            'goal': element.data()['goal'],
            'noOfBookings': element.data()['noOfBookings'],
            'sessionType': element.data()['sessionType'],
            'dates': List.from(element.data()['dates']),
            'docId': widget.trainerData['docId']
          });
        }
      });
    });
    await appointments
        .doc('upcomingApointments')
        .collection('data')
        .doc(widget.trainerData['docId'])
        .delete();
    var querySnapshot = await trainer
        .where('email', isEqualTo: widget.trainerData['email'])
        .get();
    querySnapshot.docs.forEach((result) async {
      var querySnapshot2 =
          await trainer.doc(result.id).collection("reviews").doc().set({
        'imageURL': widget.trainerData['url'],
        'review': reviewCtr.text,
        'reviewerName': Constants.clientUserData.name,
        'sessionRate': _rateSession,
        'trainerRate': _rateTrainer
      });
    });

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => BottonNavControllerClient()));
  }

  _fields() {
    return Container(
      height: 130,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: CustomColor.textFieldFilledColor,
          border:
              Border.all(width: 1, color: CustomColor.textFieldBorderColor)),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.multiline,
        controller: reviewCtr,
        maxLines: null,
        // readOnly: true,
        autofocus: false,
        //    controller: controller == null ? null : controller,
        decoration: InputDecoration(
            hintText: 'Type here',
            hintStyle: TextStyle(
                color: CustomColor.textFieldLabelColor, fontSize: 17.0),
            contentPadding: EdgeInsets.all(20.0),
            border: InputBorder.none),
      ),
    );
  }

  _ratingWithText(String text) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(color: CustomColor.orangeColor, fontSize: 20.0),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: SmoothStarRating(
              rating: 3,
              isReadOnly: false,
              size: 40.0.h,
              color: const Color(0xFFF49900),
              borderColor: const Color(0xFFF49900),
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: true,
              spacing: 20.0,
              onRated: (value) {
                _rateSession = value;
                //print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            ),
          )
        ],
      ),
    );
  }

  _ratingWithText2(String text) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(color: CustomColor.orangeColor, fontSize: 20.0),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: SmoothStarRating(
              rating: 3,
              isReadOnly: false,
              size: 40.0.h,
              color: const Color(0xFFF49900),
              borderColor: const Color(0xFFF49900),
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: true,
              spacing: 20.0,
              onRated: (value) {
                _rateTrainer = value;
                // print("rating value -> $value");
                // print("rating value dd -> ${value.truncate()}");
              },
            ),
          )
        ],
      ),
    );
  }
}
