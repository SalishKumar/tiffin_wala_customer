import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/app_provider.dart';
import 'package:tiffin_wala_customer/src/routes.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
        child: MaterialApp(
          onGenerateRoute: generateRoute,
          home: Login()
          ),
    );
  }
}
