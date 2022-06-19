import 'package:tiffin_wala_customer/src/models/day.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';

class Menu1 {
  Day monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  List<Item1> oneTime;
  Menu1({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.oneTime,
  });

  factory Menu1.fromJson(Map<String, dynamic> json, List<Item1> o) {
    Day? m, t, w, th, f, s, sun;
    

    List<Item1> b = [];
    List<Item1> l = [];
    List<Item1> d = [];
    if (json['monday'] != null) {
      for (var time in json['monday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    //print(2);
    m = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['tuesday'] != null) {
      for (var time in json['tuesday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    t = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['wedneday'] != null) {
      for (var time in json['wedneday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    w = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['thursday'] != null) {
      for (var time in json['thursday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    th = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['friday'] != null) {
      for (var time in json['friday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    f = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['saturday'] != null) {
      for (var time in json['saturday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }
    s = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    if (json['sunday'] != null) {
      for (var time in json['sunday']) {
        if (time["meal_type"] == "breakfast") {
          b.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "lunch") {
          l.add(Item1.fromJson(time));
        } else if (time["meal_type"] == "dinner") {
          d.add(Item1.fromJson(time));
        }
      }
    }

    sun = Day(breakfast: b, lunch: l, dinner: d);

    b = [];
    l = [];
    d = [];
    return Menu1(
        monday: m,
        tuesday: t,
        wednesday: w,
        thursday: th,
        friday: f,
        saturday: s,
        sunday: sun,
        oneTime: o);
  }
}
