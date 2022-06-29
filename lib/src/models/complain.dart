import 'package:tiffin_wala_customer/src/models/voucher.dart';
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;

class Complain{
  String? customerName, kitchenName, status, desc, resolution;
  List<String>? images = [];
  int? id, customerID;
  bool? isResoved = false, voucherIssued = false, isCustomerRating = false;
  double? rating = 0.0;
  Voucher? voucher;

  Complain({this.customerName, this.desc, this.id, this.images, this.customerID, this.isCustomerRating, this.isResoved, this.kitchenName, this.rating, this.resolution, this.status, this.voucher, this.voucherIssued});

  factory Complain.fromJson(Map<String, dynamic> json) {
    print(json);
    print("customer ${json["customer"]}");
    print("seller ${json["seller"].toString()}");
    
    print(json["description"]);
    print(json["complain_id"]);
    var customer = json["customer"];
    var name = customer["customer_name"];
    var id = customer["customer_id"];
    var seller = json["seller"];
    var kitchenName = seller["kitchen_name"];
    List<String> pics = [];
    var images = json["image"];
    if(images!= null){
      for(var image in images){
        pics.add(endpoint.picBase + image["image"]);
      }
    }else{
      pics = [];
    }
    print(pics);
    
    Complain complain = Complain(
      customerName: name,
      desc: json["description"] ?? "",
      id: json["complain_id"],
      images: pics,
      kitchenName: kitchenName,
      customerID: id,
      isResoved: json["is_resolved"],
      resolution: json["resolution"]
    );
    if(json["voucher"] != null){
      complain.voucherIssued = true;
      var v = json["voucher"];
      complain.voucher = Voucher.fromJson(v);
    }else{
      complain.voucherIssued = false;
    }
    if(complain.isResoved == true){
      complain.status = "Resolved";
    }
    if(complain.isResoved == false){
      complain.status = "Pending";
    }
    if(json["customer_satisfication_rating"] != null){
      complain.rating = double.parse(json["customer_satisfication_rating"].toString());
      complain.isCustomerRating = true;
    }else{
      complain.rating = 0.0;
      complain.isCustomerRating = false;
    }

    return complain;
  }
}