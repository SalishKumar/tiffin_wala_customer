import 'package:flutter/material.dart';
import 'color.dart' as color;

class MyCustomTextfieldWithoutSuffix extends StatelessWidget {
  MyCustomTextfieldWithoutSuffix({
    Key? key,
    required this.textInputType,
    this.prefix,
    required this.hintText,
    required this.error,
    required this.controller,
    required this.onValidation,
    required this.lines,
    required this.size,
    required this.width,
  }) : super(key: key);

  late TextInputType textInputType;
  late Function onPressed;
  int size;
  Function onValidation = () {};
  int lines;
  IconData? prefix;
  String error, hintText;
  double width;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        onChanged: (V) {
          onValidation();
        },
        maxLength: size,
        maxLines: lines,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefix,
            color: color.orange,
          ),
          hintMaxLines: 1,
          hintTextDirection: TextDirection.ltr,
          alignLabelWithHint: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: 15),

          // filled: true,
          // fillColor: color.textFieldFillColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color.purple, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color.orange, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: error == ''
                ? BorderSide(color: color.purple, width: 1.0)
                : BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: error == ''
                ? BorderSide(color: color.orange, width: 1.0)
                : BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hintText,
          errorText: error,
          labelText: hintText,
          labelStyle: TextStyle(color: color.purple)
        ),
      ),
    );
  }
}
