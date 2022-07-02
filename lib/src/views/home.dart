import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/models/chefs.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';
import 'package:tiffin_wala_customer/src/views/addresses.dart';
import 'package:tiffin_wala_customer/src/views/complain_list.dart';
import 'package:tiffin_wala_customer/src/views/filter.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/views/menu.dart';
import 'package:tiffin_wala_customer/src/views/my_profile.dart';
import 'package:tiffin_wala_customer/src/views/order_list.dart';
import 'package:tiffin_wala_customer/src/views/subscription_menu.dart'; 
import 'package:tiffin_wala_customer/src/constants/api_url.dart' as endpoint;
import 'package:tiffin_wala_customer/src/views/subscription_order_list.dart';
import 'package:tiffin_wala_customer/src/views/vouchers.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database db = Database();
  List<Chef> vendors = [];
  bool loading = false;
  List<Item1> once = [];
  List<Item1> daily = [];
  List<Chef> searchList1 = [];
  bool search1 = false;
  List<Chef> filter1 = [];
  List<Chef> searchList2 = [];
  bool search2 = false;
  List<Chef> filter2 = [];
  TextEditingController searchCon1 = TextEditingController(),
      searchCon2 = TextEditingController();
  DateTime currentBackPressTime = DateTime.now();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    loading = true;
    var result = await db.home();
    if (result != null) {
      if (result['Timeout'] == 'true') {
        Fluttertoast.showToast(
            msg: 'Your request has been timmed-out. Try again.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (result["status"]) {
        vendors = [];
        for (var vendor in result["message"]) {
          vendors.add(Chef.fromJson(vendor));
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Issue with connection. Try again later.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    once = [];
    for (var v in vendors) {
      for (var o in v.menu.oneTime) {
        once.add(o);
      }
    }
    daily = [];
    for (var v in vendors) {
      for (var b in v.menu.monday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.monday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.monday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.tuesday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.tuesday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.tuesday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.wednesday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.wednesday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.wednesday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.thursday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.thursday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.thursday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.friday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.friday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.friday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.saturday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.saturday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.saturday.dinner) {
        daily.add(d);
        // break;
      }
      for (var b in v.menu.sunday.breakfast) {
        daily.add(b);
        // break;
      }
      for (var l in v.menu.sunday.lunch) {
        daily.add(l);
        // break;
      }
      for (var d in v.menu.sunday.dinner) {
        daily.add(d);
        // break;
      }
    }
    daily = daily.toSet().toList();
    for (var v in vendors) {
      filter1.add(v);
    }
    for (var v in vendors) {
      filter2.add(v);
    }
    loading = false;
    setState(() {});
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Double Tap to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final storage = new FlutterSecureStorage();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: color.purple,
                  ),
                  child: Center(
                    child: Text(
                      data.user.name!,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'My Orders',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderList(user: data.user,)));
                  },
                ),
                ListTile(
                  title: const Text(
                    'Subscription',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionOrderList(user: data.user,)));
                  },
                ),
                ListTile(
                  title: const Text(
                    'My Vouchers',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Vouchers(
                                  user1: data.user,
                                )));
                  },
                ),
                ListTile(
                  title: const Text(
                    'My Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyProfile()));
                  },
                ),
                ListTile(
                  title: const Text(
                    'My Addresses',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    data.addressDirect = true;
                    Navigator.pushNamed(context, Addresses.routeName);
                  },
                ),
                ListTile(
                  title: const Text(
                    'My Complaints',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainList(user: data.user,)
                    ));
                  },
                ),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () async {
                    await storage.deleteAll();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, Login.routeName);
                  },
                ),
              ],
            ),
          ),
          backgroundColor: color.background,
          appBar: AppBar(
            title: Text(
              "Tiffin Wala",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: color.purple,
            centerTitle: true,
            elevation: 0,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: AutoSizeText(
                    "One-Time Orders",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    "Subscription",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    "Custom Orders",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: onWillPop,
            child: loading
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child:
                        Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Color(0xffAEAEAE),
                          highlightColor: Colors.white,
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: 10.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 10.0,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 40.0,
                                            height: 10.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            itemCount: 6,
                          ),
                        ),
                      )
                    ]))
                : vendors.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                            child: Text(
                          "No Vendor Available",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      )
                    : TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        controller: searchCon1,
                                        onChanged: (V) {
                                          if (searchCon1.text.trim().isEmpty) {
                                            search1 = false;
                                          } else if (searchCon1.text
                                              .trim()
                                              .isNotEmpty) {
                                            searchList1 = [];
                                            for (var v in filter1) {
                                              if (v.name!.toLowerCase().contains(
                                                  searchCon1.text
                                                      .trim()
                                                      .toLowerCase())) {
                                                searchList1.add(v);
                                              }
                                            }
                                            search1 = true;
                                          }
          
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                data.subs = false;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Filter(
                                                              cusines: once,
                                                            ))).then((value) {
                                                  if (data.filterApplied) {
                                                    search1 = false;
                                                    searchCon1.clear();
                                                    filter1 = [];
                                                    if (data.cusineSelected1) {
                                                      // filter1 = [];
                                                      for (var v in vendors) {
                                                        for (var o
                                                            in v.menu.oneTime) {
                                                          for (var f in data
                                                              .filteredList) {
                                                            if (o.name ==
                                                                f.name) {
                                                              filter1.add(v);
                                                              // break;
                                                            }
                                                          }
                                                        }
                                                      }
                                                      filter1 = filter1
                                                          .toSet()
                                                          .toList();
                                                    } else {
                                                      for (var v in vendors) {
                                                        filter1.add(v);
                                                      }
                                                    }
                                                  }
                                                  setState(() {});
                                                });
                                              },
                                              child: Icon(
                                                Icons.list,
                                                color: color.orange,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                40, 15, 12, 15),
          
                                            // filled: true,
                                            // fillColor: color.textFieldFillColor,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: color.purple,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: color.orange,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: color.purple,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: color.orange,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            hintText: "Search",
                                            errorText: "",
                                            labelText: "Search",
                                            labelStyle:
                                                TextStyle(color: color.purple)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: search1
                                              ? searchList1.length
                                              : filter1.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Menu(
                                                                chef: search1
                                                                    ? searchList1[
                                                                        index]
                                                                    : filter1[
                                                                        index],
                                                                user: data.user,
                                                                vendorID: search1
                                                                    ? searchList1[
                                                                            index]
                                                                        .id
                                                                    : filter1[
                                                                            index]
                                                                        .id,
                                                              )));
                                                },
                                                child: vendorDisplay(
                                                    width,
                                                    search1
                                                        ? searchList1[index]
                                                        : filter1[index]));
                                          }),
                                    ],
                                  ),
                                )),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: width * 0.05),
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      controller: searchCon2,
                                      onChanged: (V) {
                                        if (searchCon2.text.trim().isEmpty) {
                                          search2 = false;
                                        } else if (searchCon2.text
                                            .trim()
                                            .isNotEmpty) {
                                          searchList2 = [];
                                          for (var v in filter1) {
                                            if (v.name!.toLowerCase().contains(
                                                searchCon2.text
                                                    .trim()
                                                    .toLowerCase())) {
                                              searchList2.add(v);
                                            }
                                          }
                                          search2 = true;
                                        }
          
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              data.subs = true;
                                              print(daily.length);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Filter(
                                                            cusines: daily,
                                                          ))).then((value) {
                                                if (data.filterApplied) {
                                                  search2 = false;
                                                  searchCon2.clear();
                                                  filter2 = [];
                                                  if (data.cusineSelected2) {
                                                    // filter1 = [];
                                                    for (var v in vendors) {
                                                      for (var b in v.menu.monday
                                                          .breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.monday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.monday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu.tuesday
                                                          .breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.tuesday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.tuesday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu
                                                          .wednesday.breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.wednesday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v.menu
                                                          .wednesday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu
                                                          .thursday.breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.thursday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.thursday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu.friday
                                                          .breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.friday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.friday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu
                                                          .saturday.breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.saturday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.saturday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var b in v.menu.sunday
                                                          .breakfast) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (b.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var l in v
                                                          .menu.sunday.lunch) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (l.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                      for (var d in v
                                                          .menu.sunday.dinner) {
                                                        for (var f in data
                                                            .filteredList) {
                                                          if (d.name == f.name) {
                                                            filter2.add(v);
                                                            // break;
                                                          }
                                                        }
                                                      }
                                                    }
                                                    filter2 =
                                                        filter2.toSet().toList();
                                                  } else {
                                                    for (var v in vendors) {
                                                      filter2.add(v);
                                                    }
                                                  }
                                                }
                                                setState(() {});
                                              });
                                            },
                                            child: Icon(
                                              Icons.list,
                                              color: color.orange,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(40, 15, 12, 15),
          
                                          // filled: true,
                                          // fillColor: color.textFieldFillColor,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: color.purple, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: color.orange, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: color.purple, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: color.orange, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          hintText: "Search",
                                          errorText: "",
                                          labelText: "Search",
                                          labelStyle:
                                              TextStyle(color: color.purple)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: search2
                                            ? searchList2.length
                                            : filter2.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SubscriptionMenu(
                                                              chef: search1
                                                                  ? searchList1[
                                                                      index]
                                                                  : filter1[
                                                                      index],
                                                              user: data.user,
                                                              vendorID: search1
                                                                  ? searchList1[
                                                                          index]
                                                                      .id
                                                                  : filter1[index]
                                                                      .id,
                                                            )));
                                              },
                                              child: vendorDisplay(
                                                  width,
                                                  search2
                                                      ? searchList2[index]
                                                      : filter2[index]));
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Center(
                              child: Text("Coming Soon",
                                style: TextStyle(
                                    fontSize: 50.0,),
                                
                              )
                            ),
                          ),
                        ],
                      ),
          )),
    );
  }

  Widget vendorDisplay(width, Chef chef) {
    print(endpoint.picBase + chef.logo!);
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 8,
          color: color.textFieldFillColor,
          // child: Container(
          //   decoration:
          //       BoxDecoration(borderRadius: BorderRadius.circular(20)),
          //   padding: EdgeInsets.all(20),
          //   width: width,
          //   // height: 250,
          //   child: Column(
          //     children: [
          //       Text(
          //         'title',
          //         style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //             color: Color(0xFF24243e)),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
          //         child: Divider(
          //           thickness: 3,
          //           color: Colors.grey[300],
          //         ),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Card(
          //             // child: CachedNetworkImage(
          //             //   imageUrl: "https://darat.pythonanywhere.com/" +
          //             //       searchlist[index].logo,
          //             //   imageBuilder: (context, imageProvider) => Container(
          //             //     height: 125,
          //             //     width: 125,
          //             //     decoration: BoxDecoration(
          //             //       image: DecorationImage(
          //             //         image: imageProvider,
          //             //         fit: BoxFit.fill,
          //             //       ),
          //             //     ),
          //             //   ),
          //             // placeholder: (context, url) =>
          //             //     Center(child: CircularProgressIndicator()),
          //             // errorWidget: (context, url, error) =>
          //             //     Icon(Icons.error),
          //             child: Container(
          //               height: 125,
          //               width: 125,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: AssetImage('assets/images.jpg'),
          //                   fit: BoxFit.fill,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             height: 100,
          //             // padding: EdgeInsets.symmetric(vertical: 20),
          //             child: VerticalDivider(
          //               color: Colors.grey[400],
          //               thickness: 2,
          //             ),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Container(
          //                 width: width / 4,
          //                 child: AutoSizeText(
          //                   'Rating',
          //                   overflow: TextOverflow.ellipsis,
          //                   maxLines: 1,
          //                   style: TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.w600,
          //                       color: Color(0xFF24243e)),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Icon(
          //                     Icons.location_on_rounded,
          //                     size: 17,
          //                   ),
          //                   Container(
          //                     width: width / 5,
          //                     margin: EdgeInsets.only(left: 0),
          //                     child: Text(
          //                       'Karachi',
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: endpoint.picBase + chef.logo!,
                      height: width * 0.4,
                      width: width * 0.85,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: color.purple,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          chef.label!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: color.purple,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chef.name!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      chef.rating == 0.0
                          ? Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Rating not available",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              child: RatingStars(
                                value: chef.rating,
                                starBuilder: (index, color) => Icon(
                                  Icons.star,
                                  color: color,
                                ),
                                starCount: 5,
                                starSize: 20,
                                valueLabelColor: const Color(0xff9b9b9b),
                                valueLabelTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                valueLabelRadius: 10,
                                maxValue: 5,
                                starSpacing: 2,
                                maxValueVisibility: true,
                                valueLabelVisibility: true,
                                animationDuration: Duration(milliseconds: 1000),
                                valueLabelPadding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 8),
                                valueLabelMargin:
                                    const EdgeInsets.only(right: 8),
                                starOffColor: const Color(0xffe7e8ea),
                                starColor: Colors.yellow,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
