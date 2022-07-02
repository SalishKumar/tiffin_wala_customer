import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart';
import 'package:tiffin_wala_customer/src/models/order.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;
import 'package:tiffin_wala_customer/src/views/subscription_order_view.dart';

class SubscriptionOrderList extends StatefulWidget {
  User1? user;
  SubscriptionOrderList({Key? key, this.user}) : super(key: key);

  @override
  State<SubscriptionOrderList> createState() => _SubscriptionOrderListState();
}

class _SubscriptionOrderListState extends State<SubscriptionOrderList> {
  bool isActive = true;
  bool isDeactive = true;
  bool loading = true;
  Database db = Database();
  List<Order> active = [];
  List<Order> deactive = [];

  Future getOrders() async {
    Map<String, dynamic> map = {
      "customer_id": widget.user?.id,
    };
    dynamic result = await db.getSubscriptionOrders(map);
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
        active = [];
        deactive = [];
        var message = result["message"];
        if (message != null) {
          for (var order in message) {
            var status = order["is_subscription_active"];
            if (status) {
              active.add(Order.fromJsonSubscription(order));
            } else if (status == false) {
              deactive.add(Order.fromJsonSubscription(order));
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
    if (active.isEmpty) {
      isActive = false;
    }
    if (deactive.isEmpty) {
      isDeactive = false;
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Subscription Orders",
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
                  "Active",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: AutoSizeText(
                  "Non-Active",
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
                  isActive
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
                                    itemCount: active.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubscriptionOrderView(
                                                          order: active[index],
                                                        ))).then((value) {
                                            //   Navigator.pop(context);
                                            //   Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //           builder: (context) =>
                                            //               SubscriptionOrderList(
                                            //                 user: widget.user,
                                            //               )));
                                              getOrders();
                                              setState(() {});
                                            });
                                            
                                          },
                                          child:
                                              orderBox(width, active[index]));
                                    }),
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Active Subsceiption Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  isDeactive
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
                                    itemCount: deactive.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubscriptionOrderView(
                                                          order:
                                                              deactive[index],
                                                        ))).then((value) {
                                              // Navigator.pop(context);
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionOrderList(user: widget.user,)));
                                              getOrders();
                                              setState(() {});
                                            });
                                          },
                                          child:
                                              orderBox(width, deactive[index]));
                                    }),
                              );
                            }),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Non-Active Subscription Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
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
            // Container(
            //   width: width * 0.18,
            //   child: AutoSizeText(
            //     order.voucherApplied!
            //         ? "PKR ${order.discounted}/="
            //         : "PKR ${order.totalAmount}/=",
            //     maxLines: 1,
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
