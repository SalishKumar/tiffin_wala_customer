import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';


class LoginViewModel extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  String emailError = '';
  TextEditingController pass = TextEditingController();
  String passError = '';
  IconData suffix = Icons.visibility_off;
  bool obsecure = true;

  inputEmail(String val){
    print(val + '*');
    bool isValid = isEmail(val);
    if(isValid){
      email.text = val;
      emailError = '';
    } else {
      if(val.isNotEmpty){
        email.text = '';
        emailError = 'Email Format is not correct';
      } else{
        emailError = 'Enter email.';
      }
      
    }
  }

  inputPass(String val){
    print(val + '*');
    bool isValid = isAlphanumeric(val);
    if(isValid){
      if(val.length>5){
        pass.text = val;
        passError = '';
      } else {
        passError = 'Password is too short.';
      }
      
    } else {
      if(val.isNotEmpty){
        email.text = '';
        emailError = 'Password Format is not correct.';
      } else{
        emailError = 'Password email.';
      }
      
    }
  }

  toggleSuffix(){
    suffix = Icons.visibility;
    obsecure = !obsecure;
  }
}
