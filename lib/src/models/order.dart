import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/models/complain.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/voucher.dart';

class Order {
  String? logo, orderStatus, kitchenName;
  Address? address;
  double? totalAmount, discounted;
  int? id, sellerID, customerID;
  List<Item1>? orders = [];
  Voucher? voucher;
  DateTime? orderTime;
  bool? voucherApplied;
  bool? isRated, isComplain;
  double? rating;
  Complain? complain;
  Order(
      {this.address,
      this.discounted,
      this.id,
      this.kitchenName,
      this.logo,
      this.orderStatus,
      this.orders,
      this.totalAmount,
      this.voucher,
      this.orderTime,
      this.customerID,
      this.sellerID,
      this.voucherApplied,
      this.complain});
  factory Order.fromJson(Map<String, dynamic> json) {
    List<Item1> item = [];
    var order = json["order"];
    var orderid;
    for(var o in order){
      var quantity = o["quantity"];
      orderid=o["order_id"];
      Item1 i = Item1.fromJson(o["dish_id"]);
      i.quantity = quantity;
      item.add(i);
    }
    var sellerid = orderid["seller_id"];
    var customer = json["customer"];
    var customerid = customer["customer_id"];
    var seller = json["seller_id"];
    var orderAddress = json["order_address"];
    String date_time = json["date_time"];
    Order o;
    // print("print order id " + " " + json["order_id"].toString());
    // print("print order id " + " " + json["review"].toString());
    // print("print Complain " + " " + json["complain"].toString());
    o = Order(
      id: json["order_id"],
      customerID: customerid,
      sellerID: sellerid,
      logo: seller["logo"],
      kitchenName: seller["kitchen_name"],
      orderStatus: json["order_status"],
      voucherApplied: json["is_coupon_applied"],
      orderTime: DateTime.parse(date_time),
      totalAmount:  json["amount"],
      address: Address.fromJson(orderAddress),
      orders: item,
    );
    double discount = json["amount"];
    
    Voucher? v;
    if(json["is_coupon_applied"]){
      discount = json["discounted_amount"];
      v = Voucher.fromJson(json["coupon"]);
      o.discounted = discount;
    o.voucher = v;
    }
    var review = json["review"];
    o.isRated=false;
    o.rating=0.0;
    if(json["review"] != null){
      for(var r in review){
        print("in");
      o.isRated = true;
      o.rating = r["rating"] ?? 0.0;
      }
    }else{
      o.isRated=false;
    }
    if(json["complain"] != null){
      for(var c in json["complain"]){
        print("in");
      o.isComplain = true;
      o.complain = Complain.fromJson(c);
      }
    }else{
      o.isComplain = false;
      print(o.isComplain);
    }
    
    return o; 
    
  }

  factory Order.fromJsonSubscription(Map<String, dynamic> json) {
    var s = json["is_subscription_active"];
    String status = "";
    if(s){
      status = "Active";
    }else if (s == false){
      status = "Not Active";
    }
    // print("ok1");
    List<Item1> item = [];
    var order = json["subscription"];
    var orderid;
    for(var o in order){
      var quantity = o["quantity"];
      orderid=o["subscription_id"];
      Item1 i = Item1.fromJson(o["dish_id"]);
      i.quantity = quantity;
      item.add(i);
    }
    // print("ok2");
    var sellerid = orderid["seller_id"];
    var orderAddress = json["order_address"];
    var seller = json["seller_id"];
    Order o;
    // print("print order id " + " " + json["order_id"].toString());
    // print("print order id " + " " + json["review"].toString());
    // print("print Complain " + " " + json["complain"].toString());
    o = Order(
      id: json["subscription_id"],
      customerID: json["customer"],
      sellerID: sellerid,
      logo: seller["logo"],
      kitchenName: seller["kitchen_name"],
      orderStatus: status,
      address: Address.fromJson(orderAddress),
      orders: item,
    );
    return o;
  }
}
