import 'package:tiffin_wala_customer/src/models/item.dart';

class Day {
  List<Item1> breakfast, lunch, dinner;
  Day({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    List<Item1> b = [];
    List<Item1> l = [];
    List<Item1> d = [];
    //for (var d in json){}
    return Day(
      breakfast: b,
      lunch: l,
      dinner: d,
    );
  }
}
