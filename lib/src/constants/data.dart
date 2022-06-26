import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/models/complain.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';

String address = '';
double lat = 24.860966, long = 66.990501;
String notes='', label = 'Home';
int? adressID;
User1 user = User1(email: '', phone: '', password: '', name: '');
String order = '';
bool addressDirect = true;
bool addressEdit = false;
bool filterApplied = false, cusineSelected1 = false, cusineSelected2 = false, subs = false;
List<Item1> filteredList = [];
int chosenAddress=0;
Complain? complain;
double rating = 0.0;