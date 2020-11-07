import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:abora/global/colors.dart';
import 'package:abora/global/height.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final videoData;
  VideoPage({@required this.videoData});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  void initState() {
    super.initState();

    videoPlayerController =
        new VideoPlayerController.network(widget.videoData['videoUrl']);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerContainer(),
            _bodyContainer(),
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Related Videos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  WrapperRow(
                    data: widget.videoData['data'],
                  ),
                  //_lowerList(),
                  SizedBox(
                    height: 50.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _bodyContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _row(),
          SizedBox(
            height: 15.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            child: Text(
              widget.videoData['desc'],
              style: TextStyle(color: CustomColor.grey.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          _buttonRow(),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  _lowerList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return Stack(
            children: [
              Container(
                width: getwidth(context) * 0.55,
                height: 130,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                margin: const EdgeInsets.only(right: 20.0),
              ),
              Positioned(
                bottom: 10,
                right: 30,
                child: SizedBox(
                  width: 70,
                  height: 30,
                  child: RaisedButton(
                    color: CustomColor.signUpButtonColor,
                    onPressed: () {},
                    child: Text(
                      'View',
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  _buttonRow() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
              width: 250,
              height: 50,
              child: RaisedButton(
                color: CustomColor.signUpButtonColor,
                onPressed: () {},
                child: Text(
                  'Bay the Video',
                  style: TextStyle(color: CustomColor.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: 60,
              height: 50,
              child: RaisedButton(
                  color: CustomColor.green,
                  onPressed: () {},
                  child: Icon(
                    Icons.favorite_border,
                    size: 30.0,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  _row() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.videoData['title'],
            //'Title of Video',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                color: Colors.white),
          ),
          Text('£2.50',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  color: CustomColor.orangeColor))
        ],
      ),
    );
  }

  _headerContainer() {
    return Container(
      width: getwidth(context),
      height: getheight(context) * 0.4,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0))),
      child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Chewie(
                key: PageStorageKey(widget.videoData['videoUrl']),
                controller: ChewieController(
                    videoPlayerController: videoPlayerController,
                    aspectRatio: 1.3,
                    autoInitialize: true,
                    showControls: true,
                    looping: false,
                    autoPlay: false,
                    showControlsOnInitialize: true,
                    allowFullScreen: false,
                    errorBuilder: (context, errorMessage) {
                      return Center(
                          child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.white),
                      ));
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class WrapperRow extends StatefulWidget {
  final List data;

  WrapperRow({this.data});
  @override
  _WrapperRowState createState() => _WrapperRowState();
}

class _WrapperRowState extends State<WrapperRow> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final videos = Provider.of<List<UploadVideo>>(context) ?? [];

    return Container(
      // / alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: CustomColor.backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      width: getwidth(context),
      height: 130,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            key: PageStorageKey('keydata$index'),
            child: Row(
              children: [
                VideoWidget(
                  play: true,
                  videoURL: widget.data[index]['video'],
                  title: widget.data[index]['title'],
                  desc: widget.data[index]['description'],
                  alldata: widget.data,
                ),
                SizedBox(
                  width: 8,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String videoURL;
  final String title;
  final String desc;
  final List alldata;

  VideoWidget({this.play, this.videoURL, this.title, this.desc, this.alldata});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // print("------------");
    // print(widget.alldata);
    videoPlayerController = new VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                // width: getwidth(context) * 0.55,
                // height: 130,
                width: 130,
                height: 100,
                child: Stack(
                  children: [
                    Chewie(
                      key: PageStorageKey(widget.videoURL),
                      controller: ChewieController(
                          videoPlayerController: videoPlayerController,
                          aspectRatio: 1.35,
                          autoInitialize: true,
                          showControls: false,
                          looping: false,
                          autoPlay: false,
                          errorBuilder: (context, errorMessage) {
                            return Center(
                                child: Text(
                              errorMessage,
                              style: TextStyle(color: Colors.white),
                            ));
                          }),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPage(
                                        videoData: {
                                          'videoUrl': widget.videoURL,
                                          'title': widget.title,
                                          'desc': widget.desc,
                                          'data': widget.alldata
                                        },
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              color: CustomColor.signUpButtonColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'view',
                            style: TextStyle(color: CustomColor.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
