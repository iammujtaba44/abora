import 'package:abora/services/auth.dart';
import 'package:abora/services/database.dart';
import 'package:abora/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.user,
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final User user = snapshot.data;
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
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
