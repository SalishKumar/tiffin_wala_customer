import 'package:tiffin_wala_customer/src/models/menu.dart';

class Chef {
  String? name, label = "Featured", logo;
  double rating = 0.0;
  Menu1 menu;
  Chef({
    required this.name,
    required this.logo,
    required this.menu,
    this.label,
    required this.rating,
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    Menu1 m = Menu1.fromJson(json['menu']);
    return Chef(
        label: json["label"] ?? "",
        name: json["name"] ?? "",
        logo: json["logo"] ?? "",
        rating: json["rating"] ?? 1.0,
        menu: m,
      );
  }
}
