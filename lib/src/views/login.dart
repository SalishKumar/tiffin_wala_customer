// ignore_for_file: prefer_const_constructors

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/forget_password.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  Login({Key? key}) : super(key: key);

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Double Tap to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    String input = '';
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 50),
                      child: Center(child: MyLogo()),
                    ),
                    MyCustomTextfield(
                      size: 50,
                      disable: true,
                      controller: loginViewModel.emailCon,
                      textInputType: TextInputType.emailAddress,
                      onPressed: () {},
                      hintText: "abc@gmail.com/03xxxxxxxxx",
                      label: 'Email/Phone',
                      error: loginViewModel.emailError,
                      prefix: Icons.email,
                      onValidation: () {
                        loginViewModel.inputEmail();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyCustomTextfield(
                      size: 20,
                      disable: true,
                      onValidation: () {
                        loginViewModel.inputPass();
                      },
                      controller: loginViewModel.passCon,
                      textInputType: TextInputType.visiblePassword,
                      onPressed: () {
                        loginViewModel.toggleSuffix();
                      },
                      hintText: "Password",
                      label: "Password",
                      error: loginViewModel.passError,
                      prefix: Icons.lock,
                      obscureText: loginViewModel.obsecure,
                      suffix: loginViewModel.suffix,
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAnalytics.instance.setCurrentScreen(
                            screenName: 'Forget Password Screen');
                        Navigator.pushNamed(context, ForgetPassword.routeName);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password? ",
                          style: TextStyle(fontSize: 18, color: color.purple),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        var id = await _getId();
                        loginViewModel.deviceID = id!;
                        await loginViewModel.login(context);
                      },
                      child: Center(
                          child: Container(
                        width: width * 0.9,
                        height: 60,
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
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
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async{
                        var id = await _getId();
                        loginViewModel.deviceID = id!;
                        loginViewModel.googleLogin(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(width * 0.9, 60),
                        elevation: 5,
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: Text('Login with Google'),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?  ",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () async {
                await FirebaseAnalytics.instance
                    .setCurrentScreen(screenName: 'Regsteration Screen');
                Navigator.of(context).pushReplacementNamed(Register.routeName);
              },
              child: Text(
                "Register.",
                style: TextStyle(
                    fontSize: 18,
                    color: color.purple,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
