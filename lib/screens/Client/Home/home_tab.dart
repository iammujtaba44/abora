import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/Home/first_page.dart';
import 'package:abora/screens/Client/Home/second_page.dart';
import 'package:abora/screens/Client/Home/thrid_page.dart';
import 'package:abora/screens/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeTabs(),
    );
  }
}

class HomeTabs extends StatefulWidget {
  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          backgroundColor: CustomColor.backgroundColor,
          appBar: AppBar(
            title: Text('HOME'),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset('assets/logo.png'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: CustomColor.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],

            //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottom: TabBar(
              labelColor: CustomColor.white,
              unselectedLabelColor: CustomColor.grey,
              indicatorColor: CustomColor.white,
              tabs: [
                Tab(
                    child: Text(
                  'One-On-One',
                )),
                Tab(child: Text('Groups')),
                Tab(child: Text('Videos')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FirstPage(),
              SecondPage(),
              ThirdPage(),
            ],
          ),
        ),
      ),
    );
  }
}
