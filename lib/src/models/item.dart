class Item1 {
  String name, desc, type, day;
  int id;
  int quantity = 0;
  double price;
  bool value = false;
  Item1({
    required this.name,
    required this.id,
    required this.price,
    required this.day,
    required this.desc,
    required this.type
  });

  factory Item1.fromJson(Map<String, dynamic> json) {
    String type1="";
    if(json["meal_type"] == "breakfast"){
      type1 = "Breakfast";
    }else if(json["meal_type"] == "lunch"){
      type1 = "Lunch";
    }else if(json["meal_type"] == "dinner"){
      type1 = "Dinner";
    }
    return Item1(
        id: json["dish_id"] ?? "",
        name: json["dish_name"] ?? "",
        price: json["price"] ?? 1.0,
        day: json["day"] ?? "",
        desc: json["dish_description"] ?? "",
        type: type1
      );
  }
}
