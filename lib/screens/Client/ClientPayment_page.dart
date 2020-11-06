import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/services/database.dart';
import 'package:abora/services/paymentService.dart';
import 'package:abora/widgets/CustomToast.dart';
import 'package:abora/widgets/blue_button.dart';
import 'package:abora/widgets/dialog_box/alert.dart';
import 'package:abora/widgets/dialog_box/alert_style.dart';
import 'package:abora/widgets/textfield_widget.dart';
import 'package:credit_card_validate/credit_card_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ClientPaymentPage extends StatefulWidget {
  final addAp;
  const ClientPaymentPage({Key key, this.addAp}) : super(key: key);

  @override
  _ClientPaymentPageState createState() => _ClientPaymentPageState();
}

class _ClientPaymentPageState extends State<ClientPaymentPage> {
  double height;
  double width;
  bool checkTick = false;
  IconData brandIcon;

  void choiceAction(String choice) {
    if (choice == Constants.changeCard) {
      print('changeCard');
    } else if (choice == Constants.addNewCard) {
      print('addNewCard');
    }
  }

  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Muhammad Ahsan Ayaz',
      'cvvCode': '424',
      'showBackView': false,
    },
  ];
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  DatabaseService database;
  TextEditingController cardNumberCtr,
      expiryDateCtr,
      cardHolderNameCtr,
      cvvCodeCtr;
  @override
  void initState() {
    super.initState();
    brandIcon = FontAwesomeIcons.ccVisa;
    cardNumberCtr = TextEditingController();
    expiryDateCtr = TextEditingController();
    cardHolderNameCtr = TextEditingController();
    cvvCodeCtr = TextEditingController();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        designSize: Size(640, 1136), allowFontScaling: false);
    database = Provider.of<DatabaseService>(context);
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'PAYMENT',
          style: TextStyle(fontSize: 15),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: CustomColor.red,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              color: Theme.of(context).primaryColor,
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    textStyle: TextStyle(color: CustomColor.white),
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreditCardWidget(
                      cardBgColor: CustomColor.textFieldFilledColor,
                      width: width,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                  color: CustomColor.red,
                                  fontSize: FontSize.h3FontSize),
                            ),
                            Text('\$${widget.addAp['totalPrice']}',
                                style: TextStyle(
                                    color: CustomColor.blue,
                                    fontSize: FontSize.h2FontSize - 5)),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Card Number',
                      style: TextStyle(color: CustomColor.red),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: customTextField(
                              onChanged: (value) {
                                setState(() {
                                  cardNumber = value;
                                  String brand =
                                      CreditCardValidator.identifyCardBrand(
                                          value);
                                  if (brand != null) {
                                    if (brand == 'visa')
                                      brandIcon = FontAwesomeIcons.ccVisa;
                                    else if (brand == 'master_card')
                                      brandIcon = FontAwesomeIcons.ccMastercard;
                                  }
                                });
                              },
                              controller: cardNumberCtr,
                              isPadding: true,
                              text: '1234 5678 4325 3245',
                              curveContainer: true,
                              edgeInsets: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            width: 65.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: CustomColor.textFieldFilledColor,
                                border: Border.all(
                                  color: CustomColor.textFieldBorderColor,
                                )),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: FaIcon(
                                brandIcon,
                                size: 45.0,
                                color: Colors.white38,
                              ),
                            ) //Image.asset('assets/visa.png'),
                            )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Cardholder Name',
                      style: TextStyle(color: CustomColor.red),
                    ),
                    SizedBox(height: 4),
                    customTextField(
                        onChanged: (value) {
                          setState(() {
                            isCvvFocused = true;
                            cardHolderName = value;
                          });
                        },
                        controller: cardHolderNameCtr,
                        isPadding: true,
                        text: 'John Doe',
                        curveContainer: true,
                        edgeInsets: EdgeInsets.only(left: 10)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry Date',
                                style: TextStyle(color: CustomColor.red),
                              ),
                              customTextField(
                                  onChanged: (value) {
                                    setState(() {
                                      expiryDate = value;
                                    });
                                  },
                                  controller: expiryDateCtr,
                                  isPadding: true,
                                  text: '05 / 21',
                                  curveContainer: true,
                                  edgeInsets: EdgeInsets.only(left: 10)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CVV',
                                style: TextStyle(color: CustomColor.red),
                              ),
                              customTextField(
                                  onChanged: (value) {
                                    setState(() {
                                      cvvCode = value;
                                    });
                                  },
                                  controller: cvvCodeCtr,
                                  isPadding: true,
                                  text: '123',
                                  curveContainer: true,
                                  edgeInsets: EdgeInsets.only(left: 10)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.red),
                          child: Checkbox(
                            value: checkTick,
                            onChanged: (value) {
                              setState(() {
                                checkTick = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Save Card',
                          style: TextStyle(color: CustomColor.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
            child: blueButton(
              child: Text(
                'PAY',
                style: TextStyle(color: Colors.white),
              ),
              func: () {
                _onpressed();
              },
              // func: () {
              //   database.postAdAsync(
              //       numberOfDay: widget.postAdData['days'],
              //       exerciseSubType: widget.postAdData['ex'],
              //       exerciseType: widget.postAdData['ex1'],
              //       totalPrice: widget.postAdData['totalPrice'],
              //       years: widget.postAdData['years']);
              //   // print(widget.postAdData['years']);
              //
              //   //  payViaExistingCard(context, cards[0]);
              //   // Navigator.push(
              //   //   context,
              //   //   MaterialPageRoute(builder: (context) => ProfilePage()),
              //   // );
              // },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _onpressed() {
    if (cardNumber != null &&
        expiryDate != null &&
        cardHolderName != null &&
        cvvCode != null) {
      var month = expiryDate[0];
      month += expiryDate[1];
      var year = expiryDate[2];
      year += expiryDate[3];
      payViaExistingCard2(context, month, year, cardNumber);
    } else
      customToast(text: 'Please fill the fileds');
  }

  payViaExistingCard2(BuildContext context, month, year, cardNumber) async {
    // print(cardNumber);
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    // var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
        number: cardNumber,
        expMonth: int.parse(month),
        expYear: int.parse(year));
    var response = await StripeService.payViaExistingCard(
        amount: "30000", //widget.postAdData['totalPrice'],
        currency: 'USD',
        card: stripeCard);
    await dialog.hide();
    // CustomToast(text: response.message);

    //  print(response.message);
    if (response.success == true) {
      List<String> dates = widget.addAp['dates'];
      _onAlertButtonsPressed(context);
      database.uploadApointmentAsync(
          clientEmail: widget.addAp['clientEmail'],
          clientImageUrl: widget.addAp['clientImageUrl'],
          clientName: widget.addAp['clientName'],
          dates: dates,
          goal: widget.addAp['goal'],
          noOfBookings: widget.addAp['noOfBookings'].toString(),
          sessionType: widget.addAp['sessionType'],
          trainerEmail: widget.addAp['trainerEmail'],
          trainerImageUrl: widget.addAp['trainerImageUrl'],
          trainerName: widget.addAp['trainerName']);
    } else {
      customToast(text: response.message);
    }
  }

  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: '25000', currency: 'USD', card: stripeCard);
    await dialog.hide();
    customToast(text: response.message);

    _onAlertButtonsPressed(context);
    print(response.message);
    // Scaffold.of(context)
    //     .showSnackBar(SnackBar(
    //       content: Text(response.message),
    //       duration: new Duration(milliseconds: 1200),
    //     ))
    //     .closed
    //     .then((_) {
    //   //Navigator.pop(context);
    // });
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(backgroundColor: Theme.of(context).primaryColor),
      context: context,
      buttons: [],
      title: '',
      desc: "Payment Successful !",
      image: Image.asset('assets/dialog_img.png'),
    ).show();
  }
}