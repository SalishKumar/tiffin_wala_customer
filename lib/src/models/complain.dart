import 'package:tiffin_wala_customer/src/models/voucher.dart';

class Complain{
  String? customerName, kitchenName, status, desc, resolution;
  List<String>? images = [];
  int? id;
  bool? isResoved = false, voucherIssued = false, isCustomerRating = false;
  double? rating = 0.0;
  Voucher? voucher;

  Complain({this.customerName, this.desc, this.id, this.images, this.isCustomerRating, this.isResoved, this.kitchenName, this.rating, this.resolution, this.status, this.voucher, this.voucherIssued});

  factory Complain.fromJson(Map<String, dynamic> json) {
    var customer = json["customer"];
    var name = customer["customer_name"];
    var seller = json["seller"];
    var kitchenName = seller["kitchen_name"];
    List<String> pics = [];
    var images =json["image"];
    if(images!= null){
      for(var image in images){
        pics.add(image["image"]);
      }
    }
    
    Complain complain = Complain(
      customerName: name,
      desc: json["description"] ?? "",
      id: json["complain_id"],
      images: pics,
      kitchenName: kitchenName,
      isResoved: json["is_resolved"],
      resolution: json["resolution"]
    );
    if(json["voucher"] != null){
      complain.voucherIssued = true;
      var v = json["voucher"];
      complain.voucher = Voucher.fromJson(v);
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