import 'package:cloud_firestore/cloud_firestore.dart';

class ClientUser {
  final String name;
  final String email;
  final String password;
  final String area;
  final CollectionReference progress;

  ClientUser({this.name, this.email, this.password, this.area, this.progress});
}
