import 'package:abora/global/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');

  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(String str) {
    Future<QuerySnapshot> allTrainerUsers =
        trainer.where('name', isGreaterThanOrEqualTo: str).get();
    setState(() {
      futureSearchResults = allTrainerUsers;
    });
  }

  AppBar searchPageHeader() {
    return AppBar(
      backgroundColor: CustomColor.blue,
      title: TextFormField(
        style: TextStyle(fontSize: 18.0, color: CustomColor.white),
        controller: searchTextEditingController,
        decoration: InputDecoration(
            hintText: 'Search here...',
            hintStyle: TextStyle(color: CustomColor.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColor.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColor.white),
            ),
            filled: true,
            prefixIcon:
                Icon(Icons.person_pin, color: CustomColor.white, size: 30.0),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: CustomColor.white,
              ),
              onPressed: emptyTheTextFormField,
            )),
        onFieldSubmitted: controlSearching,
      ),
    );
  }

  Container displayNoSearchResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(
              Icons.group,
              color: CustomColor.grey,
              size: 200,
            ),
            Text("Search Trainers",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 65.0)),
          ],
        ),
      ),
    );
  }

  displayUsersFoundScreen() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: searchPageHeader(),
      body: futureSearchResults == null
          ? displayNoSearchResultScreen()
          : displayUsersFoundScreen,
    );
  }
}
