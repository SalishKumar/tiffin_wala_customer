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
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/order_view.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class OrderList extends StatelessWidget {
  static const routeName = '/orderList';

  const OrderList({Key? key}) : super(key: key);

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
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: 10),
                child: Consumer<LoginViewModel>(
                    builder: (context, loginViewModel, child) {
                  return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                data.order = '';
                                data.order = 'current';
                                print(data.order);
                                Navigator.pushNamed(
                                    context, OrderView.routeName);
                              },
                              child: OrderBox(
                                width: width,
                                context: context,
                                x: index,
                              ));
                        }),
                  );
                }),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: 10),
                child: Consumer<LoginViewModel>(
                    builder: (context, loginViewModel, child) {
                  return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                data.order = '';
                                data.order = 'past';
                                Navigator.pushNamed(
                                    context, OrderView.routeName);
                              },
                              child: OrderBox(
                                width: width,
                                context: context,
                                x: index,
                              ));
                        }),
                  );
                }),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: 10),
                child: Consumer<LoginViewModel>(
                    builder: (context, loginViewModel, child) {
                  return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                data.order = '';
                                data.order = 'cancel';
                                Navigator.pushNamed(
                                    context, OrderView.routeName);
                              },
                              child: OrderBox(
                                width: width,
                                context: context,
                                x: index,
                              ));
                        }),
                  );
                }),
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
}

class OrderBox extends StatelessWidget {
  double width;
  BuildContext context;
  int x;
  OrderBox(
      {Key? key, required this.width, required this.context, required this.x})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images.jpg",
                    width: width * 0.18,
                    height: width * 0.18,
                  ),
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
                        "Order # $x",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
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
                        "Discription",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
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
                "PKR 250/=",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
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
