import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class AddressViewModel extends ChangeNotifier {
  TextEditingController addressCon = TextEditingController();
  TextEditingController floorUnitCon = TextEditingController();
  TextEditingController notesCon = TextEditingController();
  String addressError = '';
  String floorUnitError = '';
  String notesError = '';
  String dropdown = "Home";

  AddressViewModel(){
    addressCon.text=data.address;
    notifyListeners();
  }

  inputAddress(){
    if(addressCon.text.trim().isEmpty){
      addressError = "Address is Empty";
    }else{
      addressError = '';
    }
    notifyListeners();
  }

  dropdownFunction(dropdownValue){
    dropdown = dropdownValue;
    notifyListeners();
  }

  inputFloorUnit(){
    if(floorUnitCon.text.trim().isEmpty){
      floorUnitError = 'Floor/Unit is Empty';
    }else{
      floorUnitError = '';
    }
  }
}
