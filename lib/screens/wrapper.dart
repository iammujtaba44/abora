import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
import 'package:abora/screens/authenticate/login_page.dart';
import 'package:abora/services/auth.dart';
import 'package:abora/services/database.dart';
import 'package:abora/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    print(authService.user);

    return StreamBuilder<User>(
      stream: authService.user,
      builder: (context, snapshot) {
        print('${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return MultiProvider(
              providers: [
                Provider<User>.value(
                  value: user,
                ),
                Provider<DatabaseService>(
                  create: (context) => DatabaseService(uId: user.uid),
                ),
                Provider<Storage>(
                  create: (context) => Storage(uId: user.uid),
                )
              ],
              child: BottonNavControllerTrainer(),
            );
          }
          return LoginPage();
        }
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );

    // UserCredentials.userId = user.uid;

    // if (user == null) {
    //   return LoginPage();
    // } else {
    //   return BottonNavControllerTrainer();
    // }
  }
}
