import 'package:flutter/material.dart';
import 'color.dart' as color;

class CustomWidgets {
  Widget textField(Function(String) onChanged, TextInputType textInputType,
      bool obsecure, int maxLines, String hint, String error,
      {prefix, suffix, onPressed}) {
    return TextField(
      onChanged: (val) {
        print(val);
        onChanged(val);
      },
      keyboardType: textInputType,
      obscureText: obsecure ? true : false,
      maxLines: maxLines,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
        prefix: Container(
                margin: EdgeInsets.only(right: 5, top: 10),
                child: Icon(
                  prefix,
                  color: color.orange,
                ),
              ),
        suffix: Container(
                margin: EdgeInsets.only(left: 5, top: 10),
                child: IconButton(
                  icon: Icon(suffix),
                  color: color.orange,
                  onPressed: () {
                    onPressed;
                    obsecure = !obsecure;
                    print(obsecure);
                  },
                  
                ),
              ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        filled: true,
        fillColor: color.textFieldFillColor,
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
        hintText: hint,
        errorText: error,
        labelText: hint,
      ),
    );
  }
}
