
import 'package:flutter/material.dart';
import 'color.dart' as color;



class MyCustomTextfield extends StatelessWidget {
   MyCustomTextfield({
    Key? key,
    required this.textInputType,
     required this.onPressed,
      this.obscureText = false,
     this.prefix,
     this.suffix,
     required this.hintText,
     required this.error,
     required this.controller,
     required this.onValidation,

   }) : super(key: key);

  late TextInputType textInputType;
  late Function onPressed;
    Function onValidation= (){};

   bool obscureText = false;
  IconData? prefix;
   IconData? suffix;
    String error,hintText;
    TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextField(

      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      // maxLines: maxLines,
      onChanged: (V){
        onValidation();
      },
      decoration: InputDecoration(

        prefixIcon:  Icon(
          prefix,
          color: color.orange,
        ),
        suffixIcon: GestureDetector(
          onTap: (){
            onPressed();
          },
          child: Icon(
            suffix,
            color: color.orange,
          ),
        ),
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
      ),
    );
  }
}
