import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
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
  Database db = Database();
  late User1 user1;
  String deviceID = '';

  autoLogin(User1 user) async {
    if (user.google) {
      user.password = "none";
    } else {
      user.password = "input";
    }
    await storage.write(key: 'id', value: user.id.toString());
    await storage.write(key: 'name', value: user.name);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'password', value: user.password);
    await storage.write(key: 'google', value: user.google.toString());
    await storage.write(key: 'token', value: user.token);
  }

  Future loginToken(String? token, bool google, String id) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return Dialog(
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         child: Container(
    //           width: MediaQuery.of(context).size.width * 0.6,
    //           height: 300,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               CircularProgressIndicator(
    //                 color: color.purple,
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text("Loading"),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    dynamic result = await db.loginToken(token, id);
    //Navigator.pop(context);
    if (result["status"]) {
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (result != null) {
          if (result['Timeout'] == 'true') {
            Fluttertoast.showToast(
                msg: 'Your request has been timmed-out. Try again.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            User1 userResult = User1.fromJson(result);
            if (userResult.status == true) {
              userResult.google = google;
              await autoLogin(userResult);
              data.user = userResult;
              route = true;
              await FirebaseAnalytics.instance
            .setCurrentScreen(screenName: 'Home Screen');
              setState(() {});
            } else if (userResult.status == false) {
              Fluttertoast.showToast(
                  msg: userResult.msg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
                  await FirebaseAnalytics.instance
            .setCurrentScreen(screenName: 'Login Screen');
            }
          }
        }
      }
      //data.user = user;
      //route = true;
    }
  }

  @override
  void initState() {
    try {
      Timer(Duration(seconds: 3), () async {
        // Future.delayed(Duration(seconds: 0), () async {
        await FirebaseAnalytics.instance
            .setCurrentScreen(screenName: 'Splash Screen');
        try {
          Map<String, String> allValues = await storage.readAll();
          print(allValues);
          if (allValues == null) {
            await FirebaseAnalytics.instance
            .setCurrentScreen(screenName: 'Login Screen');
            route = false;
            setState(() {});
          } else {
            deviceID = allValues["device_id"]!;
            User1 user = User1(
                name: allValues['name'],
                email: allValues['email'],
                phone: allValues['phone'],
                password: allValues['password']);
            user.id = int.tryParse(allValues["id"]!)!;
            if (allValues['google'] == 'true') {
              user.google = true;
            } else {
              user.google = false;
            }
            user.token = allValues['token']!;
            // route = false;
            // setState(() {

            // });
            await loginToken(user.token, user.google, deviceID);

            // data.user=user;
            // route = true;
            setState(() {});
          }
        } catch (e) {}
      });

      // });
      setState(() {});
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(route);
    return Center(
      child: SplashScreenView(
        navigateRoute: route ? const Home() : Login(),
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
