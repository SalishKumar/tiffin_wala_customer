import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
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
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class PaymentAndAddress extends StatefulWidget {
  static const routeName = '/paymentAndAddress';
  User1? user;
  int? vendorID;
  double? total, total1;
  String? code;
  List<Item1>? cart;
  // DateTime? start, end;
  bool? subs;
  bool? voucherApplied;

  PaymentAndAddress(
      {Key? key,
      this.cart,
      this.code,
      this.total,
      this.total1,
      this.user,
      this.vendorID,
      this.voucherApplied,
      // this.end,
      // this.start,
      this.subs})
      : super(key: key);

  @override
  State<PaymentAndAddress> createState() => _PaymentAndAddressState();
}

class _PaymentAndAddressState extends State<PaymentAndAddress> {
  int chosenAddress = 0;
  Database db = Database();

  @override
  void initState() {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Checkout Screen');
    super.initState();
  }

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
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                addressBox(
                    width,
                    context,
                    widget.user!.address.isEmpty
                        ? null
                        : widget.user!.address[chosenAddress]),
                SizedBox(
                  height: 20,
                ),
                PaymentBox(
                  width: width,
                ),
                if (widget.subs!)
                  SizedBox(
                    height: 20,
                  ),
                orderSummary(width, widget.cart, widget.total, widget.total1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () async {
              
              if (widget.subs!) {
                if (widget.cart != null &&
                    widget.user != null &&
                    widget.vendorID != null &&
                    widget.user!.address.isNotEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: color.purple,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Loading"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  List<Map<String, dynamic>> mappedCart = [];
                  for (var item in widget.cart!) {
                    mappedCart.add({
                      "dish_id": item.id,
                      "dish_name": item.name,
                      "quantity": item.quantity,
                      "day": item.day.toLowerCase(),
                      "type": item.type
                    });
                  }
                  Map<String, dynamic> map = {};
                  map = {
                      "customer_id": widget.user!.id,
                      "seller_id": widget.vendorID,
                      "address_id": widget.user!.address[chosenAddress].id,
                      
                    };
                  
                  map["cart"] = mappedCart;
                  dynamic result = await db.postSubscriptionOrder(map);
                  Navigator.pop(context);
                  if (result != null) {
                    if (result['Timeout'] == 'true') {
                      Fluttertoast.showToast(
                          msg: 'Your request has been timmed-out. Try again.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (result["status"]) {
                      Fluttertoast.showToast(
                          msg: result["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Home.routeName, (route) => false);
                    } else if (result["status"] == false) {
                      Fluttertoast.showToast(
                          msg: result["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                } else if (widget.user!.address.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Enter Address first.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              } else if(widget.subs == false) {
                if (widget.cart != null &&
                    widget.user != null &&
                    widget.vendorID != null &&
                    widget.user!.address.isNotEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: color.purple,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Loading"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  List<Map<String, dynamic>> mappedCart = [];
                  for (var item in widget.cart!) {
                    mappedCart.add({
                      "dish_id": item.id,
                      "quantity": item.quantity,
                      "dish_name": item.name,
                      "price_per_unit": item.price,
                      "total_amount": item.price * item.quantity
                    });
                  }
                  Map<String, dynamic> map = {};
                  if (widget.voucherApplied!) {
                    map = {
                      "customer_id": widget.user!.id,
                      "seller_id": widget.vendorID,
                      "address_id": widget.user!.address[chosenAddress].id,
                      "cart_size": widget.cart!.length,
                      "amount": widget.total,
                      "type": widget.cart![0].type,
                      "coupon_code": widget.code,
                      "discounted_amount": widget.total1
                    };
                  } else {
                    map = {
                      "customer_id": widget.user!.id,
                      "seller_id": widget.vendorID,
                      "address_id": widget.user!.address[chosenAddress].id,
                      "cart_size": widget.cart!.length,
                      "amount": widget.total,
                      "type": widget.cart![0].type
                    };
                  }
                  map["cart"] = mappedCart;
                  dynamic result = await db.postOrder(map);
                  Navigator.pop(context);
                  if (result != null) {
                    if (result['Timeout'] == 'true') {
                      Fluttertoast.showToast(
                          msg: 'Your request has been timmed-out. Try again.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (result["status"]) {
                      Fluttertoast.showToast(
                          msg: result["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Home.routeName, (route) => false);
                    } else if (result["status"] == false) {
                      Fluttertoast.showToast(
                          msg: result["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                } else if (widget.user!.address.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Enter Address first.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            },
            child: CustomButton(
              width: width,
              title: "Place Order",
            )),
      ),
    );
  }

  Widget addressBox(width, context, Address? address) {
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    data.addressDirect = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Addresses(
                                  chosenAddress: chosenAddress,
                                ))).then((value) {
                      chosenAddress = data.chosenAddress;
                      data.addressDirect = true;
                      print(chosenAddress);
                      setState(() {});
                    });
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
                address != null ? address.address! : "Provide Address",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                address != null ? "Karachi" : "",
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

  // Widget datesBox(width) {
  //   return Card(
  //     elevation: 5,
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Icon(
  //                     Icons.location_city,
  //                     color: color.purple,
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Container(
  //                     width: width * 0.45,
  //                     child: AutoSizeText(
  //                       "Dates of Subscription",
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Column(
  //                 children: [
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "Start Date",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "${widget.start!.day}-${widget.start!.month}-${widget.start!.year}",
  //                     style: TextStyle(fontSize: 18, color: color.purple),
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 children: [
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "End Date",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "${widget.end!.day}-${widget.end!.month}-${widget.end!.year}",
  //                     style: TextStyle(fontSize: 18, color: color.purple),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget orderSummary(width, List<Item1>? cart, total, total1) {
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cart!.length,
                itemBuilder: (context, index) {
                  return widget.subs!
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "${cart[index].day} - ${cart[index].type}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              child: Text(
                                "${cart[index].quantity} X ${cart[index].name}",
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
                                  child: AutoSizeText(
                                    "${cart[index].desc}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "PKR ${cart[index].price*cart[index].quantity}/=",
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
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${cart[index].quantity} X ${cart[index].name}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.bold),
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
                                  child: AutoSizeText(
                                    "${cart[index].desc}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "PKR ${cart[index].price*cart[index].quantity}/=",
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
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                }),
            if (widget.voucherApplied! && widget.subs == false)
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      "Voucher Applied: ",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        // color: color.purple,
                        // decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    AutoSizeText(
                      "${widget.code}",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: color.purple,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              if (widget.subs! == false)
            Divider(
              color: Colors.black,
            ),
            if (widget.subs! == false)
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
                    "PKR $total1/=",
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
                      fontSize: 20,
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
                          fontSize: 18,
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
