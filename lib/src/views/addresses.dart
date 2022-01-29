import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Addresses extends StatelessWidget {
  static const routeName = '/addresses';

  const Addresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Addresses",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
              return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {},
                          child: AddressBox(
                            width: width,
                            context: context,
                          ));
                      //return MenuItem(width: width,);
                    }),
                // child: Column(
                //   children: [
                //     Center(
                //         child: Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         MyAppbar(),
                //         Positioned(
                //           top: 10,
                //           left: 15,
                //           child: Container(
                //             child: IconButton(
                //               icon: Icon(Icons.arrow_back),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //             ),
                //             decoration: BoxDecoration(
                //                 color: Colors.white, shape: BoxShape.circle),
                //           ),
                //         ),
                //         Positioned(
                //           top: 10,
                //           right: 15,
                //           child: Container(
                //             child: IconButton(
                //               icon: Icon(Icons.business_center),
                //               onPressed: () {
                //                 Navigator.pushNamed(context, Cart.routeName);
                //               },
                //             ),
                //             decoration: BoxDecoration(
                //                 color: Colors.white, shape: BoxShape.circle),
                //           ),
                //         ),
                //       ],
                //     )),
                //     SizedBox(
                //       height: 50,
                //     ),
                //     Container(
                //       margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                //       child: Column(
                //         children: [
                //           VendorInfo(width: width,),
                //           SizedBox(height: 20,),
                //           ListView.builder(
                //               shrinkWrap: true,
                //               physics: NeverScrollableScrollPhysics(),
                //               itemCount: 3,
                //               itemBuilder: (context, index) {
                //                 return Column(
                //                   children: [
                //                     InkWell(onTap: (){
                //                       Navigator.pushNamed(context, Item.routeName);
                //                     }, child: MenuItem(width: width,)),
                //                     Divider(color: Colors.black,)
                //                   ],
                //                 );
                //                 //return MenuItem(width: width,);
                //               }),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Maps.routeName);
            },
            child: CustomButton(
              width: width,
              title: "New Address",
            )),
      ),
    );
  }
}

class AddressBox extends StatelessWidget {
  double width;
  BuildContext context;
  AddressBox({
    Key? key,
    required this.width,
    required this.context
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: color.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "Home",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: color.purple,
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, AddressView.routeName);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                "A12, ABC street, some area",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                "Karachi",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
