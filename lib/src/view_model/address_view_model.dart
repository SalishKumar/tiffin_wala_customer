import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';

class AddressViewModel extends ChangeNotifier {
  TextEditingController addressCon = TextEditingController();
  TextEditingController notesCon = TextEditingController();
  String notes ='', address ='';
  String addressError = '';
  String notesError = '';
  String dropdown = "Home";
  double lat = 24.860966, long = 66.990501;
  int? id;
  String note='';
  Database db = Database();

  initialize(){
    //print(data.label);
    if(data.label!='' &&data.addressEdit){
      dropdown=data.label;
      data.label="";
    }
    note='';
    if(data.notes!=""&&data.addressEdit){
      note=data.notes;
      data.notes="";
    }
    //print(note +" * "+notes);
    address = data.address;
    lat = data.lat;
    long = data.long;
    id = data.adressID;
    notifyListeners();
  }

  inputAddress(v) {
    address=v;
    data.address = address;
    if (address.trim().isEmpty) {
      addressError = "Address is Empty";
    } else {
      addressError = '';
    }
    notifyListeners();
  }

  inputNotes(v){
    notes = v;
    notifyListeners();
  }

  dropdownFunction(dropdownValue) {
    dropdown = dropdownValue;
    //print(dropdown + ' ' + "88");
  }

  Future newAddress(BuildContext context) async {
    if (dropdown.isNotEmpty &&
        (address.trim().isNotEmpty && addressError == "")) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: color.purple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );
      Address addres = Address(
          address: address.trim(),
          label: dropdown.toLowerCase(),
          lat: lat,
          long: long);
          addres.notes = notes.trim();
          //print("a $notes");
      dynamic result = await db.address(addres.toJSON());
      Navigator.pop(context);
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (result != null) {
          if (result['Timeout'] == 'true') {
            Fluttertoast.showToast(
                msg: 'Your request has been timmed-out. Try again.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            List<Address> addressList = [];
            if (result["status"] == true) {
              for(var a in result["addresses"]){
                addressList.add(Address.fromJson(a));
              }
              data.user.address=[];
              data.user.address = addressList;
              //print("${data.user.address.length} *");
              data.address="";
              data.notes = "";
              data.adressID=null;
              Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
              data.label='';
            } else {
              Fluttertoast.showToast(
                  msg: result["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Address form is not correct.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  Future editAddress(BuildContext context) async {
    if (dropdown.isNotEmpty &&
        (address.trim().isNotEmpty && addressError == "")) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: color.purple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );
      Address addres = Address(
          address: address.trim(),
          label: dropdown.toLowerCase(),
          lat: lat,
          long: long);
          addres.id=id;
          addres.notes = notes;
          
      dynamic result = await db.editAddress(addres.toJSON());
      Navigator.pop(context);
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (result != null) {
          if (result['Timeout'] == 'true') {
            Fluttertoast.showToast(
                msg: 'Your request has been timmed-out. Try again.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            List<Address> addressList = [];
            if (result["status"] == true) {
              for(var a in result["addresses"]){
                addressList.add(Address.fromJson(a));
              }
              data.user.address=[];
              data.user.address = addressList;
              addressCon.text = "";
              notesCon.text = "";
              Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: result["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Address form is not correct.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }
}
