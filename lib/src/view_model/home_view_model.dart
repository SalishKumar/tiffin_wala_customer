import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  
  late User1 user;
  
  
  search(){
    // print(val + '*');
    // searchController.text=val;
  }
}
