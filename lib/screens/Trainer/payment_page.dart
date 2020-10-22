import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/profile_page.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview/preview.dart';

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
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double height;
  double width;
  bool checkTick = false;

  void choiceAction(String choice) {
    if (choice == Constants.changeCard) {
      print('changeCard');
    } else if (choice == Constants.addNewCard) {
      print('addNewCard');
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'PAYMENT',
          style: TextStyle(fontSize: 15),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: CustomColor.red,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              color: Theme.of(context).primaryColor,
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    textStyle: TextStyle(color: CustomColor.white),
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                  color: CustomColor.red,
                                  fontSize: FontSize.h3FontSize),
                            ),
                            Text('\$20.00',
                                style: TextStyle(
                                    color: CustomColor.blue,
                                    fontSize: FontSize.h2FontSize - 5)),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Card Number',
                      style: TextStyle(color: CustomColor.red),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: customTextField(
                              isPadding: true,
                              text: '1234 5678 4325 3245',
                              curveContainer: true,
                              edgeInsets: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: CustomColor.textFieldFilledColor,
                                border: Border.all(
                                  color: CustomColor.textFieldBorderColor,
                                )),
                            child: Image.asset('assets/visa.png'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Cardholder Name',
                      style: TextStyle(color: CustomColor.red),
                    ),
                    SizedBox(height: 4),
                    customTextField(
                        isPadding: true,
                        text: 'John Doe',
                        curveContainer: true,
                        edgeInsets: EdgeInsets.only(left: 10)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry Date',
                                style: TextStyle(color: CustomColor.red),
                              ),
                              customTextField(
                                  isPadding: true,
                                  text: '05 / 21',
                                  curveContainer: true,
                                  edgeInsets: EdgeInsets.only(left: 10)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CVV',
                                style: TextStyle(color: CustomColor.red),
                              ),
                              customTextField(
                                  isPadding: true,
                                  text: '123',
                                  curveContainer: true,
                                  edgeInsets: EdgeInsets.only(left: 10)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.red),
                          child: Checkbox(
                            value: checkTick,
                            onChanged: (value) {
                              setState(() {
                                checkTick = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Save Card',
                          style: TextStyle(color: CustomColor.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
            child: blueButton(
              child: Text(
                'PAY',
                style: TextStyle(color: Colors.white),
              ),
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
      context: context,
      buttons: [],
      title: '',
      desc: "Payment Successful !",
      image: Image.asset('assets/dialog_img.png'),
    ).show();
  }
}

class IPhone5 extends PreviewProvider {
  @override
  String get title => 'iPhone 5';

  @override
  List<Preview> get previews => [
        Preview(
          key: Key('preview'),
          frame: Frames.iphone5,
          child: MyApp(),
        ),
      ];
}

class IPhoneX extends PreviewProvider {
  @override
  String get title => 'Iphone X';

  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.iphoneX,
          child: MyApp(),
        ),
      ];
}

class IPad extends PreviewProvider {
  @override
  String get title => 'Iphone X';

  @override
  List<Preview> get previews => [
        Preview(
          frame: Frames.ipadPro12,
          child: MyApp(),
        ),
      ];
}
