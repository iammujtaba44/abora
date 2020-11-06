import 'package:abora/global/constants.dart';
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
  final String email;
  var currentTrainerUser;

  DatabaseService({this.uId, this.email});

  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');
  final CollectionReference client =
      FirebaseFirestore.instance.collection('client');

  final CollectionReference topTrendingCourses =
      FirebaseFirestore.instance.collection('topTrendingCourses');

  final CollectionReference allAds =
      FirebaseFirestore.instance.collection('allAds');

  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  // get all Trainer records

  List<TrainerUser> allTrainers(QuerySnapshot qs) {
    return qs.docs.map((ds) {
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
    }).toList();
  }

  Stream<List<TrainerUser>> get allTrainersStream {
    return trainer.snapshots().map(allTrainers);
  }

  // get trainer courses once
  Future<List> onPressed() async {
    List temp = List();
    var querySnapshot = await trainer.where('email', isEqualTo: email).get();
    querySnapshot.docs.forEach((result) async {
      var querySnapshot2 =
          await trainer.doc(result.id).collection("courses").get();

      querySnapshot2.docs.forEach((result) {
        print(result.data());
        temp.add(result.data());
      });
    });

    return temp;
  }
  // Stream<List<Course>> get getTrainerCoursesOnce {
  //   return trainer.where('email', isEqualTo: email).get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       firestoreInstance
  //           .collection("users")
  //           .doc(result.id)
  //           .collection("pets").
  //
  //
  //   // //documents.collection('courses').snapshots().map(uploadCourse);
  //   //
  //   // documents.docs.forEach((doc) {
  //   //   FirebaseFirestore.instance
  //   //       .collection('trainer')
  //   //       .doc(doc.id)
  //   //       .collection('courses')
  //   //       .get()
  //   //       .then((value) {
  //   //     value.docs.map((ds) {
  //   //       return Course(
  //   //           title: ds.data()['title'],
  //   //           description: ds.data()['description'],
  //   //           cost: ds.data()['cost'],
  //   //           courseVideosLink: List.from(ds.data()['courseVideosLink']));
  //   //     }).toList();
  //   //   });
  //   // });
  //   //
  //   // return documents;
  // }

  // update single field

  Future<String> updateSignleField(
      {@required String key, @required String value}) async {
    await trainer.doc(uId).update({key: value});
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
    return trainer.doc(uId).collection('reviews').snapshots().map(review);
  }

  Future reviewAsync(
      {String imageURL, String reviewerName, String review}) async {
    return await trainer.doc(uId).collection('reviews').doc().set(
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
    return trainer.doc(uId).collection('courses').snapshots().map(uploadCourse);
  }

  Stream<List<Course>> get topTrendingCourseStream {
    return topTrendingCourses.snapshots().map(uploadCourse);
  }

  Future uploadCourseAsync(
      {String title,
      String cost,
      String description,
      List<String> courseVideosLink}) async {
    await topTrendingCourses.doc().set({
      'title': title,
      'cost': cost,
      'description': description,
      'courseVideosLink': courseVideosLink
    });
    return await trainer.doc(uId).collection('courses').doc().set({
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
        trainerName: ds.data()['trainerName'],
        trainerImageUrl: ds.data()['trainerImageUrl'],
        trainerEmail: ds.data()['trainerEmail'],
        clientImageUrl: ds.data()['clientImageUrl'],
        clientEmail: ds.data()['clientEmail'],
        clientName: ds.data()['clientName'],
        goal: ds.data()['goal'],
        noOfBookings: ds.data()['noOfBookings'],
        sessionType: ds.data()['sessionType'],
        dates: List.from(ds.data()['dates']),
      );
    }).toList();
  }

  Stream<List<AppointmentModel>> get apintmentStream {
    return appointments.snapshots().map(apointment);
  }

  Future uploadApointmentAsync(
      {String clientEmail,
      String clientName,
      String clientImageUrl,
      String trainerEmail,
      String trainerImageUrl,
      String trainerName,
      String noOfBookings,
      String sessionType,
      String goal,
      List<String> dates}) async {
    return await appointments
        .doc(uId)
        .collection('appointments')
        .doc('upcomingApointments')
        .collection('data')
        .doc()
        .set({
      'clientEmail': clientEmail,
      'trainerEmail': trainerEmail,
      'trainerImageUrl': trainerImageUrl,
      'clientImageUrl': clientImageUrl,
      'trainerName': trainerName,
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
    return trainer
        .doc(uId)
        .collection('uploadVideo')
        .snapshots()
        .map(getVidoeList);
  }

  Future uploadVideo({String title, String description, String video}) async {
    return await trainer
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
    return trainer.doc(uId).snapshots().map(getCurrentTrainerUser);
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

  List<PostAd> allPostAds(QuerySnapshot qs) {
    return qs.docs.map((document) {
      return PostAd(
        email: document.data()['email'],
        name: document.data()['name'],
        bio: document.data()['bio'],
        area: document.data()['area'],
        exerciseType: document.data()['exerciseType'],
        exerciseSubType: document.data()['exerciseSubType'],
        numberOfDay: document.data()['numberOfDay'],
        totalPrice: document.data()['totalPrice'],
        years: document.data()['years'],
      );
    }).toList();
  }

  // ----------STREAMS

  Stream<List<PostAd>> get allPostAdStream {
    return allAds.snapshots().map(allPostAds);
  }

  Stream<PostAd> get postAdStream {
    return trainer.doc(uId).snapshots().map(postAd);
  }

  // -----------ASYNCHRONOUS FUNCTIONS

  Future postAdAsync(
      {String years,
      String exerciseType,
      String exerciseSubType,
      String numberOfDay,
      String area,
      String totalPrice}) async {
    await allAds.doc().set({
      'name': Constants.trainerUserData.name,
      'bio': Constants.trainerUserData.bio ?? '',
      'email': Constants.trainerUserData.email,
      'years': years,
      'exerciseType': exerciseType,
      'exerciseSubType': exerciseSubType,
      'numberOfDay': numberOfDay,
      'area': area,
      'totalPrice': totalPrice
    });
    return await trainer.doc(uId).collection('postAds').doc().set({
      'name': Constants.trainerUserData.name,
      'bio': Constants.trainerUserData.bio ?? '',
      'email': Constants.trainerUserData.email,
      'years': years,
      'exerciseType': exerciseType,
      'exerciseSubType': exerciseSubType,
      'numberOfDay': numberOfDay,
      'area': area,
      'totalPrice': totalPrice
    });
  }

  PostAd allPostAd(DocumentSnapshot ds) {
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

  // Trainer
  Future trainerUserData({String email, String name, String password}) async {
    return await trainer
        .doc(uId)
        .set({'email': email, 'name': name, 'password': password});
  }

  // Client
  Future clientUserData({String email, String name, String password}) async {
    return await client
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
    return await trainer.doc(uId).update({
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
