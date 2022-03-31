import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Menu extends StatelessWidget {
  static const routeName = '/menu';

  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
              return Container(
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
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: 10),
                      child: Column(
                        children: [
                          VendorInfo(
                            width: width,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Item.routeName);
                                        },
                                        child: MenuItem(
                                          width: width,
                                        )),
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
              );
            }),
          ),
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
