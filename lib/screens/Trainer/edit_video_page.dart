import 'dart:io';

import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/appointment.dart';
import 'package:abora/screens/Trainer/post_ad_page.dart';
import 'package:abora/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:abora/widgets/upload_box.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      home: EditSingleVideoPage(),
    );
  }
}

class EditSingleVideoPage extends StatefulWidget {
  final String docId;
  final String title;
  final String description;
  final String videoURL;

  EditSingleVideoPage(
      {this.title, this.description, this.videoURL, this.docId});

  @override
  _EditSingleVideoPageState createState() => _EditSingleVideoPageState();
}

class _EditSingleVideoPageState extends State<EditSingleVideoPage> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool showCircularProgressIndicator = false;

  File file;

  final StorageReference videosRef =
      FirebaseStorage.instance.ref().child('videos');

  double height;

  double width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titleController.text = widget.title;
    descriptionController.text = widget.description;

    videoPlayerController = new VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDIT VIDEO',
          style: TextStyle(
              fontSize: FontSize.h3FontSize, fontWeight: FontWeight.w400),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.red,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 50,
            height: 120,
          ),
        ],
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: Stack(
        children: [
          Container(
              child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    margin: const EdgeInsets.all(20.0),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: height / 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            GestureDetector(
                              onTap: () async {
                                file = await ImagePicker.pickVideo(
                                    source: ImageSource.gallery);

                                setState(() {});
                              },
                              child: Container(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: FontSize.h3FontSize,
                                      color: CustomColor.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        file == null
                            ? rectBorderWidget(context,
                                height: 200,
                                isEditVideo: true,
                                width: double.infinity,
                                videoURL: widget.videoURL,
                                isSingleUpload: true,
                                file: File('abc'), func: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => PostAdPage()),
                                // );
                              })
                            : rectBorderWidget(context,
                                height: 200,
                                width: double.infinity,
                                func: () async {},
                                file: file,
                                isSingleUpload: true),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppointmentPage()),
                                );
                              },
                              child: Container(
                                child: Text(
                                  'Title',
                                  style: TextStyle(
                                      color: CustomColor.red,
                                      fontSize: FontSize.h3FontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: FontSize.h3FontSize,
                                    color: CustomColor.blue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        customTextField(
                            text: 'Enter title here',
                            curveContainer: true,
                            controller: titleController),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  color: CustomColor.red,
                                  fontSize: FontSize.h3FontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: FontSize.h3FontSize,
                                  color: CustomColor.blue),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColor.textFieldFilledColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CustomColor.textFieldBorderColor)),
                          child: TextField(
                              controller: descriptionController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.multiline,
                              minLines: 5,
                              //Normal textInputField will be displayed
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                prefixIcon: null,
                                hintText:
                                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et',
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
                  Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
                        child: blueButton(
                            child: Text(
                              'UPLOAD COURSE',
                              style: TextStyle(color: Colors.white),
                            ),
                            func: () async {
                              setState(() {
                                showCircularProgressIndicator = true;
                              });
                              StorageUploadTask uploadTask = videosRef
                                  .child(Path.basename(file.path))
                                  .putFile(
                                      file,
                                      StorageMetadata(
                                          contentType: 'video/mp4'));
                              var storageTaskSnapshot =
                                  await uploadTask.onComplete;
                              var downloadUrl = await storageTaskSnapshot.ref
                                  .getDownloadURL();
                              final String url = downloadUrl.toString();

                              await database.editVideo(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  docId: widget.docId,
                                  videoURL: url);
                              setState(() {
                                showCircularProgressIndicator = false;
                              });
                              _onAlertButtonsPressed(context);
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
          Center(
            child: showCircularProgressIndicator
                ? CircularProgressIndicator()
                : Container(),
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
      desc: "Video Updated Successful !",
      image: Image.asset('assets/dialog_img.png'),
    ).show();
  }
}
