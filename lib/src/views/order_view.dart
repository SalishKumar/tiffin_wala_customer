import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/complaint_view.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tiffin_wala_customer/src/views/review_view.dart';

class OrderView extends StatelessWidget {
  static const routeName = '/orderView';

  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    MyAppbar(),
                    Positioned(
                          top: 10,
                          left: 15,
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Consumer<LoginViewModel>(
                    builder: (context, loginViewModel, child) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: 10),
                      child: Column(
                        children: [
                          Details(width: width),
                          SizedBox(
                            height: 20,
                          ),
                          OrderSummary(
                            width: width,
                          ),
                        ],
                      ));
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReviewButton(context: context, width: width),
              ComplaintButton(context: context, width: width)
            ],
          ),
        ),
      ),
    );
  }
}

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images.jpg'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
    );
  }
}

class Details extends StatelessWidget {
  double width;
  Details({
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
                    "Details",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  child: const Text(
                    "Order Number: ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    "123456",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: color.purple,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  child: const Text(
                    "Order from: ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    "Resturant Name",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: color.purple,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // alignment: Alignment.topLeft,
                  width: width * 0.4,
                  child: const Text(
                    "Delivery Address",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    "Address of Delivery",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: color.purple,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
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
                    "PKR 6000/=",
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

class ReviewButton extends StatelessWidget {
  double width;
  BuildContext context;
  ReviewButton({
    Key? key,
    required this.context,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.4,
      height: 60,
      child: InkWell(
        onTap: () {
          if (data.order != 'cancel' && data.order != 'current') {
            Navigator.pushNamed(context, Review.routeName);
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: data.order != 'cancel' && data.order != 'current'
                  ? color.purple
                  : Colors.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.orange, width: 2)),
          child: Center(
            child: Text(
              'Review',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ComplaintButton extends StatelessWidget {
  double width;
  BuildContext context;
  ComplaintButton({
    Key? key,
    required this.context,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.4,
      height: 60,
      child: InkWell(
        onTap: () {
          if (data.order != 'cancel') {
            Navigator.pushNamed(context, Complaint.routeName);
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: data.order != 'cancel' ? color.purple : Colors.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.orange, width: 2)),
          child: Center(
            child: Text(
              'Complaint',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
