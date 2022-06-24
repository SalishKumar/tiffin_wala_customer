import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/models/order.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/order_view.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class OrderList extends StatefulWidget {
  User1? user;
  OrderList({Key? key, this.user}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool isCurrent = true;
  bool isPast = true;
  bool isCancelled = true;
  bool loading = true;
  Database db = Database();
  List<Order> currentOrders = [];
  List<Order> cancelledOrders = [];
  List<Order> pastOrders = [];

  Future getOrders() async {
    Map<String, dynamic> map = {
      "customer_id": widget.user?.id,
    };
    dynamic result = await db.getOrders(map);
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
        cancelledOrders = [];
        currentOrders = [];
        pastOrders = [];
        var message = result["message"];
        if (message != null) {
          for (var order in message) {
            String status = order["order_status"];
            if (status == "pending" ||
                status == "accepted" ||
                status == "delivery") {
              currentOrders.add(Order.fromJson(order));
            } else if (status == "cancelled") {
              cancelledOrders.add(Order.fromJson(order));
            } else if (status == "delivered") {
              pastOrders.add(Order.fromJson(order));
            }
          }
          print("here");
        }
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
    // loading = false;
    if (cancelledOrders.isEmpty) {
      isCancelled = false;
    }
    if (currentOrders.isEmpty) {
      isCurrent = false;
    }
    if (pastOrders.isEmpty) {
      isPast = false;
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: color.purple,
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: AutoSizeText(
                  "Current Orders",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: AutoSizeText(
                  "Past Orders",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: AutoSizeText(
                  "Cancelled Orders",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: color.background,
        body: loading
            ? Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Color(0xffAEAEAE),
                      highlightColor: Colors.white,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 10.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 10.0,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 10.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        itemCount: 6,
                      ),
                    ),
                  )
                ]))
            : TabBarView(
                children: [
                  isCurrent
                      ? SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05, vertical: 10),
                            child: Consumer<LoginViewModel>(
                                builder: (context, loginViewModel, child) {
                              return Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: currentOrders.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            data.order = '';
                                            data.order = 'current';
                                            print(data.order);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderView(
                                                          order: currentOrders[
                                                              index],
                                                        ))).then((value) {
                                              getOrders();
                                              setState(() {});
                                            });
                                          },
                                          child: orderBox(
                                              width, currentOrders[index]));
                                    }),
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Current Orders Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  isPast
                      ? SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05, vertical: 10),
                            child: Consumer<LoginViewModel>(
                                builder: (context, loginViewModel, child) {
                              return Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: pastOrders.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            data.order = '';
                                            data.order = 'past';
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderView(
                                                          order:
                                                              pastOrders[index],
                                                        ))).then((value) {
                                              getOrders();
                                              setState(() {});
                                            });
                                          },
                                          child: orderBox(
                                              width, pastOrders[index]));
                                    }),
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Past Orders Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  isCancelled
                      ? SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05, vertical: 10),
                            child: Consumer<LoginViewModel>(
                                builder: (context, loginViewModel, child) {
                              return Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cancelledOrders.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            data.order = '';
                                            data.order = 'cancel';
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderView(
                                                          order:
                                                              cancelledOrders[
                                                                  index],
                                                        ))).then((value) {
                                              getOrders();
                                              setState(() {});
                                            });
                                          },
                                          child: orderBox(
                                              width, cancelledOrders[index]));
                                    }),
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Cancelled Orders Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: width*0.05),
        //   child: InkWell(
        //       onTap: () {
        //         Navigator.pushNamed(context, Maps.routeName);
        //       },
        //       child: CustomButton(
        //         width: width,
        //         title: "New Address",
        //       )),
        // ),
      ),
    );
  }

  Widget orderBox(width, Order order) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Center(
                //   child: Image.asset(
                //     "assets/images.jpg",
                //
                //   ),
                // ),
                CachedNetworkImage(
                  imageUrl: endpoint.picBase + order.logo!,
                  width: width * 0.18,
                  height: width * 0.18,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: color.purple,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.35,
                      child: Text(
                        order.kitchenName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: width * 0.35,
                      child: Text(
                        order.orderStatus!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: width * 0.18,
              child: AutoSizeText(
                order.voucherApplied!
                    ? "PKR ${order.discounted}/="
                    : "PKR ${order.totalAmount}/=",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
