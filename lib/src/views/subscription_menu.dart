import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class SubscriptionMenu extends StatefulWidget {
  static const routeName = '/subscription_menu';
  const SubscriptionMenu({Key? key}) : super(key: key);

  @override
  State<SubscriptionMenu> createState() => _SubscriptionMenuState();
}

class _SubscriptionMenuState extends State<SubscriptionMenu> {
  @override
  bool breakfast = false, lunch = false, dinner = false;
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: color.background,
        body: SafeArea(
          child: Column(
            children: [
              Center(
                  child: Stack(
                alignment: Alignment.center,
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
                  Positioned(
                    top: 10,
                    right: 15,
                    child: Container(
                      child: IconButton(
                        icon: Icon(Icons.business_center),
                        onPressed: () {
                          Navigator.pushNamed(context, Cart.routeName);
                        },
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    VendorInfo(
                      width: width,
                    ),

                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: 3,
                    //     itemBuilder: (context, index) {
                    //       return Column(
                    //         children: [
                    //           InkWell(
                    //               onTap: () {
                    //                 Navigator.pushNamed(
                    //                     context, Item.routeName);
                    //               },
                    //               child: MenuItem(
                    //                 width: width,
                    //               )),
                    //           //Divider(color: Colors.black,)
                    //         ],
                    //       );
                    //       //return MenuItem(width: width,);
                    //     }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                child: AppBar(
                  backgroundColor: color.background,
                  bottom: TabBar(
                    onTap: (value) {
                      print(value);
                      breakfast=false;
                                    lunch=false;
                                    dinner=false;
                                    setState(() {
                                      
                                    });
                    },
                    indicatorColor: color.purple,
                    isScrollable: true,
                    labelColor: color.purple,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "Monday",
                      ),
                      Tab(
                        text: "Tuesday",
                      ),
                      Tab(
                        text: "Wednesday",
                      ),
                      Tab(
                        text: "Thursday",
                      ),
                      Tab(
                        text: "Friday",
                      ),
                      Tab(
                        text: "Saturday",
                      ),
                      Tab(
                        text: "Sunday",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20, horizontal: width * 0.05),
                  child: TabBarView(
                    children: [
                      dailyMenu(width),
                      dailyMenu(width),
                      dailyMenu(width),
                      dailyMenu(width),
                      dailyMenu(width),
                      dailyMenu(width),
                      dailyMenu(width),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
        
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Cart.routeName);
              },
              child: CustomButton(
                width: width,
                title: "Go To Cart",
              )),
        ),
      ),
    );
  }

  Widget dailyMenu(width) {
    return SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  print(breakfast);
                                  if(breakfast){
                                    breakfast=false;
                                    lunch=false;
                                    dinner=false;
                                  } else if (breakfast==false){
                                    breakfast=true;
                                    lunch=false;
                                    dinner=false;
                                  }
                                  setState(() {});
                                },
                                child: CustomButton(
                                    width: width * 0.9,
                                    title: "Breakfast")),
                                    breakfast ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, Item.routeName);
                                    showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              controller:
                                                  ModalScrollController.of(
                                                      context),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images.jpg'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      child: AutoSizeText(
                                                        "Lunch Deal 1111111",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          width: width * 0.45,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AutoSizeText(
                                                                "1  X Daal Chanwal Plate",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Shami Kabab",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Salad",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: AutoSizeText(
                                                            "PKR 250/=",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF3a3a3b),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                  child: MenuItem(
                                    width: width,
                                  )),
                              //Divider(color: Colors.black,)
                            ],
                          );
                          //return MenuItem(width: width,);
                        }) : SizedBox(),
                        SizedBox(height: 10,),
                            InkWell(
                                onTap: () {
                                  if(lunch){
                                    breakfast=false;
                                    lunch=false;
                                    dinner=false;
                                  } else if (lunch==false){
                                    breakfast=false;
                                    lunch=true;
                                    dinner=false;
                                  }
                                  setState(() {});
                                },
                                child: CustomButton(
                                    width: width * 0.9, title: "Lunch")),
                                    lunch ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, Item.routeName);
                                    showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              controller:
                                                  ModalScrollController.of(
                                                      context),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images.jpg'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      child: AutoSizeText(
                                                        "Lunch Deal 1111111",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          width: width * 0.45,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AutoSizeText(
                                                                "1  X Daal Chanwal Plate",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Shami Kabab",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Salad",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: AutoSizeText(
                                                            "PKR 250/=",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF3a3a3b),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                  child: MenuItem(
                                    width: width,
                                  )),
                              //Divider(color: Colors.black,)
                            ],
                          );
                          //return MenuItem(width: width,);
                        }) : SizedBox(),
                        SizedBox(height: 10,),
                            InkWell(
                                onTap: () {
                                  if(dinner){
                                    breakfast=false;
                                    lunch=false;
                                    dinner=false;
                                  } else if (dinner==false){
                                    breakfast=false;
                                    lunch=false;
                                    dinner=true;
                                  }
                                  setState(() {});
                                },
                                child: CustomButton(
                                    width: width * 0.9, title: "Dinner")),
                                    dinner ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, Item.routeName);
                                    showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              controller:
                                                  ModalScrollController.of(
                                                      context),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images.jpg'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      child: AutoSizeText(
                                                        "Lunch Deal 1111111",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          width: width * 0.45,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AutoSizeText(
                                                                "1  X Daal Chanwal Plate",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Shami Kabab",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AutoSizeText(
                                                                "1  X Salad",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: AutoSizeText(
                                                            "PKR 250/=",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF3a3a3b),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                  child: MenuItem(
                                    width: width,
                                  )),
                              //Divider(color: Colors.black,)
                            ],
                          );
                          //return MenuItem(width: width,);
                        }) : SizedBox(),
                          ],
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

class VendorInfo extends StatelessWidget {
  double width;
  VendorInfo({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.4,
                  child: AutoSizeText(
                    "ABC Kitchen",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: width * 0.4,
                  child: AutoSizeText(
                    "Featured",
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              width: width * 0.4,
              child: RatingStars(
                value: 3.5,
                onValueChanged: (v) {},
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
                starCount: 5,
                starSize: 20,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MenuItem extends StatelessWidget {
  double width;
  MenuItem({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
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
                  child: AutoSizeText(
                    "Lunch Deal 1111111",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: width * 0.35,
                  child: AutoSizeText(
                    "Single Serving",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ]),
          Container(
            width: width * 0.18,
            child: AutoSizeText(
              "PKR 250/=",
              maxLines: 1,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
