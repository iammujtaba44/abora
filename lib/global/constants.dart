import 'package:abora/models/ClientModel.dart';
import 'package:abora/models/trainer_models/trainer_user.dart';

class Constants {
  static const String changeCard = 'Change Card';
  static const String addNewCard = 'Add New Card';
  static const String
  course = 'Courses';
  static const String timings = 'Timings';
  static TrainerUser trainerUserData;
  static String currentClientEmail;
  static String currentClientName;
  static ClientUser clientUserData;
  static bool isLoading = false;
  static List<String> bulkSessions = [];
  static List<String> timingsList = [];
  static const List<String> choices = <String>[
    changeCard,
    addNewCard,
  ];
  static const List<String> courses = <String>[course, timings];
  static String currentUserID;
}
