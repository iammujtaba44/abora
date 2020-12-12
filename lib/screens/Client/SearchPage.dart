import 'package:abora/global/colors.dart';
import 'package:abora/screens/Client/trainerProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CollectionReference trainer =
      FirebaseFirestore.instance.collection('trainer');

  TextEditingController searchTextEditingController = TextEditingController();
  String searchValue = "";
  Future<QuerySnapshot> futureSearchResults;

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  // controlSearching(String str) {
  //   Future<QuerySnapshot> allTrainerUsers =
  //       trainer.where('name', isGreaterThanOrEqualTo: str).get();
  //   setState(() {
  //     futureSearchResults = allTrainerUsers;
  //   });
  // }

  AppBar searchPageHeader() {
    return AppBar(
      backgroundColor: CustomColor.blue,
      title: TextFormField(
        onChanged: (val) {
          setState(() {
            searchValue = val;
          });
        },
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
        //onFieldSubmitted: controlSearching,
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
    return StreamBuilder<QuerySnapshot>(
      stream: (searchValue == null || searchValue.trim() == '')
          ? trainer.snapshots()
          : trainer.where('name', isEqualTo: searchValue).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('We got an error ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.none:
            return Text('Oops no data present!');

          case ConnectionState.done:
            return Text('We are done!');

          default:
            return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      margin: const EdgeInsets.all(14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/trainer.png',
                                height: 70,
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document['name'] ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    document['bio'] ?? '',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Container(
                                  width: 350.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            onRated: (v) {},
                                            starCount: 5,
                                            rating: 3,
                                            size: 15.0,
                                            isReadOnly: true,
                                            color: Colors.yellow[800],
                                            borderColor: Colors.yellow[800],
                                            spacing: 0.0),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TrainerProfilePage(
                                                            trainerData: {
                                                              'bio': document[
                                                                  'bio'],
                                                              'email': document[
                                                                  'email'],
                                                              'name': document[
                                                                  'name'],
                                                              'area': document[
                                                                  'area'],
                                                              'speciality':
                                                                  document[
                                                                      'speciality'],
                                                              'hometraining':
                                                                  document[
                                                                      'homeTraining'],
                                                              'gymtraining':
                                                                  document[
                                                                      'gymTraining'],
                                                              'parkTraining':
                                                                  document[
                                                                      'parkTraining'],
                                                              'pricepersession':
                                                                  document[
                                                                      'pricePerSession'],
                                                              'paymentmethod':
                                                                  document[
                                                                      'paymentMethod'],
                                                            },
                                                          )),
                                                );
                                              },
                                              child: Text(
                                                'View Profile',
                                                style: TextStyle(
                                                    color: CustomColor
                                                        .signUpButtonColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                              color:
                                                  CustomColor.signUpButtonColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            }).toList());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: searchPageHeader(),
      body: searchValue == ""
          ? displayNoSearchResultScreen()
          : displayUsersFoundScreen(),
    );
  }
}
