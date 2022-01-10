import 'package:flutter/material.dart';

class FilterViewModel extends ChangeNotifier {
  bool cusines = false;
  List<bool> listOfCusines = [false, false, false];
  bool nearby = false;
  search() {
    // print(val + '*');
    // searchController.text=val;
  }

  cusineSelection() {
    cusines = !cusines;
    notifyListeners();
  }

  cusineChanged(int x){
    listOfCusines[x]=!listOfCusines[x];
    notifyListeners();
  }

    nearbySelection() {
    nearby = !nearby;
    notifyListeners();
  }
}
