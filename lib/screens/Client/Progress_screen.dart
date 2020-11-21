import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/profileClient_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<charts.Series<Sales, int>> _seriesLineData;
  _generateData() {
    var linesalesdata = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Rate Session"),
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
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topContainer(),
              SizedBox(
                height: 30.0,
              ),
              _row('Day 1', 'On Track'),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(),
              SizedBox(
                height: 10.0,
              ),
              _row('Day 2', 'On Track'),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(),
              SizedBox(
                height: 10.0,
              ),
              _row('Day 3', 'On Track'),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(),
            ],
          ),
        ),
      ),
    ));
  }

  _row(String text, String text2) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Colors.white)),
          Text(text2, style: TextStyle(color: CustomColor.blue)),
        ],
      ),
    );
  }

  _topContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileClientPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Goal',
              style: TextStyle(color: CustomColor.orangeColor),
            ),
            Text('Loss 10 kgs in 5 days',
                style: TextStyle(color: CustomColor.grey))
          ],
        ),
      ),
    );
  }

  garphContainer() {
    return Container(
      height: 200,
      padding:
          const EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: charts.LineChart(
        _seriesLineData,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: true,
        animationDuration: Duration(seconds: 5),
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
