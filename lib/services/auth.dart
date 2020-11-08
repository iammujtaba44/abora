import 'package:abora/global/constants.dart';
import 'package:abora/models/user_model.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(
      String email, String password, int index) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // Passing the index of the kind of user that is trying to register.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('typeOfUser', index);
      prefs.setBool('isLogin', true);
      Constants.isLoading = false;
      return user;
    } catch (error) {
      Constants.isLoading = false;
      customToast(text: error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required String name,
      @required int index}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // Passing the index of the kind of user that is trying to register.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('typeOfUser', index);
      prefs.setBool('isLogin', false);

      if (index == 0) {
        await DatabaseService(uId: user.uid)
            .trainerUserData(email: email, password: password, name: name);
      } else if (index == 1) {
        await DatabaseService(uId: user.uid)
            .clientUserData(email: email, password: password, name: name);
      }
      Constants.isLoading = false;
      return user;
    } catch (e) {
      Constants.isLoading = false;
      customToast(text: e.toString());
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      customToast(text: e.toString());
      return null;
    }
  }
}
