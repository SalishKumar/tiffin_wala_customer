import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/addresses.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/menu.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class PaymentAndAddress extends StatelessWidget {
  static const routeName = '/paymentAndAddress';

  const PaymentAndAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    AddressBox(
                      width: width,
                      context: context,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PaymentBox(
                      width: width,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OrderSummary(width: width),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05),
        child: InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
            },
            child: CustomButton(
              width: width,
              title: "Place Order",
            )),
      ),
      
    );
  }
}

class AddressBox extends StatelessWidget {
  double width;
  BuildContext context;
  AddressBox({
    Key? key,
    required this.width,
    required this.context,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: color.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "Delivery Address",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Addresses.routeName);
                  },
                  child: Icon(
                    Icons.edit,
                    color: color.purple,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                "A12, ABC street, some area",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                "Karachi",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentBox extends StatelessWidget {
  double width;
  PaymentBox({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: color.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "Payment Method",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.edit,
                  color: color.purple,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                        child: Image.asset(
                      "assets/cash.png",
                      width: 60,
                      height: 60,
                    )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "Cash",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  double width;
  OrderSummary({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.summarize,
                  color: color.purple,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: width * 0.45,
                  child: AutoSizeText(
                    "Order Summary",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "2 X Lunch",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "1  X Daal Chanwal Plate",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      AutoSizeText(
                        "1  X Shami Kabab",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      AutoSizeText(
                        "1  X Salad",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.4,
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    "PKR 500/=",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    "PKR 500/=",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
