import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/apointmentModel.dart';
import 'package:abora/models/trainer_models/course.dart';
import 'package:abora/models/trainer_models/post_ad.dart';
import 'package:abora/models/trainer_models/reviews.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uId;
  var currentTrainerUser;

  DatabaseService({this.uId});

  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  // update single field

  Future<String> updateSignleField(
      {@required String key, @required String value}) async {
    await user.doc(uId).update({key: value});
    return value;
  }

  //---- NOTE: Struction is like this:
  // Model function
  // Stream
  // Async Function

  // RREVIEWS

  List<Review> review(QuerySnapshot qs) {
    return qs.docs.map((ds) {
      return Review(
        imageURL: ds.data()['imageURL'],
        reviewerName: ds.data()['reviewerName'],
        reivew: ds.data()['review'],
      );
    }).toList();
  }

  Stream<List<Review>> get reviewStream {
    return user.doc(uId).collection('reviews').snapshots().map(review);
  }

  Future reviewAsync(
      {String imageURL, String reviewerName, String review}) async {
    return await user.doc(uId).collection('reviews').doc().set(
        {'imageURL': imageURL, 'reviewerName': reviewerName, 'review': review});
  }

  // COURSES

  List<Course> uploadCourse(QuerySnapshot qs) {
    return qs.docs.map((ds) {
      return Course(
          title: ds.data()['title'],
          description: ds.data()['description'],
          cost: ds.data()['cost'],
          courseVideosLink: List.from(ds.data()['courseVideosLink']));
    }).toList();
  }

  Stream<List<Course>> get courseStream {
    return user.doc(uId).collection('courses').snapshots().map(uploadCourse);
  }

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

//Apointment
  List<AppointmentModel> apointment(QuerySnapshot qs) {
    return qs.docs.map((ds) {
      return AppointmentModel(
        imageUrl: ds.data()['imageUrl'],
        clientName: ds.data()['clientName'],
        goal: ds.data()['goal'],
        noOfBookings: ds.data()['noOfBookings'],
        sessionType: ds.data()['sessionType'],
        dates: List.from(ds.data()['dates']),
      );
    }).toList();
  }

  Stream<List<AppointmentModel>> get apintmentStream {
    return user
        .doc(uId)
        .collection('appointments')
        .doc('upcomingApointments')
        .collection('data')
        .snapshots()
        .map(apointment);
  }

  Future uploadApointmentAsync(
      {String imageUrl,
      String clientName,
      String noOfBookings,
      String sessionType,
      String goal,
      List<String> dates}) async {
    return await user
        .doc(uId)
        .collection('appointments')
        .doc('upcomingApointments')
        .collection('data')
        .doc()
        .set({
      'imageUrl': imageUrl,
      'clientName': clientName,
      'goal': goal,
      'noOfBookings': noOfBookings,
      'sessionType': sessionType,
      'dates': dates,
    });
  }
  // SINGLE VIDEO

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

  TrainerUser getCurrentTrainerUser(DocumentSnapshot ds) {
    return TrainerUser(
      uId: uId,
      bio: ds.data()['bio'],
      area: ds.data()['area'],
      speciality: ds.data()['speciality'],
      homeTraining: ds.data()['homeTraining'],
      gymTraining: ds.data()['gymTraining'],
      pricePerSession: ds.data()['pricePerSession'],
      paymentMethod: ds.data()['paymentMethod'],
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

  Stream<TrainerUser> get currentTrainerUserStream {
    return user.doc(uId).snapshots().map(getCurrentTrainerUser);
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

  Stream<PostAd> get postAdStream {
    return user.doc(uId).snapshots().map(postAd);
  }

  // -----------ASYNCHRONOUS FUNCTIONS

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
