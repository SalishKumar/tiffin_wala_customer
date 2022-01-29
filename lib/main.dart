import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/app.dart';
import 'package:tiffin_wala_customer/src/locator.dart';

void main() {
  //await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

