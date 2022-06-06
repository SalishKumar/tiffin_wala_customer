import 'package:tiffin_wala_customer/src/models/address.dart';

class User1 {
  String? name, email, phone, password;
  late String msg, token;
  late bool status, google;
  late List<Address> address;

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
      user.status = json["status"] ?? "";
      user.msg = json["message"] ?? "";
      user.token = customer["authentication_token"];
      for(var address in json['addresses']){
        user.address.add(Address.fromJson(address));
      }
    } else {
      user.status = json["status"] ?? "";
      user.msg = json["message"] ?? "";
    }
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
