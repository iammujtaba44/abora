import 'package:abora/models/UploadVideoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uId;

  DatabaseService({this.uId});

  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  List<UploadVideo> getVidoeList(QuerySnapshot qs) {
    return qs.docs.map((e) {
      return UploadVideo(
          title: e.data()['title'],
          description: e.data()['description'],
          video: e.data()['video']);
    }).toList();
  }

  Stream<List<UploadVideo>> get uploadVideoStream {
    return user
        .doc(uId)
        .collection('uploadVideo')
        .snapshots()
        .map(getVidoeList);
  }

  Future uploadVideo({String title, String description, String video}) async {
    return await user
        .doc(uId)
        .collection('uploadVideo')
        .doc()
        .set({'title': title, 'description': description, 'video': video});
  }

  Future updateUserData({String email, String name, String password}) async {
    return await user
        .doc(uId)
        .set({'email': email, 'name': name, 'password': password});
  }
}
