import 'package:flutter/material.dart';

import 'package:abora/global/colors.dart';
import 'package:abora/global/height.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
                  _lowerList(),
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
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et',
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
          Expanded(flex: 7, child: SizedBox(
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
          ),),
          SizedBox(width: 10,),
          Expanded(flex: 2, child: SizedBox(
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
          ),),
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
            'Title of Video',
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
    );
  }
}
