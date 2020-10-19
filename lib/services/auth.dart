import 'package:abora/models/user_model.dart';
import 'package:abora/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseSerivce(uId: user.uid).updateUserData('abc', 'a', 'a', 'b');

      return user;
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
