import 'package:abora/services/auth.dart';
import 'package:abora/services/auth_widget.dart';
import 'package:abora/services/auth_widget_builder.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    // Provider<AuthService>(
    //   builder: (_) => AuthService(),
    // ),

    Provider(create: (context) => AuthService()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final primaryColor = const Color(0xFF5190ED);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(builder: (context, userSnapshot) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0XFF00001e),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWidget(userSnapshot: userSnapshot),
      );
    });
  }
}
