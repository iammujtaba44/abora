import 'package:abora/global/colors.dart';
import 'package:abora/global/height.dart';
import 'package:abora/screens/Client/rateSession_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _tapedindex = 0;
  List<String> _list = <String>['Today', 'Fitness', 'Health', 'Nutrition'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("NEWS"),
        leading: Container(),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/logo.png',
            width: 50,
            height: 130,
          ),
        ],
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Topics',
                style: TextStyle(color: CustomColor.white, fontSize: 18),
              ),
              SizedBox(
                height: 20.0,
              ),
              _topSlider(),
              SizedBox(
                height: 30.0,
              ),
              _lowerSlider(),
              SizedBox(
                height: 30.0,
              ),
              _lowerList()
            ],
          ),
        ),
      ),
    ));
  }

  _lowerList() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RateSession()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    Container(
                      width: getwidth(context),
                      height: getheight(context) * 0.17,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    Positioned(
                        child: Container(
                      width: 100,
                      height: getheight(context) * 0.17,
                      decoration: BoxDecoration(
                          color: CustomColor.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0))),
                    )),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_sharp,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        )),
                    Positioned(
                      top: 10.0,
                      left: 100.0,
                      child: Container(
                        width: getwidth(context) * 0.7,
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50.0),
                              child: Text(
                                "Lorem Ipsum Dolor Sit Amet, Consetetur .",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 40.0),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 5,
                        bottom: 10,
                        child: Text(
                          '5 min ago',
                          style: TextStyle(
                              color: CustomColor.green,
                              fontWeight: FontWeight.w300),
                        ))
                  ],
                ),
              ),
            );
          }),
        ));
  }

  _lowerSlider() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_list.length, (index) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _tapedindex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(right: 20.0),
                  // width: getwidth(context) * 0.18,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                  // height: getheight(context) * 0.036,
                  decoration: BoxDecoration(
                      color: _tapedindex == index
                          ? const Color(0xFF126AFC)
                          : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Text(
                    _list[index],
                    style: TextStyle(
                        color: _tapedindex == index
                            ? Colors.white
                            : CustomColor.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                width: 12.0,
              )
            ],
          );
        }),
      ),
    );
  }

  _topSlider() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: getwidth(context) * 0.83,
                    height: getheight(context) * 0.28,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_sharp,
                          color: Colors.white,
                        ),
                      )),
                  Positioned(
                    top: 100.0,
                    child: Container(
                      width: getwidth(context) * 0.7,
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lorem Ipsum Dolor Sit Amet, Consetetur .",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '5 min ago',
                            style: TextStyle(
                                color: CustomColor.green,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
