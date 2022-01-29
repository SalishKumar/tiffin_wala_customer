import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;

class CustomButton extends StatelessWidget {
  double width;
  String title;
  CustomButton({
    Key? key,
    required this.width,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width * 0.9,
      height: 60,
      child: Container(
        
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.purple,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.orange, width: 2)
        ),
        child: Center(
          child: Text(
            '$title',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}