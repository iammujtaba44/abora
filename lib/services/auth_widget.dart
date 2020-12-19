import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/authenticate/login_page.dart';
import 'package:abora/screens/authenticate/multiuser_login_page.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  int typeOfUser;
  bool isLogin, isExistTrainer, isExistClient;
  var snapShotTrainer, snapShotClient;

  final CollectionReference client =
      FirebaseFirestore.instance.collection('client');

  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');

  getUserType() async {
    snapShotClient = await client.doc(widget.userSnapshot.data.uid).get();
    snapShotTrainer = await trainer.doc(widget.userSnapshot.data.uid).get();
    isExistTrainer = snapShotTrainer.exists;
    isExistClient = snapShotClient.exists;
    Constants.currentClientEmail = widget.userSnapshot.data.email;
    Constants.currentClientName = widget.userSnapshot.data.displayName;
    // Constants.currentTrainerEmail = widget.userSnapshot.data.email;
    // Constants.currentTrainerName = widget.userSnapshot.data.displayName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    typeOfUser = prefs.getInt('typeOfUser');
    isLogin = prefs.getBool('isLogin');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    //int value = getUserType();
    if (widget.userSnapshot.connectionState == ConnectionState.active) {
      if (widget.userSnapshot.hasData) {
        if (isLogin == null || !widget.userSnapshot.hasData) {
          return ShimmerList();
        }

        if (isLogin) {
          if (typeOfUser == 0) {
            if (isExistTrainer) {
              return BottonNavControllerTrainer();
            } else {
              customToast(
                  text: 'Sorry Trainer with this email doesn\'t exist!');
              _auth.signOut();
              return MultiuserLoginPage();
            }
          } else {
            if (isExistClient) {
              return BottonNavControllerClient();
            } else {
              customToast(text: 'Sorry client with this email doesn\'t exist!');
              _auth.signOut();
              return MultiuserLoginPage();
            }
          }
        } else {
          return typeOfUser == 0
              ? BottonNavControllerTrainer()
              : BottonNavControllerClient();
        }
      } else {
        return LoginPage();
      }
    }
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(child: Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        offset += 5;
        time = 800 + offset;

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(child: ShimmerLayout(),
              highlightColor: CustomColor.signUpButtonColor,
              baseColor: Colors.grey[300] ,
              period: Duration(milliseconds: time),)
        );
      }),
    ));
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width/1.5;
    double containerHeight = 50;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: containerHeight,
                width: containerWidth,
                color: Colors.grey,),
              SizedBox(height: 5,),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5,),
              Container(
                height: containerHeight,
                width: containerWidth*0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}


