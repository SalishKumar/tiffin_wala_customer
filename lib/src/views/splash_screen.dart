import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool route = false;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    try {
      Timer(Duration(seconds: 5), () async {
        Map<String, String> allValues = await storage.readAll();
        print(allValues);
        if (allValues == null) {
          route = false;
          setState(() {});
        } else {
          User1 user = User1(
              name: allValues['name'],
              email: allValues['email'],
              phone: allValues['phone'],
              password: allValues['password']);
          if (allValues['google'] == 'true') {
            user.google = true;
          } else {
            user.google = false;
          }
          user.token = allValues['token']!;
          route = true;
          setState(() {});
        }
      });
      setState(() {});
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(route);
    return Center(
      child: SplashScreenView(
        navigateRoute: route ? const Home() : const Login(),
        duration: 6000,
        imageSize: 350,
        imageSrc: "assets/logo.png",
        text: "Tiffin Wala",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40.0,
        ),
        colors: [
          color.purple,
          Colors.orange,
          color.purple,
          Colors.orange,
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
