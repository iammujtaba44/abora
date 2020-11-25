import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/booking/booking_tab.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:abora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThirdPage extends StatelessWidget {
  double height;

  double width;

  Color presidentialBlue = Color(0XFF151B54);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);

    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: CustomColor.backgroundColor,
              expandedHeight: height / 2,
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

  Widget topContainer(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  'Ads',
                  style: TextStyle(
                      color: CustomColor.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
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
                                        left: 12,
                                        right: 12,
                                        top: 20.0,
                                        bottom: 20.0),
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
                                            width: 80.h,
                                            height: 80.h,
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
                                        Text(snapshot.data[index].bio,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            )),
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
                                                                .data[index]
                                                                .bio,
                                                            email: snapshot
                                                                .data[index]
                                                                .email,
                                                            name: snapshot
                                                                .data[index]
                                                                .name)),
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
              'Top Training Companies',
              style: TextStyle(
                  color: CustomColor.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomContainer(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return StreamBuilder(
      stream: database.topTrendingCourseStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: GridView.count(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: .85.h,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  children: List.generate(
                      snapshot.data.length,
                      (index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 170,
                                        width: width,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                'assets/trainer.jpg',
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                        right: 10,
                                        bottom: 10,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color:
                                                  CustomColor.signUpButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            snapshot.data[index].cost,
                                            style: TextStyle(
                                                color: CustomColor.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                        color: CustomColor.white,
                                        fontSize: FontSize.h3FontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    '${snapshot.data[index].courseVideosLink.length} videos',
                                    style: TextStyle(
                                        color: CustomColor.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 13.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                        color: CustomColor.signUpButtonColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Buy Now',
                                      style:
                                          TextStyle(color: CustomColor.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }
}
