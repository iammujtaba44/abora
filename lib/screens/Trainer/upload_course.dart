import 'dart:io';

import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/services/storage.dart';
import 'package:abora/widgets/alert_dialog.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
      home: UploadCoursePage(),
    );
  }
}

class UploadCoursePage extends StatefulWidget {
  @override
  _UploadCoursePageState createState() => _UploadCoursePageState();
}

class _UploadCoursePageState extends State<UploadCoursePage> {
  double height;
  double width;

  bool showCircularProgressIndicator = false;

  VideoPlayerController videoPlayerController;
  //Future<void> _initializeVideoPlayerFuture;

  var file, file1, file2, file3, file4, file5;

  List<File> filesList = List<File>();

  TextEditingController courseTitleController,
      costController,
      descriptionController;

  @override
  void initState() {
    super.initState();

    // videoPlayerController = new VideoPlayerController.network(
    //     "https://firebasestorage.googleapis.com/v0/b/abora-42865.appspot.com/o/videos?alt=media&token=1e28571f-84ad-4f3c-b4f2-0feba4628efb");
    // _initializeVideoPlayerFuture =
    //     videoPlayerController.initialize().then((_) => {setState(() {})});

    courseTitleController = TextEditingController();
    costController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    // getting storage provider
    final storage = Provider.of<Storage>(context);

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'UPLOAD COURSE',
          style: TextStyle(fontSize: 15),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.red,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 130,
            height: 130,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: new RichText(
                                        text: new TextSpan(
                                          style: TextStyle(
                                              fontSize: FontSize.h3FontSize,
                                              color: CustomColor.red),
                                          text: 'Upload videos',
                                          children: [
                                            new TextSpan(
                                              style: TextStyle(
                                                  color: CustomColor.grey,
                                                  fontSize: FontSize.h5FontSize,
                                                  fontWeight: FontWeight.w600),
                                              text:
                                                  ' (you can add multiple videos)',
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () =>
                                                        print('Tap Here onTap'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file);
                                          setState(() {});
                                        }, file: file),
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file1 = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file1);
                                          setState(() {});
                                        }, file: file1),
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file2 = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file2);
                                          setState(() {});
                                        }, file: file2),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file3 = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file3);
                                          setState(() {});
                                        }, file: file3),
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file4 = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file4);
                                          setState(() {});
                                        }, file: file4),
                                        rectBorderWidget(context,
                                            imageURL: '',
                                            height: 100,
                                            width: 100, func: () async {
                                          // ignore: deprecated_member_use
                                          file5 = await ImagePicker.pickVideo(
                                              source: ImageSource.gallery);
                                          filesList.add(file5);
                                          setState(() {});
                                        }, file: file5),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Course Title',
                                      style: TextStyle(
                                          color: CustomColor.red,
                                          fontSize: FontSize.h3FontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    customTextField(
                                        text: 'Type here',
                                        controller: courseTitleController),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Cost',
                                      style: TextStyle(
                                          color: CustomColor.red,
                                          fontSize: FontSize.h3FontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    customTextField(
                                        text: '\$49.50',
                                        controller: costController),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                          color: CustomColor.red,
                                          fontSize: FontSize.h3FontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                              CustomColor.textFieldFilledColor,
                                          border: Border.all(
                                              color: CustomColor
                                                  .textFieldBorderColor)),
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
                                            hintStyle: TextStyle(
                                                color: CustomColor
                                                    .textFieldLabelColor,
                                                fontSize:
                                                    FontSize.h3FontSize - 2),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      blueButton(
                          child: Text(
                            'UPLOAD VIDEO',
                            style: TextStyle(color: Colors.white),
                          ),
                          func: () async {
                            setState(() {
                              showCircularProgressIndicator = true;
                            });
                            showCircularProgressIndicator =
                                await storage.uploadCourseToStorage(
                                    listFile: filesList,
                                    cost: costController.text,
                                    description: descriptionController.text,
                                    title: courseTitleController.text);

                            setState(() {
                              showCircularProgressIndicator = false;

                              onAlertButtonsPressed(context,
                                  title: 'Course added Successfully !');
                              filesList.clear();
                              costController.text = '';
                              descriptionController.text = '';
                              courseTitleController.text = '';
                              file = null;
                              file1 = null;
                              file2 = null;
                              file3 = null;
                              file4 = null;
                              file5 = null;
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: showCircularProgressIndicator
                ? CircularProgressIndicator()
                : Container(),
          ),
        ],
      ),
    );
  }
}
