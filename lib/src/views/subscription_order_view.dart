import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/models/order.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;

class SubscriptionOrderView extends StatefulWidget {
  static const routeName = '/subsOrderView';
  Order? order;
  SubscriptionOrderView({Key? key, this.order}) : super(key: key);

  @override
  State<SubscriptionOrderView> createState() => _SubscriptionOrderViewState();
}

class _SubscriptionOrderViewState extends State<SubscriptionOrderView> {
  Database db = Database();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // print("chal");
    return Scaffold(
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _myAppbar(),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
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
                    _details(width, widget.order!),
                    SizedBox(
                      height: 20,
                    ),
                    _orderSummary(width, widget.order!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Container(
          // r
          child: _cancelButton(width),
        ),
      ),
    );
  }

  Widget _myAppbar() {
    // print(endpoint.picBase + widget.order!.logo!);
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

  Widget _details(width, Order order) {
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
                    "Subscription Number: ",
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
          ],
        ),
      ),
    );
  }

  Widget _orderSummary(width, Order order) {
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
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "${order.orders![index].day} - ${order.orders![index].type}",
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
                          "${order.orders![index].quantity} X ${order.orders![index].name}",
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
                              order.orders![index].desc,
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
                              "PKR ${order.orders![index].price * order.orders![index].quantity}/=",
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
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _cancelButton(width) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.7,
      height: 60,
      child: InkWell(
        onTap: () async {
          Map<String, dynamic> map = {};
          if(widget.order!.orderStatus == "Active"){
            map = {
              "subscription_id": widget.order!.id,
              "wanna_activate": false
            };
          }else if(widget.order!.orderStatus == "Not Active"){
            map = {
              "subscription_id": widget.order!.id,
              "wanna_activate": true
            };
          }
          await subscriptionStatus(map);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: widget.order!.orderStatus == "Active"
                  ? Colors.red
                  : color.purple,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.orange, width: 2)),
          child: Center(
            child: Text(
              widget.order!.orderStatus == "Active" ? "De-Activate" : "Activate",
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

  subscriptionStatus(Map<String, dynamic> map) async{
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
          dynamic result = await db.subscriptionStatus(map);
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
  }
}
