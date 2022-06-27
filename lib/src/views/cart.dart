import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/models/voucher.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/views/payment_and_address.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart';
  List<Item1>? cart;
  bool? subscription;
  User1? user;
  int? vendorID;
  Cart({Key? key, this.cart, this.subscription, this.user, this.vendorID})
      : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController promo = TextEditingController();
  double total = 0.0;
  double total1 = 0.0;
  String code = "";
  Database db = Database();
  List<Voucher> vouchers = [];
  bool isData = false;
  bool voucherApplied = false;
  DateTime start = DateTime.now().add(Duration(days: 1)),
      end = DateTime.now().add(Duration(days: 2));
  bool datesApplied = false;
  bool enablePromo = true;

  @override
  void initState() {
    if (widget.subscription!) {
    } else {
      for (var c in widget.cart!) {
        total += c.price * c.quantity;
      }
    }
    total1 = total;
    if(widget.subscription!){
      enablePromo = false;
    }else{
      enablePromo = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.purple,
        elevation: 0,
        title: const Text(
          "Item Carts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: const Text(
                  "Your Food Cart",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3a3a3b),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.cart!.length,
                  itemBuilder: (context, index) {
                    return cartItem(
                        widget.cart![index], index, widget.subscription!);
                  }),
              const SizedBox(
                height: 10,
              ),
              if (widget.subscription!) startAndEndDate(width),
              const SizedBox(
                height: 10,
              ),
              promoWidget(width),
              const SizedBox(
                height: 10,
              ),
              totalCalculationWidget(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () {
              if(widget.subscription!){
                if(datesApplied){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentAndAddress(
                            user: widget.user,
                            cart: widget.cart,
                            vendorID: widget.vendorID,
                            code: code,
                            total: total,
                            total1: total1,
                            voucherApplied: voucherApplied,
                            start: start,
                            end: end,
                            subs: widget.subscription,
                          )));
                }else{
                  Fluttertoast.showToast(
                  msg: "Apply Start and End Dates",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
                }
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentAndAddress(
                            user: widget.user,
                            cart: widget.cart,
                            vendorID: widget.vendorID,
                            code: code,
                            total: total,
                            total1: total1,
                            voucherApplied: voucherApplied,
                            subs: widget.subscription,
                          )));
              }
            },
            child: CustomButton(
              width: width,
              title: "Payment and Address",
            )),
      ),
    );
  }

  Widget cartItem(Item1 item, index, bool subs) {
    print(subs);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    subs == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${item.quantity} X ${item.name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  item.desc,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  "RS ${item.price}/=",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${item.day} - ${item.type}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  "${item.quantity} X ${item.name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  item.desc,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  "RS ${item.price}/=",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.cart![index].quantity = 0;
                        widget.cart!.removeAt(index);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/ic_delete.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerRight,
                  child: addQuantity(item, index),
                )
              ],
            ),
          )),
    );
  }

  Widget promoWidget(width) {
    return SafeArea(
      child: voucherApplied
          ? Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Voucher Applied: ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        code,
                        style: TextStyle(fontSize: 18, color: color.purple),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      voucherApplied = false;
                      total1 = total;
                      setState(() {});
                    },
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFfae3e2).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ]),
                  child: TextFormField(
                    autofocus: false,
                    enabled: enablePromo,
                    keyboardType: TextInputType.text,
                    controller: promo,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: color.orange, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: color.purple, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: color.orange, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: color.purple, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Add Your Promo Code',
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.local_offer,
                              color: color.purple,
                            ),
                            onPressed: () async {
                              await getVouchers();
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  controller: ModalScrollController.of(context),
                                  child: isData
                                      ? Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: vouchers.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                    onTap: () {
                                                      promo.text =
                                                          vouchers[index].code!;
                                                      Navigator.pop(context);
                                                    },
                                                    child: voucherBox(
                                                      vouchers[index],
                                                      width,
                                                      context,
                                                    ));
                                              }),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Center(
                                              child: Text(
                                            "No Vouchers Available",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ),
                                ),
                              );
                            })),
                  ),
                ),
                //SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async {
                    print("Apply");
                    await applyVoucher();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 20,
                        color: enablePromo ? color.purple : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget startAndEndDate(width) {
    return Container(
      padding: const EdgeInsets.only(left: 3, right: 3),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ]),
      child: datesApplied
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Start Date",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${start.day}-${start.month}-${start.year}",
                          style: TextStyle(fontSize: 18, color: color.purple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "End Date",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${end.day}-${end.month}-${end.year}",
                          style: TextStyle(fontSize: 18, color: color.purple),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async{
                    start = DateTime.now().add(Duration(days: 1));
                    end = DateTime.now().add(Duration(days: 2));
                    await dilogueBox1("Warning", "Removal of Start and End Dates woul cause removal of voucher too. Proceed?");
                  },
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Start Date",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width * 0.4,
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: 'dd-MM-yyyy',
                            initialValue: DateTime.now()
                                .add(Duration(days: 1))
                                .toString(),
                            firstDate: DateTime.now().add(Duration(days: 1)),
                            lastDate: DateTime(3000),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Start Date',
                            onChanged: (val) {
                              start = DateTime.parse(val);
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.purple, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.purple, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "End Date",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width * 0.4,
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: 'dd-MM-yyyy',
                            initialValue: DateTime.now()
                                .add(Duration(days: 2))
                                .toString(),
                            firstDate: DateTime.now().add(Duration(days: 2)),
                            lastDate: DateTime(3000),
                            icon: Icon(Icons.event),
                            dateLabelText: 'End Date',
                            onChanged: (val) => end = DateTime.parse(val),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.purple, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: color.purple, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    applyDates();
                    total = getTotal();
                    total1 = total;
                    enablePromo = true;
                    setState(() {});
                    
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 20,
                        color: color.purple,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future dilogueBox1(header, msg) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            elevation: 0,
            title: Text(
              header,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
              // width: MediaQuery.of(context).size.width * 0.6,
              // height: MediaQuery.of(context).size.height * 0.15,
              child: Text(
                msg,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  voucherApplied = false;
                  datesApplied = false;
                  enablePromo = false;
                  total = 0.0;
                  total1 = total;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  return;
                },
              )
            ],
          ),
        );
      },
    );
  }


  applyDates() {
    final difference = end.difference(start).inDays;
    if (difference < 0) {
      Fluttertoast.showToast(
          msg: 'End Date cannot be less than or equal to Start Date.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      datesApplied = false;
    } else {
      datesApplied = true;
      setState(() {});
    }
  }

  double getTotal() {
    double price = 0.0;
    var difference = end.difference(start).inDays;
    difference = difference + 1;
    DateTime temp = start;
    int monday = 0,
        tuesday = 0,
        wednesday = 0,
        thursday = 0,
        friday = 0,
        saturday = 0,
        sunday = 0;
    for (int i = 1; i <= difference; i++) {
      if (temp.add(Duration(days: i)).weekday == DateTime.monday) {
        monday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.tuesday) {
        tuesday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.wednesday) {
        wednesday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.thursday) {
        thursday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.friday) {
        friday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.saturday) {
        saturday++;
      } else if (temp.add(Duration(days: i)).weekday == DateTime.sunday) {
        sunday++;
      }
    }
    //print("$monday $tuesday $wednesday $thursday $friday $saturday $sunday $difference");
    for (var item in widget.cart!) {
      if (item.day == "Monday") {
        price += (item.price * item.quantity) * monday;
      } else if (item.day == "Tuesday") {
        price += (item.price * item.quantity) * tuesday;
      } else if (item.day == "Wednesday") {
        price += (item.price * item.quantity) * wednesday;
      } else if (item.day == "Thursday") {
        price += (item.price * item.quantity) * thursday;
      } else if (item.day == "Friday") {
        price += (item.price * item.quantity) * friday;
      } else if (item.day == "Saturday") {
        price += (item.price * item.quantity) * saturday;
      } else if (item.day == "Sunday") {
        price += (item.price * item.quantity) * sunday;
      }
      //print(price);
    }
    return price;
  }

  applyVoucher() async {
    if (promo.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: color.purple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );
      code = promo.text.trim();
      Map<String, dynamic> map = {
        "customer_id": widget.user?.id,
        "order_amount": total,
        "coupon_code": code,
        "vendor_id": widget.vendorID
      };
      dynamic result = await db.validateVouchers(map);
      Navigator.pop(context);
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
          total1 = result["amount_after_discount"];
          promo.clear();
          voucherApplied = true;
          Fluttertoast.showToast(
              msg: result["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (result["status"] == false) {
          print("here");
          promo.clear();
          code = "";
          voucherApplied = false;
          Fluttertoast.showToast(
              msg: result["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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
      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: 'Enter voucher code or click tag button and select voucher',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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

  getVouchers() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: color.purple,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
    Map<String, dynamic> map = {
      "customer_id": widget.user?.id,
    };
    dynamic result = await db.getVouchers(map);
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
        vouchers = [];
        for (var v in result["message"]) {
          vouchers.add(Voucher.fromJson(v));
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
    if (vouchers.isEmpty) {
      isData = false;
    } else {
      isData = true;
    }
    setState(() {});
    Navigator.pop(context);
  }

  Widget totalCalculationWidget() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subtotal",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "PKR $total/=",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "PKR $total1/=",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addQuantity(Item1 item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.purple,
                    border: Border.all(color: color.orange, width: 2)),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      if (voucherApplied || datesApplied) {
                        dilogueBox(
                            "Warning",
                            widget.subscription!
                                ? "Change in cart would result in removal of Start and End Dates and Voucher. Proceed?"
                                : "Change in cart would result in removal of and Voucher. Proceed?",
                            "sub",
                            index,
                            widget.subscription);
                      } else {
                        if (widget.subscription!) {
                          if (widget.cart![index].quantity >= 2) {
                            
                            widget.cart![index].quantity--;
                            total = 0.0;
                            
                            total1 = total;
                          } else if (item.quantity == 1) {
                            
                            widget.cart![index].quantity = 0;
                            total = 0.0;
                            total1 = total;
                            widget.cart!.removeAt(index);
                            if (widget.cart!.isEmpty) {
                              Navigator.pop(context);
                            }
                          }
                        } else {
                          if (widget.cart![index].quantity >= 2) {
                            widget.cart![index].quantity--;
                            total -= widget.cart![index].price;
                            total1 = total;
                          } else if (item.quantity == 1) {
                            widget.cart![index].quantity = 0;
                            total -= widget.cart![index].price;
                            widget.cart!.removeAt(index);
                            total1 = total;

                            if (widget.cart!.isEmpty) {
                              Navigator.pop(context);
                            }
                          }
                        }
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove),
                    color: Colors.white,
                    iconSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 100.0,
                height: 35.0,
                child: Center(
                  child: Text(
                    "${widget.cart![index].quantity}",
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    color: color.purple,
                    border: Border.all(color: color.orange, width: 2)),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.purple,
                    border: Border.all(color: color.orange, width: 2)),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      if (voucherApplied || datesApplied) {
                        dilogueBox(
                            "Warning",
                            widget.subscription!
                                ? "Change in cart would result in removal of Start and End Dates and Voucher. Proceed?"
                                : "Change in cart would result in removal of and Voucher. Proceed?",
                            "add",
                            index,
                            widget.subscription);
                      } else {
                        if (widget.subscription!) {
                          widget.cart![index].quantity++;
                          total = 0.0;
                          total1 = total;
                        } else {
                          widget.cart![index].quantity++;
                        total += widget.cart![index].price;
                        total1 = total;
                        }
                        
                      }

                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    iconSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future dilogueBox(header, msg, op, index, subs) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            elevation: 0,
            title: Text(
              header,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
              // width: MediaQuery.of(context).size.width * 0.6,
              // height: MediaQuery.of(context).size.height * 0.15,
              child: Text(
                msg,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  if (subs) {
                    datesApplied = false;
                    voucherApplied = false;
                    enablePromo = false;
                    if (op == "add") {
                      widget.cart![index].quantity++;
                      total = 0.0;
                      total1 = total;
                    } else if (op == "sub") {
                      if (widget.cart![index].quantity >= 2) {
                        widget.cart![index].quantity--;
                        total = 0.0;
                        total1 = total;
                      } else if (widget.cart![index].quantity <= 1) {
                        widget.cart![index].quantity = 0;
                        total = getTotal();
                        total1 = total;

                        if (widget.cart!.isEmpty) {
                          Navigator.pop(context);
                        }
                      }
                    }
                  } else {
                    voucherApplied = false;

                    if (op == "add") {
                      widget.cart![index].quantity++;
                      total += widget.cart![index].price;
                    } else if (op == "sub") {
                      if (widget.cart![index].quantity >= 2) {
                        widget.cart![index].quantity--;
                        total -= widget.cart![index].price;
                      } else if (widget.cart![index].quantity <= 1) {
                        widget.cart![index].quantity = 0;
                        total -= widget.cart![index].price;
                        widget.cart!.removeAt(index);

                        if (widget.cart!.isEmpty) {
                          Navigator.pop(context);
                        }
                      }
                    }
                    total1 = total;
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  return;
                },
              )
            ],
          ),
        );
      },
    );
  }
}
