import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/logo.dart';
import 'package:tiffin_wala_customer/src/models/complain.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/complain_timeline.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ComplainList extends StatefulWidget {
  static const routeName = '/complainList';
  User1? user;
  ComplainList({ Key? key, this.user}) : super(key: key);

  @override
  State<ComplainList> createState() => _ComplainListState();
}

class _ComplainListState extends State<ComplainList> {

  List<Complain> pending = [];
  List<Complain> resolved = [];
  bool loading = true;
  bool isPending = false;
  bool isResolved = false;
  Database db = Database();

  Future getComplaint() async {
    Map<String, dynamic> map = {
      "customer_id": widget.user?.id,
    };
    dynamic result = await db.getComplains(map);
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
        pending = [];
        resolved = [];
        var message = result["message"];
        if (message != null) {
          for (var complain in message) {
            var status = complain["is_resolved"];
            if (status == true) {
              resolved.add(Complain.fromJson(complain));
            } else if (status == false) {
              pending.add(Complain.fromJson(complain));
            }
          }
          print("here");
        }
      } else if (result["status"] == false) {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    // loading = false;
    if (pending.isNotEmpty) {
      isPending = true;
    }
    if (resolved.isNotEmpty) {
      isResolved = true;
    }
    
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getComplaint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Complains",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: color.purple,
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: AutoSizeText(
                  "Pending",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: AutoSizeText(
                  "Resolved",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: color.background,
        body: loading
            ? Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
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
            : TabBarView(
              children: [
                isPending ? SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
                    child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pending.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainTimeline(complain: pending[index],)));
                                  },
                                  child: complainBox(
                                    width, pending[index]
                                    ));
                            }),
                        
                      
                  ),
                ):Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Pending Complain Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        isResolved ? SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
                    child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resolved.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainTimeline(complain: resolved[index],)));
                                  },
                                  child: complainBox(
                                    width, resolved[index]
                                    ));
                            }),
                        
                      
                  ),
                ):Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "No Resolved Complain Available",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
              ],
            ),
      ),
    );
  }

  Widget complainBox(width, Complain complain){
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.35,
              child: Text(
                "${complain.kitchenName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: width * 0.35,
              child: Text(
                complain.desc!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
