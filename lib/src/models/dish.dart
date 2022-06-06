class Dish {
  String? name;
  int? id;
  Dish({
    required this.name,
    required this.id,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
        id: json["dish_id"] ?? "",
        name: json["name"] ?? "",
      );
  }
}
