import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';


class LoginViewModel extends ChangeNotifier {
  TextEditingController emailCon = TextEditingController();
  String emailError = '';
  TextEditingController passCon = TextEditingController();
  String passError = '';
  IconData suffix = Icons.visibility_off;
  bool obsecure = true;

  inputEmail(){
    bool isValid = isEmail(emailCon.text.trim());
    if(isValid){

      emailError = '';
    } else {
      if(emailCon.text.trim().isNotEmpty){
        // emailCon.clear();

        emailError = 'Email Format is not correct';
      } else{
        emailError = 'Enter email.';
      }

    }
    notifyListeners();
  }

  // inputPass(String val){
  //   print(val + '*');
  //   bool isValid = isAlphanumeric(val);
  //   if(isValid){
  //     if(val.length>5){
  //       pass.text = val;
  //       passError = '';
  //     } else {
  //       passError = 'Password is too short.';
  //     }
  //
  //   } else {
  //     if(val.isNotEmpty){
  //       email.text = '';
  //       emailError = 'Password Format is not correct.';
  //     } else{
  //       emailError = 'Password email.';
  //     }
  //
  //   }
  // }

  toggleSuffix(){
    obsecure = !obsecure;
    notifyListeners();
  }
}
