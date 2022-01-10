import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/views/filter.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Login.routeName:
      return MaterialPageRoute(builder: (_) => const Login());
    case Register.routeName:
      return MaterialPageRoute(builder: (_) => const Register());
    case Home.routeName:
      return MaterialPageRoute(builder: (_) => const Home());
    case Filter.routeName:
      return MaterialPageRoute(builder: (_) => const Filter());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ));
  }
}
