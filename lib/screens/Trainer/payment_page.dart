import 'package:abora/global/colors.dart';
import 'package:abora/global/constants.dart';
import 'package:abora/global/fontSize.dart';
import 'package:abora/screens/Trainer/botton_nav_controller_trainer.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:async';


class PaymentPage extends StatefulWidget {
  final postAdData;

  const PaymentPage({Key key, this.postAdData}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
    getPrefs();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsCardNumber = prefs.getString('cardNumber');
    final prefsCardHolderName = prefs.getString('CardHolderName');
    final prefsExpiryDate = prefs.getString('Expiry Date');
    final prefsCvv = prefs.getString('cvv');
    final prefsCheckTick = prefs.getBool('checkTick');

    if (prefsCardNumber != null) {
      cardNumberCtr.text = prefs.getString('cardNumber');
    }
    if (prefsCardHolderName != null) {
      cardHolderNameCtr.text = prefs.getString('CardHolderName');
    }
    if (prefsExpiryDate != null) {
      expiryDateCtr.text = prefs.getString('Expiry Date');
    }
    if (prefsCvv != null) {
      cvvCodeCtr.text = prefs.getString("cvv");
    }
    if (prefsCheckTick != null) {
      checkTick = prefs.getBool('checkTick');
    } else {
      checkTick = false;
    }
    setState(() {});
  }

  saveCard(
      {String expiryDate,
      String cardHolderName,
      String cardNumber,
      String cvvCode,
      bool checkTick}) async {
    final prefs = await SharedPreferences.getInstance();
    if (checkTick) {
      await prefs.setString('cardNumber', cardNumber);
      await prefs.setString('CardHolderName', cardHolderName);
      await prefs.setString('Expiry Date', expiryDate);
      await prefs.setString('cvv', cvvCode);
      await prefs.setBool('checkTick', checkTick);
    } else {
      await prefs.remove('cardNumber');
      await prefs.remove('CardHolderName');
      await prefs.remove('Expiry Date');
      await prefs.remove('cvv');
      await prefs.setBool('checkTick', checkTick);
    }
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: CustomColor.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        // actions: [
        //   PopupMenuButton<String>(
        //       color: Theme.of(context).primaryColor,
        //       onSelected: choiceAction,
        //       itemBuilder: (BuildContext context) {
        //         return Constants.choices.map((String choice) {
        //           return PopupMenuItem<String>(
        //             textStyle: TextStyle(color: CustomColor.white),
        //             value: choice,
        //             child: Text(choice),
        //           );
        //         }).toList();
        //       })
        // ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                                      color: CustomColor.white,
                                      fontSize: FontSize.h3FontSize),
                                ),
                                Text('\$${widget.postAdData['totalPrice']}',
                                    style: TextStyle(
                                        color: CustomColor.blue,
                                        fontSize: FontSize.h2FontSize - 5)),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Card Number',
                          style: TextStyle(color: CustomColor.white),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: customTextField(
                                  fieldFormate: true,
                                  keyboardType: true,
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
                                          brandIcon =
                                              FontAwesomeIcons.ccMastercard;
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
                          style: TextStyle(color: CustomColor.white),
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
                                    style: TextStyle(color: CustomColor.white),
                                  ),
                                  customTextField(
                                      onChanged: (value) {


                                        setState(() {
                                          value = value.replaceAll(RegExp(r"\D"), "");
                                          switch(value.length) {
                                            case 0:
                                              expiryDateCtr.text = "MM/YY";
                                              expiryDateCtr.selection =
                                                  TextSelection.collapsed(
                                                    offset: 0
                                                  );
                                              expiryDate = expiryDateCtr.text;
                                              break;
                                            case 1:
                                              expiryDateCtr.text = "${value}M/YY";
                                              expiryDateCtr.selection = TextSelection.collapsed(
                                                offset: 1);
                                              expiryDate = expiryDateCtr.text;
                                              break;
                                            case 2:
                                              expiryDateCtr.text = "$value/YY";
                                              expiryDateCtr.selection =
                                                  TextSelection.collapsed(
                                                    offset: 2);
                                              expiryDate = expiryDateCtr.text;
                                              break;
                                            case 3:
                                              expiryDateCtr.text =
                                              "${value.substring(0, 2)}/${value.substring(2)}Y";
                                              expiryDateCtr.selection =
                                                  TextSelection.collapsed(
                                                    offset: 4);
                                              expiryDate = expiryDateCtr.text;
                                              break;

                                            case 4:
                                              expiryDateCtr.text =
                                              "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                              expiryDateCtr.selection =
                                                  TextSelection.collapsed(
                                                    offset: 5);
                                              expiryDate = expiryDateCtr.text;
                                              break;

                                          }
                                          if (value.length > 4) {
                                            expiryDateCtr.text =
                                            "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                            expiryDateCtr.selection =
                                                TextSelection.collapsed(
                                                  offset: 5);
                                            expiryDate = expiryDateCtr.text;
                                          }
                                        });
                                      },
                                      controller: expiryDateCtr,
                                      isPadding: true,
                                      text: 'MM/YY',
                                      keyboardType: true,
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
                                    style: TextStyle(color: CustomColor.white),
                                  ),
                                  customTextField(
                                      fieldFormate: true,
                                      keyboardType: true,
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
                              data: ThemeData(
                                  unselectedWidgetColor: CustomColor.white),
                              child: Checkbox(
                                value: checkTick,
                                onChanged: (value) {
                                  setState(() {
                                    checkTick = value;
                                    saveCard(
                                        cardHolderName: cardHolderNameCtr.text,
                                        cardNumber: cardNumberCtr.text,
                                        checkTick: checkTick,
                                        cvvCode: cvvCodeCtr.text,
                                        expiryDate: expiryDateCtr.text);
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onpressed() {
    // if (cardNumber != null &&
    //     expiryDate != null &&
    //     cardHolderName != null &&
    //     cvvCode != null) {
    //   var month = expiryDate[0];
    //   month += expiryDate[1];
    //   var year = expiryDate[2];
    //   year += expiryDate[3];
    //   payViaExistingCard2(context, month, year, cardNumber);
    // } else
    //   customToast(text: 'Please fill the fileds');

    if (!expiryDate.contains('/')) {
      customToast(text: 'Please fill expiry with /');
    } else {
      if (cardNumber != '' &&
          expiryDate != '' &&
          cardHolderName != '' &&
          cvvCode != '') {
        var exDate = expiryDate.split('/');
        payViaExistingCard2(context, exDate[0], exDate[1], cardNumber);
      } else
        customToast(text: 'Please fill the fileds');
    }
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
      _onAlertButtonsPressed(context);

      database.postAdAsync(
          numberOfDay: widget.postAdData['days'],
          exerciseSubType: widget.postAdData['ex'],
          exerciseType: widget.postAdData['ex1'],
          totalPrice: widget.postAdData['totalPrice'],
          years: widget.postAdData['years'],
          area: widget.postAdData['postCode']);
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

    Timer.periodic(new Duration(seconds: 2), (timer) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottonNavControllerTrainer(),
          ));

      timer.cancel();
    });
  }


}
