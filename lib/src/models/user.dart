import 'dart:convert';

import 'package:tiffin_wala_customer/src/models/address.dart';

class User1 {
  String? name, email, phone, password;
  late String msg, token;
  late bool status, google;
  List<Address> address=[];
  late int id;

  User1({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
  factory User1.fromJson(Map<String, dynamic> json) {
    User1 user = User1(email: '', name: '', password: '', phone: '');
    bool s = json["status"] ?? "";
    
    if (s) {
      
      var customer = json["customer"];
      user = User1(
        name: customer["customer_name"] ?? "",
        email: customer["customer_email"] ?? "",
        phone: customer["phone"] ?? "",
        password: customer["customer_password"] ?? "",
      );
      user.id=customer["customer_id"];
      user.status = json["status"] ?? "";
      user.msg = json["message"] ?? "";
      user.token = customer["authentication_token"];
      var x=json["customer"]['addresses'];
      print(x);
      for(var a in x){
        Address add = Address(address: a["address"], label: a["label"], lat: a["lat"], long: a["long"]);
        if(add.label == "home"){
          add.label = "Home";
        } else if (add.label == "work"){
          add.label = "Work";
        }
        print(add.label);
        add.notes = a["notes"];
        add.id=a["address_id"];
        print(10);
        user.address.add(add);
      }
      print("if");
    } else {
      print("else");
      user.status = json["status"] ?? "";
      user.msg = json["message"] ?? "";
    }
    print(3);
    return user;
  }
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map;
    if (google) {
      map = {
        'customer_name': name?.trim(),
        'customer_email': email?.trim(),
        'customer_phone': phone?.trim(),
        'google_auth_token': password?.trim(),
      };
    } else {
      map = {
        'customer_name': name?.trim(),
        'customer_email': email?.trim(),
        'customer_phone': phone?.trim(),
        'customer_password': password?.trim(),
      };
    }
    return map;
  }
}
