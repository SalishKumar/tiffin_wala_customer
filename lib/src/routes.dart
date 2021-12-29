import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Home.routeName:
      return MaterialPageRoute(builder: (_) => const Home());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ));
  }
}
