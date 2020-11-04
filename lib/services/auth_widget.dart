import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/login_page.dart';
import 'package:abora/screens/multiuser_login_page.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        if (isLogin ?? false) {
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
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
