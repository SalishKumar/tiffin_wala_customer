import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/models/order.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/complain_timeline.dart';
import 'package:tiffin_wala_customer/src/views/complaint_view.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;
import 'package:tiffin_wala_customer/src/views/review_view.dart';

class OrderView extends StatefulWidget {
  static const routeName = '/orderView';
  Order? order;
  OrderView({Key? key, this.order}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool cancel = true;
  Database db = Database();

  @override
  void initState() {
    DateTime now = DateTime.now();
    final difference = now.difference(widget.order!.orderTime!).inMinutes;
    print(difference);
    if (difference > 5) {
      cancel = false;
    }
    super.initState();
  }

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
                    myAppbar(),
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
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
                  child: Column(
                    children: [
                      details(width, widget.order!),
                      SizedBox(
                        height: 20,
                      ),
                      orderSummary(width, widget.order!),
                    ],
                  ),
                ),
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
              reviewButton(width),
              complainButton(width),
              cancelButton(width),
            ],
          ),
        ),
      ),
    );
  }

  Widget myAppbar() {
    return CachedNetworkImage(
      imageUrl: endpoint.picBase + widget.order!.logo!,
      width: double.infinity,
      height: 200,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
      ),
      placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
        color: color.purple,
      )),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget details(width, Order order) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  child: const Text(
                    "Order Number: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    "${order.id}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
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
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    order.kitchenName!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // alignment: Alignment.topLeft,
                  width: width * 0.4,
                  child: const Text(
                    "Delivery Address",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Text(
                    order.address!.address!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
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
                    "Ratings: ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                widget.order!.isRated! == false
                    ? Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Not Rated",
                          style: TextStyle(
                            color: color.purple,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: RatingStars(
                            value: widget.order!.rating!,
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 16,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 1.5,
                            maxValueVisibility: true,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget orderSummary(width, Order order) {
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
                itemCount: order.orders!.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${order.orders![index].quantity} X ${order.orders![index].name}",
                          style: TextStyle(
                              fontSize: 16,
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
                              "${order.orders![index].desc}",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              "PKR ${order.orders![index].quantity * order.orders![index].price}/=",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            if (order.voucherApplied!)
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
                        fontSize: 14,
                        // color: color.purple,
                        // decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    AutoSizeText(
                      "${order.voucher!.code}",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: color.purple,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
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
                        fontSize: 16,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.4,
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    order.voucherApplied!
                        ? "PKR ${order.discounted}/="
                        : "PKR ${order.totalAmount}/=",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
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

  Widget reviewButton(width) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.28,
      height: 60,
      child: InkWell(
        onTap: () {
          if (data.order != 'cancel' &&
              data.order != 'current' &&
              widget.order!.isRated == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Review(
                          id: widget.order!.id,
                        ))).then((value) {
              widget.order!.rating = data.rating;
              data.rating = 0.0;
              if(widget.order!.rating != 0.0){
                widget.order!.isRated = true;
              }
              setState(() {});
            });
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: data.order != 'cancel' &&
                      data.order != 'current' &&
                      widget.order!.isRated == false
                  ? color.purple
                  : Colors.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.orange, width: 2)),
          child: Center(
            child: Text(
              'Review',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget complainButton(width) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.28,
      height: 60,
      child: InkWell(
        onTap: () {
          if (data.order != 'cancel') {
            if (widget.order!.complain != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComplainTimeline(
                            complain: widget.order!.complain!,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComplainView(
                            id: widget.order!.id,
                          ))).then((value) {
                widget.order!.complain = data.complain;
                data.complain = null;
              });
            }
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
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton(width) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.28,
      height: 60,
      child: InkWell(
        onTap: () async {
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
          Map<String, dynamic> map = {};
          map = {
            "customer_id": widget.order!.customerID,
            "seller_id": widget.order!.sellerID,
            "order_id": widget.order!.id
          };
          dynamic result = await db.cancelOrders(map);
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
              Navigator.pop(context);
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
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: data.order == 'current' && cancel == true
                  ? color.purple
                  : Colors.grey,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.orange, width: 2)),
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
