import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/app.dart';
import 'package:tiffin_wala_customer/src/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

