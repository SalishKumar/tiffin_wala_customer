import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/models/chefs.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;

class Menu extends StatefulWidget {
  static const routeName = '/menu';
  Chef? chef;
  User1? user;
  int? vendorID;

  Menu({Key? key, this.chef, this.user, this.vendorID}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool onetimeAvailable = false;
  int total = 0;

  @override
  void initState() {
    if (widget.chef!.menu.oneTime.length != 0) {
      onetimeAvailable = true;
    }
    total = 0;
                  for (Item1 i in widget.chef!.menu.oneTime) {
                    total += i.quantity;
                  }
    setState(() {});
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
                Center(
                    child: Stack(
                  alignment: Alignment.center,
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
                    Positioned(
                      top: 10,
                      right: 15,
                      child: cartWithCounter(),
                    ),
                  ],
                )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: 10),
                  child: Column(
                    children: [
                      vendorInfo(
                        width,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      onetimeAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: Center(
                                  child: Text(
                                "No Menu Available",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.chef!.menu.oneTime.length,
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
                                                StatefulBuilder(builder:
                                                    (context, setState) {
                                              return SingleChildScrollView(
                                                controller:
                                                    ModalScrollController.of(
                                                        context),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                          child:
                                                              CachedNetworkImage(
                                                        imageUrl: endpoint
                                                                .picBase +
                                                            widget.chef!.logo!,
                                                        width: double.infinity,
                                                        height: 200,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        width: width * 0.45,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                top: 10),
                                                        child: AutoSizeText(
                                                          widget
                                                              .chef!
                                                              .menu
                                                              .oneTime[index]
                                                              .name,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 18,
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
                                                                    vertical:
                                                                        10),
                                                            width: width * 0.45,
                                                            child: AutoSizeText(
                                                              widget
                                                                  .chef!
                                                                  .menu
                                                                  .oneTime[
                                                                      index]
                                                                  .desc,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width * 0.45,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: AutoSizeText(
                                                              widget
                                                                  .chef!
                                                                  .menu
                                                                  .oneTime[
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: 35,
                                                                height: 35,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: color
                                                                        .purple,
                                                                    border: Border.all(
                                                                        color: color
                                                                            .orange,
                                                                        width:
                                                                            2)),
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (widget
                                                                              .chef!
                                                                              .menu
                                                                              .oneTime[index]
                                                                              .quantity >
                                                                          0) {
                                                                        widget
                                                                            .chef!
                                                                            .menu
                                                                            .oneTime[index]
                                                                            .quantity--;
                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .remove),
                                                                    color: Colors
                                                                        .white,
                                                                    iconSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                width: 100.0,
                                                                height: 35.0,
                                                                child: Center(
                                                                  child: Text(
                                                                    widget
                                                                        .chef!
                                                                        .menu
                                                                        .oneTime[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: new TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: color
                                                                        .purple,
                                                                    border: Border.all(
                                                                        color: color
                                                                            .orange,
                                                                        width:
                                                                            2)),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                width: 35,
                                                                height: 35,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: color
                                                                        .purple,
                                                                    border: Border.all(
                                                                        color: color
                                                                            .orange,
                                                                        width:
                                                                            2)),
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      widget
                                                                          .chef!
                                                                          .menu
                                                                          .oneTime[
                                                                              index]
                                                                          .quantity++;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .add),
                                                                    color: Colors
                                                                        .white,
                                                                    iconSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ).then((value) {
                                            total = 0;
                                            for (Item1 i
                                                in widget.chef!.menu.oneTime) {
                                              total += i.quantity;
                                            }
                                            setState(() {});
                                          });
                                        },
                                        child: menuItem(width,
                                            widget.chef!.menu.oneTime[index])),
                                    //Divider(color: Colors.black,)
                                  ],
                                );
                                //return MenuItem(width: width,);
                              }),
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
        child: InkWell(
            onTap: () {
              if (total >= 1) {
                List<Item1> cart = [];
                for (var o in widget.chef!.menu.oneTime) {
                  if (o.quantity >= 1) {
                    cart.add(o);
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart(
                              cart: cart,
                              subscription: false,
                              user: widget.user,
                              vendorID: widget.vendorID,
                            ))).then((value) {
                  total = 0;
                  for (Item1 i in widget.chef!.menu.oneTime) {
                    total += i.quantity;
                  }
                  setState(() {});
                });
              }
            },
            child: CustomButton(
              width: width,
              title: "Go To Cart",
            )),
      ),
    );
  }

  Widget cartWithCounter() {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.business_center,
              color: color.purple,
            ),
            onPressed: () {
              if (total >= 1) {
                List<Item1> cart = [];
                for (var o in widget.chef!.menu.oneTime) {
                  if (o.quantity >= 1) {
                    cart.add(o);
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cart(
                              cart: cart,
                              subscription: false,
                              user: widget.user,
                              vendorID: widget.vendorID,
                            ))).then((value) {
                  total = 0;
                  for (Item1 i in widget.chef!.menu.oneTime) {
                    total += i.quantity;
                  }
                  setState(() {});
                });
              }
            }),
        total != 0
            ? Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$total',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget myAppbar() {
    return CachedNetworkImage(
      imageUrl: endpoint.picBase + widget.chef!.logo!,
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

  Widget vendorInfo(width) {
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
                  width: width * 0.35,
                  child: AutoSizeText(
                    widget.chef!.name!,
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
                  width: width * 0.35,
                  child: AutoSizeText(
                    widget.chef!.label!,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            widget.chef!.rating == 0.0
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Rating not available",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.centerRight,
                    width: width * 0.45,
                    child: RatingStars(
                      value: widget.chef!.rating,
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
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
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

  Widget menuItem(width, Item1 oneTime) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.35,
                  child: AutoSizeText(
                    oneTime.name,
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
                  child: AutoSizeText(
                    oneTime.desc,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ]),
          Container(
            width: width * 0.18,
            child: AutoSizeText(
              oneTime.price.toString(),
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
