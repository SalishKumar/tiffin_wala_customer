import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/models/voucher.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class Vouchers extends StatefulWidget {
  static const routeName = '/vouchers';

  User1? user1;

  Vouchers({Key? key, this.user1}) : super(key: key);
  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  bool isData = true;
  bool loading = true;
  Database db = Database();
  List<Voucher> vouchers = [];

  Future getVoucher() async{
    Map<String, dynamic> map = {
      "customer_id": widget.user1?.id,
    };
    dynamic result = await db.getVouchers(map);
    if(result != null){
      if (result['Timeout'] == 'true') {
        Fluttertoast.showToast(
            msg: 'Your request has been timmed-out. Try again.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if(result["status"]){
        vouchers = [];
        for(var v in result["message"]){
          vouchers.add(Voucher.fromJson(v));
        }
      }else if(result["status"]==false){
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
    loading = false;
    if(vouchers.isEmpty){
      isData = false;
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    getVoucher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vouchers",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: loading
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
              : Container(
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: isData ? Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: vouchers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {},
                        child: voucherBox(
                          vouchers[index],
                          width,
                          context,
                        ));
                  }),
            ):Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text("No Vouchers Available",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget voucherBox(Voucher voucher, double width, BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: color.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "${voucher.percentage}% Off",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                voucher.code!,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.35,
                  child: AutoSizeText(
                    "RS. ${voucher.min_amount} minimum",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Container(
                  width: width * 0.35,
                  child: AutoSizeText(
                    "Valid until ${voucher.expiry!.day} ${voucher.expiry!.month} ${voucher.expiry!.year}",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
