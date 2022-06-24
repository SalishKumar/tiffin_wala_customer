import 'package:tiffin_wala_customer/src/models/address.dart';
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
  bool? isRated;
  double? rating;
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
      this.voucherApplied});
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
    print(json["review"]);
    print(json["complain"]);
    Map map1 = {};
    if(json["review"] != null){
      print("in");
      o.isRated = true;
      o.rating = review["rating"]??0.0;
    }else{}
    
    return o; 
    
  }
}
