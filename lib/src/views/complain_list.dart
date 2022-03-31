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

class ComplainList extends StatelessWidget {
  static const routeName = '/complainList';

  const ComplainList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complains",
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
                          child: ComplainBox(
                            width: width,
                            context: context,
                            x: index,
                          ));
                    }),
                
              );
            }),
          ),
        ),
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
    );
  }
}

class ComplainBox extends StatelessWidget {
  double width;
  BuildContext context;
  int x;
  ComplainBox({
    Key? key,
    required this.width,
    required this.context,
    required this.x
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
            Container(
              width: width * 0.35,
              child: Text(
                "Complaint # $x",
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
      ),
    );
  }
}
