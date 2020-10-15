import 'package:abora/global/colors.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Client/booking/booking_tab.dart';
import 'package:abora/screens/Trainer/upload_course.dart';
import 'package:abora/trainer.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class  ThirdPage extends StatelessWidget {

  double height;

  double width;

  final List<Trainer> trainers = [
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
    Trainer(
        name: 'Garaham Cracker',
        desc: 'Gym Trainer from last 7 years',
        rating: 5),
  ];

  Color presidentialBlue = Color(0XFF151B54);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(640, 1136 ), allowFontScaling: false);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: Container(
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
                      style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    child: Text('View All', style: TextStyle(color: CustomColor.blue),),
                  )
                ],),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: trainers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: Container(
                              padding:
                              EdgeInsets.only(left: 12, right: 12, top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/trainerCube.png', width: 80.h, height: 80.h,),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Graham Cracker',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.h5FontSize),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      'Lorem ipsum dolor sit \n        amet, consetur',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: FlatButton(
                                      color: CustomColor.signUpButtonColor,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookingTab()),
                                        );
                                      },
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(color: Colors.white, fontSize: FontSize.h5FontSize),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  'Top Training Companies',
                  style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 5,
                    children: List.generate(
                        8,
                            (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadCoursePage()),
                            );
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 130.h,
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
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
                                          color: CustomColor.signUpButtonColor,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Text(
                                        '\$49.50',
                                        style: TextStyle(color: CustomColor.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                'Course Title',
                                style: TextStyle(
                                    color: CustomColor.red,
                                    fontSize: FontSize.h3FontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '20 videos',
                                style: TextStyle(
                                    color: CustomColor.grey,
                                    fontWeight: FontWeight.w500),
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
                                  style: TextStyle(color: CustomColor.white),
                                ),
                              ),

                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
