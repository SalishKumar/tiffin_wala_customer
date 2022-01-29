// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/forget_password_view_model.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';

class ForgetPassword extends StatelessWidget {
  static const routeName = '/forget';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
          child: Consumer<ForgetPasswordViewModel>(
              builder: (context, forgetPasswordViewModel, child) {
            return Container(
              child: Column(
                children: [
                  Center(child: MyLogo()),
                  MyCustomTextfield(
                    size: 20,
                    controller: forgetPasswordViewModel.emailOrPassCon,
                    textInputType: TextInputType.emailAddress,
                    onPressed: () {},
                    hintText: "Email/Phone",
                    error: forgetPasswordViewModel.emailOrPassError,
                    prefix: Icons.email,
                    onValidation: () {
                      
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      await forgetPasswordViewModel.forgetPass(context);
                    },
                    child: Center(
                        child: Container(
                      width: width * 0.9,
                      height: 60,
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                          color: color.purple,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: color.orange, width: 2)),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
