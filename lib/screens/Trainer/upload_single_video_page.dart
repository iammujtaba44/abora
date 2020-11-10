import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/mybookings_screen.dart';
import 'package:abora/services/storage.dart';
import 'package:abora/widgets/alert_dialog.dart';

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/loading_widget.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
      home: UploadSingleVideoPage(),
    );
  }
}

class UploadSingleVideoPage extends StatefulWidget {
  @override
  _UploadSingleVideoPageState createState() => _UploadSingleVideoPageState();
}

class _UploadSingleVideoPageState extends State<UploadSingleVideoPage> {
  double height;

  double width;

  var file;

  Storage _storage;

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool showCircularProgressIndicator = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _storage = Provider.of<Storage>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPLOAD VIDEO',
          style: TextStyle(fontSize: FontSize.h3FontSize),
        ),
        leading: Container(),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 40,
            height: 130,
          ),
        ],
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                margin: const EdgeInsets.all(20.0),
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: height / 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: new RichText(
                        text: new TextSpan(
                          style: TextStyle(
                              fontSize: FontSize.h3FontSize,
                              color: CustomColor.red),
                          text: 'Upload videos',
                          children: [],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    rectBorderWidget(context,
                        height: 200, width: double.infinity, func: () async {
                      // ignore: deprecated_member_use
                      file = await ImagePicker.pickVideo(
                          source: ImageSource.gallery);

                      setState(() {});

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PostAdPage()),
                      // );
                    }, file: file, isSingleUpload: true),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mybookings()),
                        );
                      },
                      child: Text(
                        'Title',
                        style: TextStyle(
                            color: CustomColor.red,
                            fontSize: FontSize.h3FontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                        text: 'Type here',
                        curveContainer: true,
                        isPadding: true,
                        controller: titleController),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          color: CustomColor.red,
                          fontSize: FontSize.h3FontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: CustomColor.textFieldFilledColor,
                          border: Border.all(
                              color: CustomColor.textFieldBorderColor)),
                      child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          //Normal textInputField will be displayed
                          maxLines: 5,
                          decoration: InputDecoration(
                            prefixIcon: null,
                            hintText: 'Type here',
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            hintStyle: TextStyle(
                                color: CustomColor.textFieldLabelColor,
                                fontSize: FontSize.h3FontSize - 2),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          )),
                    ),
                  ],
                ),
              ),
              Constants.isLoading
                  ? loadingWidget()
                  : Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
                          child: blueButton(
                            child: Text(
                              'UPLOAD VIDEO',
                              style: TextStyle(color: Colors.white),
                            ),
                            func: () async {
                              setState(() {
                                Constants.isLoading = true;
                              });
                              await _storage.uploadToStorage(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  file: file);
                              setState(() {
                                Constants.isLoading = false;

                                onAlertButtonsPressed(context,
                                    title: 'Video added Successfully !');
                                titleController.text = '';
                                descriptionController.text = '';
                                file = null;
                              });

                              // final user = Provider.of<User>(context, listen: false);
                              // // print('---------${user.uid}');
                              // await DatabaseService(uId: user.uid).uploadVideo(
                              //     title: 'Raheel', description: 'okay2', video: 'http2');
                            }, //_onAlertButtonsPressed(context),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ],
      ),
    );
  }
}
