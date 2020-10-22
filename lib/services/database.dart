import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/course.dart';
import 'package:abora/models/trainer_models/post_ad.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uId;
  var currentTrainerUser;

  DatabaseService({this.uId});

  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  // ----------MODEL FUNCTIONS
  List<UploadVideo> getVidoeList(QuerySnapshot qs) {
    return qs.docs.map((e) {
      return UploadVideo(
          title: e.data()['title'],
          description: e.data()['description'],
          video: e.data()['video']);
    }).toList();
  }

  TrainerUser getCurrentTrainerUser(DocumentSnapshot ds) {
    return TrainerUser(
      uId: uId,
      email: ds.data()['email'],
      name: ds.data()['name'],
      booking: ds.data()['booking'],
      conversionRate: ds.data()['conversionRate'],
      password: ds.data()['password'],
      ratio: ds.data()['ratio'],
      thisMonthVisits: ds.data()['thisMonthVisits'],
      totalViews: ds.data()['totalViews'],
      totalSessionsBooked: ds.data()['totalSessionsBooked'],
      totalBookingThisMonth: ds.data()['totalBookingThisMonth'],
      visit: ds.data()['visit'],
    );
  }

  Course uploadCourse(DocumentSnapshot ds) {
    return Course(
        title: ds.data()['title'],
        description: ds.data()['description'],
        cost: ds.data()['cost'],
        courseVideosLink: ds.data()['courseVideosLink']);
  }

  PostAd postAd(DocumentSnapshot ds) {
    return PostAd(
      area: ds.data()['area'],
      exerciseType: ds.data()['exerciseType'],
      exerciseSubType: ds.data()['exerciseSubType'],
      numberOfDay: ds.data()['numberOfDay'],
      totalPrice: ds.data()['totalPrice'],
      years: ds.data()['years'],
    );
  }

  // ----------STREAMS

  Stream<TrainerUser> get currentTrainerUserStream {
    return user.doc(uId).snapshots().map(getCurrentTrainerUser);
  }

  Stream<List<UploadVideo>> get uploadVideoStream {
    return user
        .doc(uId)
        .collection('uploadVideo')
        .snapshots()
        .map(getVidoeList);
  }

  Stream<Course> get courseStream {
    return user.doc(uId).snapshots().map(uploadCourse);
  }

  Stream<PostAd> get postAdStream {
    return user.doc(uId).snapshots().map(postAd);
  }

  // -----------ASYNCHRONOUS FUNCTIONS

  Future uploadCourseAsync(
      {String title,
      String cost,
      String description,
      List<String> courseVideosLink}) async {
    return await user.doc(uId).collection('courses').doc().set({
      'title': title,
      'cost': cost,
      'description': description,
      'courseVideosLink': courseVideosLink
    });
  }

  Future postAdAsync(
      {String years,
      String exerciseType,
      String exerciseSubType,
      String numberOfDay,
      String area,
      String totalPrice}) async {
    return await user.doc(uId).collection('postAds').doc().set({
      'years': years,
      'exerciseType': exerciseType,
      'exerciseSubType': exerciseSubType,
      'numberOfDay': numberOfDay,
      'area': area,
      'totalPrice': totalPrice
    });
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

  Future updateTrainerHomeData(
      {String totalViews,
      String thisMonthVisits,
      String totalSessionsBooked,
      String totalBookingThisMonth,
      String booking,
      String visit,
      String ratio,
      String conversionRate}) async {
    return await user.doc(uId).update({
      'totalViews': totalViews,
      'thisMonthVisits': thisMonthVisits,
      'totalSessionsBooked': totalSessionsBooked,
      'totalBookingThisMonth': totalBookingThisMonth,
      'booking': booking,
      'visit': visit,
      'ratio': ratio,
      'conversionRate': conversionRate,
    });
  }
}
