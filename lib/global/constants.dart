import 'package:abora/models/trainer_models/trainer_user.dart';

class Constants {
  static const String changeCard = 'Change Card';
  static const String addNewCard = 'Add New Card';
  static TrainerUser trainerUserData;
  static String currentClientEmail;
  static String currentClientName;
  static const List<String> choices = <String>[
    changeCard,
    addNewCard,
  ];
}
