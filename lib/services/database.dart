import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSerivce {
  final String uId;

  DatabaseSerivce({this.uId});

  final CollectionReference signup =
      FirebaseFirestore.instance.collection('signup');

  Future updateUserData(
      {String email,
      String name,
      String password}) async {
    return await signup.doc(uId).set({
      'email': email,
      'name': name,
      'password': password
    });
  }
}
