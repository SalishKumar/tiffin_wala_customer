import 'package:tiffin_wala_customer/src/models/dish.dart';

class Item1 {
  String name, logo;
  int id;
  double price;
  List<Dish> dishes;
  Item1({
    required this.name,
    required this.logo,
    required this.id,
    required this.price,
    required this.dishes
  });

  factory Item1.fromJson(Map<String, dynamic> json) {
    List<Dish> d = [];
    for (var dish in json['dishes']){
      Dish x = Dish.fromJson(dish);
      d.add(x);
    }
    return Item1(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        logo: json["logo"] ?? "",
        price: json["price"] ?? 1.0,
        dishes: d,
      );
  }
}
