import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/chefs.dart';
import 'package:tiffin_wala_customer/src/models/day.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class SubscriptionMenu extends StatefulWidget {
  static const routeName = '/subscription_menu';
  Chef? chef;
  User1? user;
  int? vendorID;

  SubscriptionMenu({Key? key, this.chef, this.user, this.vendorID})
      : super(key: key);

  @override
  State<SubscriptionMenu> createState() => _SubscriptionMenuState();
}

class _SubscriptionMenuState extends State<SubscriptionMenu> {
  bool mondayAvailable = false;
  bool tuesdayAvailable = false;
  bool wednedayAvailable = false;
  bool thursdayAvailable = false;
  bool fridayAvailable = false;
  bool saturdayAvailable = false;
  bool sundayAvailable = false;
  int total = 0;

  @override
  void initState() {
    if (widget.chef!.menu.monday.breakfast.isNotEmpty &&
        widget.chef!.menu.monday.lunch.isNotEmpty &&
        widget.chef!.menu.monday.dinner.isNotEmpty) {
      mondayAvailable = true;
    }
    if (widget.chef!.menu.tuesday.breakfast.isNotEmpty &&
        widget.chef!.menu.tuesday.lunch.isNotEmpty &&
        widget.chef!.menu.tuesday.dinner.isNotEmpty) {
      tuesdayAvailable = true;
    }
    if (widget.chef!.menu.wednesday.breakfast.isNotEmpty &&
        widget.chef!.menu.wednesday.lunch.isNotEmpty &&
        widget.chef!.menu.wednesday.dinner.isNotEmpty) {
      wednedayAvailable = true;
    }
    if (widget.chef!.menu.thursday.breakfast.isNotEmpty &&
        widget.chef!.menu.thursday.lunch.isNotEmpty &&
        widget.chef!.menu.thursday.dinner.isNotEmpty) {
      thursdayAvailable = true;
    }
    if (widget.chef!.menu.friday.breakfast.isNotEmpty &&
        widget.chef!.menu.friday.lunch.isNotEmpty &&
        widget.chef!.menu.friday.dinner.isNotEmpty) {
      fridayAvailable = true;
    }
    if (widget.chef!.menu.saturday.breakfast.isNotEmpty &&
        widget.chef!.menu.saturday.lunch.isNotEmpty &&
        widget.chef!.menu.saturday.dinner.isNotEmpty) {
      saturdayAvailable = true;
    }
    if (widget.chef!.menu.sunday.breakfast.isNotEmpty &&
        widget.chef!.menu.sunday.lunch.isNotEmpty &&
        widget.chef!.menu.sunday.dinner.isNotEmpty) {
      sundayAvailable = true;
    }
    totalItems();
    setState(() {});
    super.initState();
  }

  totalItems() {
    total = 0;
    for (var b in widget.chef!.menu.monday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.monday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.monday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.tuesday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.tuesday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.tuesday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.wednesday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.wednesday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.wednesday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.thursday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.thursday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.thursday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.friday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.friday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.friday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.saturday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.saturday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.saturday.dinner) {
      total += d.quantity;
      // break;
    }
    for (var b in widget.chef!.menu.sunday.breakfast) {
      total += b.quantity;
      // break;
    }
    for (var l in widget.chef!.menu.sunday.lunch) {
      total += l.quantity;
      // break;
    }
    for (var d in widget.chef!.menu.sunday.dinner) {
      total += d.quantity;
      // break;
    }
  }

  
  cartItems() {
    List<Item1> cart = [];
    for (var b in widget.chef!.menu.monday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.monday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.monday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.tuesday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.tuesday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.tuesday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.wednesday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.wednesday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.wednesday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.thursday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.thursday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.thursday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.friday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.friday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.friday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.saturday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.saturday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.saturday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    for (var b in widget.chef!.menu.sunday.breakfast) {
      if(b.quantity != 0){
        cart.add(b);
      }
      // break;
    }
    for (var l in widget.chef!.menu.sunday.lunch) {
      if(l.quantity != 0){
        cart.add(l);
      }
      // break;
    }
    for (var d in widget.chef!.menu.sunday.dinner) {
      if(d.quantity != 0){
        cart.add(d);
      }
      // break;
    }
    return cart;
  }

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
                  Positioned(top: 10, right: 15, child: cartWithCounter()),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    vendorInfo(
                      width,
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
                    // onTap: (value) {
                    //   print(value);
                    //   breakfast = false;
                    //   lunch = false;
                    //   dinner = false;
                    //   setState(() {});
                    // },
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
                      mondayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Monday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.monday),
                      tuesdayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Tuesday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.tuesday),
                      wednedayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Wednesday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.wednesday),
                      thursdayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Thursday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.thursday),
                      fridayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Friday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.friday),
                      saturdayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Sturday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.saturday),
                      sundayAvailable == false
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              // height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: Text(
                                "No Menu Available for Sunday",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            )
                          : dailyMenu(width, widget.chef!.menu.sunday),
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
                if (total >= 1) {
              List<Item1> cart = [];
              cart = cartItems();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cart(
                            cart: cart,
                            subscription: true,
                            user: widget.user,
                            vendorID: widget.vendorID,
                          ))).then((value) {
                totalItems();
                setState(() {});
              });
            }else{
              Fluttertoast.showToast(
                  msg: "First add items to cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
              },
              child: CustomButton(
                width: width,
                title: "Go To Cart",
              )),
        ),
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
              cart= cartItems();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cart(
                            cart: cart,
                            subscription: true,
                            user: widget.user,
                            vendorID: widget.vendorID,
                          ))).then((value) {
                totalItems();
                setState(() {});
              });
            }else{
              Fluttertoast.showToast(
                  msg: "First add items to cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
        ),
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

  Widget dailyMenu(width, Day day) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
              onTap: () {
                print(breakfast);
                if (breakfast) {
                  breakfast = false;
                  lunch = false;
                  dinner = false;
                } else if (breakfast == false) {
                  breakfast = true;
                  lunch = false;
                  dinner = false;
                }
                setState(() {});
              },
              child: CustomButton(width: width * 0.9, title: "Breakfast")),
          breakfast
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: day.breakfast.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, Item.routeName);
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                  return SingleChildScrollView(
                                    controller:
                                        ModalScrollController.of(context),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: CachedNetworkImage(
                                            imageUrl: endpoint.picBase +
                                                widget.chef!.logo!,
                                            width: double.infinity,
                                            height: 200,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
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
                                            padding: EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: AutoSizeText(
                                              day.breakfast[index].name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                width: width * 0.45,
                                                child: AutoSizeText(
                                                  day.breakfast[index].desc,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.45,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: AutoSizeText(
                                                  day.breakfast[index].price
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
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
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (day.breakfast[index].quantity >
                                                              0) {
                                                            day.breakfast[index].quantity--;
                                                            setState(() {});
                                                          }
                                                        },
                                                        icon:
                                                            Icon(Icons.remove),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                                        day.breakfast[index].quantity
                                                            .toString(),
                                                        style: new TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          day.breakfast[index].quantity++;
                                                          setState(() {});
                                                        },
                                                        icon: Icon(Icons.add),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                totalItems();
                                setState(() {});
                              });
                            },
                            child: menuItem(
                              width,
                              day.breakfast[index]
                            )),
                        //Divider(color: Colors.black,)
                      ],
                    );
                    //return MenuItem(width: width,);
                  })
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                if (lunch) {
                  breakfast = false;
                  lunch = false;
                  dinner = false;
                } else if (lunch == false) {
                  breakfast = false;
                  lunch = true;
                  dinner = false;
                }
                setState(() {});
              },
              child: CustomButton(width: width * 0.9, title: "Lunch")),
          lunch
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: day.lunch.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, Item.routeName);
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                  return SingleChildScrollView(
                                    controller:
                                        ModalScrollController.of(context),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: CachedNetworkImage(
                                            imageUrl: endpoint.picBase +
                                                widget.chef!.logo!,
                                            width: double.infinity,
                                            height: 200,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
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
                                            padding: EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: AutoSizeText(
                                              day.lunch[index].name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                width: width * 0.45,
                                                child: AutoSizeText(
                                                  day.lunch[index].desc,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.45,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: AutoSizeText(
                                                  day.lunch[index].price
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
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
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (day.lunch[index].quantity >
                                                              0) {
                                                            day.lunch[index].quantity--;
                                                            setState(() {});
                                                          }
                                                        },
                                                        icon:
                                                            Icon(Icons.remove),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                                        day.lunch[index].quantity
                                                            .toString(),
                                                        style: new TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          day.lunch[index].quantity++;
                                                          setState(() {});
                                                        },
                                                        icon: Icon(Icons.add),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                totalItems();
                                setState(() {});
                              });
                            },
                            child: menuItem(
                              width,
                              day.lunch[index]
                            )),
                        //Divider(color: Colors.black,)
                      ],
                    );
                    //return MenuItem(width: width,);
                  })
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                if (dinner) {
                  breakfast = false;
                  lunch = false;
                  dinner = false;
                } else if (dinner == false) {
                  breakfast = false;
                  lunch = false;
                  dinner = true;
                }
                setState(() {});
              },
              child: CustomButton(width: width * 0.9, title: "Dinner")),
          dinner
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: day.dinner.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, Item.routeName);
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                  return SingleChildScrollView(
                                    controller:
                                        ModalScrollController.of(context),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: CachedNetworkImage(
                                            imageUrl: endpoint.picBase +
                                                widget.chef!.logo!,
                                            width: double.infinity,
                                            height: 200,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
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
                                            padding: EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: AutoSizeText(
                                              day.dinner[index].name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                width: width * 0.45,
                                                child: AutoSizeText(
                                                  day.dinner[index].desc,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.45,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: AutoSizeText(
                                                  day.dinner[index].price
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
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
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (day.dinner[index].quantity >
                                                              0) {
                                                            day.dinner[index].quantity--;
                                                            setState(() {});
                                                          }
                                                        },
                                                        icon:
                                                            Icon(Icons.remove),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                                        day.dinner[index].quantity
                                                            .toString(),
                                                        style: new TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color.purple,
                                                        border: Border.all(
                                                            color: color.orange,
                                                            width: 2)),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          day.dinner[index].quantity++;
                                                          setState(() {});
                                                        },
                                                        icon: Icon(Icons.add),
                                                        color: Colors.white,
                                                        iconSize: 16,
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
                                totalItems();
                                setState(() {});
                              });
                            },
                            child: menuItem(
                              width,
                              day.dinner[index]
                            )),
                        //Divider(color: Colors.black,)
                      ],
                    );
                    //return MenuItem(width: width,);
                  })
              : SizedBox(),
        ],
      ),
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
