import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';

class Review extends StatefulWidget {
  static const routeName = '/review';
  int? id;
  Review({Key? key, this.id}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController text = TextEditingController();
  double rating = 0.0;
  Database db = Database();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                MyCustomTextfieldWithoutSuffix(
                    size: 500,
                    width: width * 0.9,
                    lines: 5,
                    textInputType: TextInputType.text,
                    hintText: 'Describe Your Experience (optional)',
                    prefix: Icons.note,
                    error: '',
                    controller: text,
                    onValidation: () {}),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: width * 0.45,
                  child: AutoSizeText(
                    "Rate Your Experience",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: RatingStars(
                    value: rating,
                    onValueChanged: (v) {
                      rating = v;
                      setState(() {});
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                    ),
                    starCount: 5,
                    starSize: 30,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 2.5,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: Duration(milliseconds: 1000),
                    valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () async {
              if(rating != 0.0){
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
          Map<String, dynamic> map = {};
          map = {
            "order_id": widget.id!,
            "description": text.text.trim(),
            "rating": rating
          };
          dynamic result = await db.reviewOrder(map);
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
              Fluttertoast.showToast(
                  msg: result["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
                  data.rating = rating;
              Navigator.pop(context);
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
              }else{
                Fluttertoast.showToast(
                  msg: "Give Rating",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              }
              // Navigator.pop(context);
              // Navigator.pop(context);
            },
            child: CustomButton(
              width: width,
              title: "Submit",
            )),
      ),
    );
  }
}
