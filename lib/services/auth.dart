import 'package:abora/models/user_model.dart';
import 'package:abora/services/database.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    notifyListeners();
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      User user = result.user;
      notifyListeners();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseSerivce(uId: user.uid)
          .updateUserData(email: email, password: password, name: name);

      return user;
    } catch (e) {
      CustomToast(text: e.toString());
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
