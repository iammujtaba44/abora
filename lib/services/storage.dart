import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../widgets/CustomToast.dart';
import 'database.dart';

class Storage {
  final String uId;
  List<String> videoURLs = List<String>();

  Storage({this.uId});

  final StorageReference videosRef =
      FirebaseStorage.instance.ref().child('videos/');

  Future uploadCourseToStorage(
      {@required List<File> listFile,
      @required String cost,
      @required String title,
      @required String description}) async {
    try {
      for (var file in listFile) {
        StorageUploadTask uploadTask = videosRef
            .child(Path.basename(file.path))
            .putFile(file, StorageMetadata(contentType: 'video/mp4'));
        var storageTaskSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        final String url = downloadUrl.toString();
        videoURLs.add(url);
      }

      DatabaseService(uId: uId).uploadCourseAsync(
          cost: cost,
          courseVideosLink: videoURLs,
          title: title,
          description: description);

      return true;
    } catch (e) {
      return false;
      CustomToast(text: e.toString());
    }
  }

  uploadToStorage() async {
    try {
      final file = await ImagePicker.pickVideo(source: ImageSource.gallery);

      print('------------${file.absolute.path.toString()}');

      StorageUploadTask uploadTask = videosRef
          .child(Path.basename(file.path))
          .putFile(file, StorageMetadata(contentType: 'video/mp4'));
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
