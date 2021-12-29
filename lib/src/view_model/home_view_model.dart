import 'package:flutter/material.dart';


class HomeViewModel extends ChangeNotifier {
  int count = 0;
  increamentCount(){
    count++;
    notifyListeners();
  }
}
