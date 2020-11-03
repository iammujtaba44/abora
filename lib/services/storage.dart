import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import '../widgets/CustomToast.dart';
import 'database.dart';

class Storage {
  final String uId;
  List<String> videoURLs = List<String>();

  Storage({this.uId});

  final StorageReference videosRef =
      FirebaseStorage.instance.ref().child('videos');

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
      customToast(text: e.toString());
      return false;
    }
  }

  uploadToStorage(
      {@required String title,
      @required String description,
      @required File file}) async {
    try {
      //  print('------------${file.absolute.path.toString()}');

      StorageUploadTask uploadTask = videosRef
          .child(Path.basename(file.path))
          .putFile(file, StorageMetadata(contentType: 'video/mp4'));
      var storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();

      DatabaseService(uId: uId)
          .uploadVideo(title: title, description: description, video: url);
    } catch (e) {
      customToast(text: e.toString());
    }
  }
}
