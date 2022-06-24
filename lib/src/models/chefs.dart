import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/menu.dart';

class Chef {
  String? name, label = "Featured", logo;
  int? id;
  double rating = 0.0;
  Menu1 menu;
  Chef({
    required this.name,
    required this.logo,
    required this.menu,
    this.label,
    this.id,
    required this.rating,
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    List<Item1> o = [];
    if (json['one_time'] != "") {
      for (var item in json['one_time']) {
        Item1 x = Item1.fromJson(item);
        o.add(x);
      }
    }
    
    Menu1 m = Menu1.fromJson(json['menu'], o);
    return Chef(
      label: json["label"] ?? "Featured",
      id: json["vendor_id"] ?? 0,
      name: json["kitchen_name"] ?? "",
      logo: json["logo"] ?? "",
      rating: double.parse(json["rating"].toString()),
      menu: m,
    );
  }
}
