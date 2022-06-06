import 'package:tiffin_wala_customer/src/models/day.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';

class Menu1 {
  List<Day> monday, tuesday, wednesday, thursday, friday, saturday, sunday;
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

  factory Menu1.fromJson(Map<String, dynamic> json) {
    List<Day> m = [], t = [], w = [], th = [], f = [], s = [], sun = [];
    List<Item1> o = [];
    for (var item in json['onetime']) {
      Item1 x = Item1.fromJson(item);
      o.add(x);
    }
    for (var time in json['mon']) {
      Day x = Day.fromJson(time);
      m.add(x);
    }
    for (var time in json['tues']) {
      Day x = Day.fromJson(time);
      t.add(x);
    }
    for (var time in json['wed']) {
      Day x = Day.fromJson(time);
      w.add(x);
    }
    for (var time in json['thurs']) {
      Day x = Day.fromJson(time);
      th.add(x);
    }
    for (var time in json['fri']) {
      Day x = Day.fromJson(time);
      f.add(x);
    }
    for (var time in json['sat']) {
      Day x = Day.fromJson(time);
      s.add(x);
    }
    for (var time in json['sun']) {
      Day x = Day.fromJson(time);
      sun.add(x);
    }
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
