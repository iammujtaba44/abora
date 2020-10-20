import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../widgets/CustomToast.dart';
import 'database.dart';

class Storage {
  final String uId;

  Storage({this.uId});

  final StorageReference videosRef =
      FirebaseStorage.instance.ref().child('videos/');

  uploadToStorage() async {
    try {
      final file = await ImagePicker.pickVideo(source: ImageSource.gallery);

      print('------------${file.absolute.path.toString()}');

      StorageUploadTask uploadTask =
          videosRef.child(Path.basename(file.path)).putFile(file, StorageMetadata(contentType: 'video/mp4'));
      var storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();

      DatabaseService(uId: uId)
          .uploadVideo(title: 'abc', description: 'des', video: url);
    } catch (e) {
      CustomToast(text: e.toString());
    }
  }
}
