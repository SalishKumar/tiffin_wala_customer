import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final storage = new FlutterSecureStorage();
  late User1 user;
  
  logout() async{
    await storage.deleteAll();
  }

  search(){
    // print(val + '*');
    // searchController.text=val;
  }
}
