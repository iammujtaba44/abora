import 'package:abora/screens/Client/Home/botton_nav_controller_client.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/login_page.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abora/services/constants.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  int typeOfUser;
  bool isLogin, isExist;
  var snapShot;

  final CollectionReference client =
      FirebaseFirestore.instance.collection('client');

  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');

  getUserType() async {
    snapShot = await trainer.doc(widget.userSnapshot.data.uid).get();
    isExist = snapShot.exists;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    typeOfUser = prefs.getInt('typeOfUser');
    isLogin = prefs.getBool('isLogin');
    print('------------$typeOfUser');
    return typeOfUser;
  }

  checkIfUserExists() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    //int value = getUserType();
    if (widget.userSnapshot.connectionState == ConnectionState.active) {
      return widget.userSnapshot.hasData
          ? isLogin ?? false
              ? typeOfUser == 0
                  ? isExist ?? false
                      ? BottonNavControllerTrainer()
                      : CustomToast(text: 'Mistakenly done!')
                  : BottonNavControllerClient()
              : typeOfUser == 0
                  ? BottonNavControllerTrainer()
                  : BottonNavControllerClient()
          : LoginPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
