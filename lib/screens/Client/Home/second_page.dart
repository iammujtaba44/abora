import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/SearchPage.dart';
import 'package:abora/screens/Client/booking/booking_tab.dart';
import 'package:abora/screens/Client/trainerProfile.dart';
import 'package:abora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SecondPage extends StatelessWidget {
  final Color presidentialBlue = Color(0XFF151B54);
  double ratings = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);
    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: CustomColor.backgroundColor,
              expandedHeight: height / 2.2,
              leading: Container(),
              flexibleSpace:
                  FlexibleSpaceBar(background: topContainer(context)),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                bottomContainer(context),
              ]),
            )
          ],
        ));
  }

  Future<double> ratingsFunc(String email) async {
    ratings = await DatabaseService().trainerRatings(email);
    print('------------->$ratings');
    if (ratings.isNaN) {
      return 0.0;
    }
    return ratings;
  }

  Column topContainer(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Search trainer, courses',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(
                'Ads',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(
                'View All',
                style: TextStyle(color: CustomColor.blue),
              ),
            )
          ],
        ),
        Expanded(
          flex: 9,
          child: StreamBuilder(
            stream: database.allPostAdStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      margin: EdgeInsets.only(left: 8),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (Constants.clientUserData.area
                              .contains(snapshot.data[index].area)) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 10.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/trainerCube.png',
                                            width: 90.h,
                                            height: 90.h,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: FontSize.h5FontSize),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          width: 120,
                                          child: Text(
                                            snapshot.data[index].bio,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: FlatButton(
                                            color:
                                                CustomColor.signUpButtonColor,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingTab(
                                                          bio: snapshot
                                                              .data[index].bio,
                                                          email: snapshot
                                                              .data[index]
                                                              .email,
                                                          name: snapshot
                                                              .data[index].name,
                                                          session1: snapshot
                                                              .data[index]
                                                              .session1,
                                                          session2: snapshot
                                                              .data[index]
                                                              .session2,
                                                          session3: snapshot
                                                              .data[index]
                                                              .session3,
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              'Book Now',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      FontSize.h5FontSize),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          } else
                            return SizedBox();
                        },
                      ),
                    )
                  : CircularProgressIndicator();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Text(
            'Top Trending Companies',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  StreamBuilder bottomContainer(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return StreamBuilder(
      stream: database.allTrainersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
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
                                      snapshot.data[index].name,
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
                                        snapshot.data[index].bio ?? '',
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
                                          FutureBuilder(
                                              future: ratingsFunc(
                                                  snapshot.data[index].email),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData)
                                                  return CircularProgressIndicator();

                                                return Expanded(
                                                  child: SmoothStarRating(
                                                      allowHalfRating: false,
                                                      onRated: (v) {},
                                                      starCount: 5,
                                                      rating: snapshot.data,
                                                      size: 15.0,
                                                      isReadOnly: true,
                                                      color: Colors.yellow[800],
                                                      borderColor:
                                                          Colors.yellow[800],
                                                      spacing: 0.0),
                                                );
                                              }),
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
                                                                  'bio': snapshot
                                                                      .data[
                                                                          index]
                                                                      .bio,
                                                                  'email': snapshot
                                                                      .data[
                                                                          index]
                                                                      .email,
                                                                  'name': snapshot
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                  'area': snapshot
                                                                      .data[
                                                                          index]
                                                                      .area,
                                                                  'speciality': snapshot
                                                                      .data[
                                                                          index]
                                                                      .speciality,
                                                                  'hometraining':
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .homeTraining,
                                                                  'gymtraining':
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .gymTraining,
                                                                  'parkTraining':
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .parkTraining,
                                                                  'pricepersession':
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .pricePerSession,
                                                                  'paymentmethod':
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .paymentMethod,
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
                                                  color: CustomColor
                                                      .signUpButtonColor,
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
                },
              )
            : CircularProgressIndicator();
      },
    );
  }
}
