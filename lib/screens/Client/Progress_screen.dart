import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/models/progressModel.dart';
import 'package:abora/screens/Client/profileClient_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:abora/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abora/models/ClientModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final CollectionReference client =
      FirebaseFirestore.instance.collection('client');
  List<charts.Series<Sales, int>> _seriesLineData;
  List<charts.Series<Sales, int>> weightLinesData;
  List<charts.Series<Sales, int>> dumbbellWeightLinesData;
  List<charts.Series<Sales, int>> legPressWeightLinesData;
  List<charts.Series<Sales, int>> benchPressWeightLinesData;

  List<Sales> weightlinesalesdata = [];
  List<Sales> dumbbellWeightlinesalesdata = [];
  List<Sales> legPressWeightlinesalesdata = [];
  List<Sales> benchPressWeightlinesalesdata = [];
  List weight = [];
  List dumbbellWeight = [];
  List legPressWeight = [];
  List benchPressWeight = [];

  @override
  void initState() {
    weightLinesData = List<charts.Series<Sales, int>>();
    dumbbellWeightLinesData = List<charts.Series<Sales, int>>();
    legPressWeightLinesData = List<charts.Series<Sales, int>>();
    benchPressWeightLinesData = List<charts.Series<Sales, int>>();
    getData();
    //_generateData();
    super.initState();
  }

  getData() async {
    var document = await client
        .doc(Constants.currentUserID)
        .collection('progress')
        .doc('weight')
        .get();
    weight = List.from(document.data()['list']);

    var document2 = await client
        .doc(Constants.currentUserID)
        .collection('progress')
        .doc('dumbbell')
        .get();
    dumbbellWeight = List.from(document2.data()['list']);

    var document3 = await client
        .doc(Constants.currentUserID)
        .collection('progress')
        .doc('legPress')
        .get();
    legPressWeight = List.from(document3.data()['list']);

    var document4 = await client
        .doc(Constants.currentUserID)
        .collection('progress')
        .doc('benchPress')
        .get();
    benchPressWeight = List.from(document4.data()['list']);

    for (int i = 0; i < dumbbellWeight.length; i++) {
      dumbbellWeightlinesalesdata.add(Sales(i, int.parse(dumbbellWeight[i])));
    }

    for (int i = 0; i < weight.length; i++) {
      weightlinesalesdata.add(Sales(i, int.parse(weight[i])));
    }

    for (int i = 0; i < legPressWeight.length; i++) {
      legPressWeightlinesalesdata.add(Sales(i, int.parse(legPressWeight[i])));
    }

    for (int i = 0; i < benchPressWeight.length; i++) {
      benchPressWeightlinesalesdata
          .add(Sales(i, int.parse(benchPressWeight[i])));
    }

    benchPressWeightLinesData.add(
      charts.Series(
        displayName: 'print the name here',
        // domainFn: (BarChartConfig barchartconfig, _) => barchartconfig.name,
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(CustomColor.signUpButtonColor),
        id: 'benchPressWeight',
        data: benchPressWeightlinesalesdata,

        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    dumbbellWeightLinesData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(CustomColor.signUpButtonColor),
        id: 'dumbbellWeight',
        data: dumbbellWeightlinesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    weightLinesData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(CustomColor.signUpButtonColor),
        id: 'weight',
        data: weightlinesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    legPressWeightLinesData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(CustomColor.signUpButtonColor),
        id: 'legPressweight',
        data: legPressWeightlinesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //final database = Provider.of<DatabaseService>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Progress Session"),
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
              // _topContainer(),
              SizedBox(
                height: 30.0,
              ),
              // _row('Body Weight', ''),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(weightLinesData, 'Body Weight'),
              SizedBox(
                height: 10.0,
              ),
              //_row('Dumbbell Weight', ''),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(dumbbellWeightLinesData, 'Dumbbell Weight'),
              SizedBox(
                height: 10.0,
              ),
              // _row('Leg Press Weight', ''),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(legPressWeightLinesData, 'Leg Press Weight'),
              // _row('Bench Press Weight', ''),
              SizedBox(
                height: 10.0,
              ),
              garphContainer(benchPressWeightLinesData, 'Bench Press Weight'),
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
    return Container(
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
    );
  }

  garphContainer(List linesData, String y_axis) {
    return Container(
      height: 200,
      padding:
          const EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: [
          Expanded(
            child: RotatedBox(
                quarterTurns: -1,
                child: Text(y_axis, style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 15,
            child: Column(
              children: [
                Expanded(
                  child: charts.LineChart(
                    linesData,
                    defaultRenderer: new charts.LineRendererConfig(
                        includeArea: true, stacked: true),
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                  ),
                ),
                Text('No. Sessions', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
