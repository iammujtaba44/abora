import 'package:abora/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    notifyListeners();
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future<UserModel> signInAnon() async {
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

  Future<UserModel> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
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
