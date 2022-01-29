import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Item extends StatelessWidget {
  static const routeName = '/item';

  const Item({Key? key}) : super(key: key);

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
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        children: [
                          ItemInfo(
                            width: width,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          
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
      floatingActionButton: AddToCartMenu(width: width),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

class ItemInfo extends StatelessWidget {
  double width;
  ItemInfo({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.45,
            child: AutoSizeText(
              "Lunch Deal 1111111",
              maxLines: 1,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
                height: 20,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Container(
                padding: EdgeInsets.only(left: 5),
                width: width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "1  X Daal Chanwal Plate",
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 5,),
                    AutoSizeText(
                      "1  X Shami Kabab",
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 5,),
                    AutoSizeText(
                      "1  X Salad",
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.45,
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  "PKR 250/=",
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
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Center(
            child: Image.asset(
              "assets/images.jpg",
              width: width * 0.2,
              height: width * 0.2,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.4,
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
                width: width * 0.4,
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
          width: width * 0.2,
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
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  double width;
  AddToCartMenu({
    Key? key,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: width*0.1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove),
              color: Colors.white,
              iconSize: 18,
            ),
            decoration: BoxDecoration(
              color: color.purple,
              shape: BoxShape.circle,
              border: Border.all(color: color.orange, width: 2)
            ),
          ),
          InkWell(
            onTap: () => print('hello'),
            child: Container(
              width: width*0.7,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.purple,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: color.orange, width: 2)
              ),
              child: Center(
                child: Text(
                  '2',
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            width: width*0.1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 18,
              
            ),
            decoration: BoxDecoration(
              color: color.purple,
              shape: BoxShape.circle,
              border: Border.all(color: color.orange, width: 2)
            ),
          ),
        ],
      ),
    );
  }
}
