import 'package:flutter/material.dart';
import 'color.dart' as color;

class tfield extends StatelessWidget {
  tfield({
    Key? key,
    required this.textInputType,
    required this.onPressed,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    required this.hintText,
    required this.error,
    required this.onValidation,
    required this.size,
    required this.label,
    required this.disable,
    this.value,
  }) : super(key: key);

  late TextInputType textInputType;
  late Function onPressed;
  Function onValidation = (String v) {};

  bool obscureText = false,disable=false;
  String? value;
  int size;
  IconData? prefix;
  IconData? suffix;
  String error, hintText, label;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      initialValue: value,
      obscureText: obscureText,
      maxLength: size,
      autofocus: false,
      enabled: disable,
      // maxLines: maxLines,
      onChanged: (V) {
        onValidation(V);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: color.orange,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Icon(
            suffix,
            color: color.orange,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(40, 15, 12, 15),

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
        errorMaxLines: 3,
        labelText: label,
        labelStyle: TextStyle(color: color.purple)
      ),
    );
  }
}
