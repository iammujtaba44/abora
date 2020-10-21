

import 'package:abora/models/UploadVideoModel.dart';
import 'package:abora/models/trainer_models/home_page_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uId;
  var currentTrainerUser;

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




  
  fetchCurrentTrainerData() async{
      currentTrainerUser = await user.doc(uId).get();
  }

  

  TrainerHomePageModel getCurrentTrainerUser(DocumentSnapshot ds)   {
      fetchCurrentTrainerData();
     return TrainerHomePageModel(uId: uId,
     email: currentTrainerUser.data()['email'],
     name: currentTrainerUser.data()['name'],
     booking: currentTrainerUser.data()['booking'],
     conversionRate: currentTrainerUser.data()['conversionRate'],
     password: currentTrainerUser.data()['password'],
      ratio: currentTrainerUser.data()['ratio'],
      thisMonthVisits: currentTrainerUser.data()['thisMonthVisits'],
      totalViews: currentTrainerUser.data()['totalViews'],
      totalSessionsBooked: currentTrainerUser.data()['totalSessionsBooked'],
      totalBookingThisMonth: currentTrainerUser.data()['totalBookingThisMonth'],
      visit: currentTrainerUser.data()['visit'],
     );
  }

  Stream<TrainerHomePageModel> get currentTrainerUserStream {
    return user.doc(uId).snapshots().map(getCurrentTrainerUser);
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
