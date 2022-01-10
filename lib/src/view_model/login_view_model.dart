import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';


class LoginViewModel extends ChangeNotifier {
  TextEditingController emailCon = TextEditingController();
  String emailError = '';
  TextEditingController passCon = TextEditingController();
  String passError = '';
  IconData suffix = Icons.remove_red_eye;
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

  inputPass(){
    //print(val + '*');
    // bool isValidText = isAlpha(passCon.text.trim());
    // print('alpha = '+ isValidText.toString());
    // bool isValidNumeric = isNumeric(passCon.text.trim());
    // print('numbers = '+ isValidNumeric.toString());
    String  pattern = r'^(?=.*[a-z])(?=.*[0-9])[a-z0-9]+$';
    RegExp regExp = new RegExp(pattern);
    bool isValid = regExp.hasMatch(passCon.text.trim());
    print(isValid);
    if(isValid){
      if(passCon.text.trim().length>5){
        passError = '';
      } else {
        passError = 'Password is too short.';
      }
  
    } else {
      if(passCon.text.trim().isNotEmpty){
        passError = 'Password Format is not correct.';
      } else{
        passError = 'Password is empty.';
      }
    }
  }

  toggleSuffix(){
    obsecure = !obsecure;
    if(obsecure){
      suffix = Icons.visibility;
    } else {
      suffix = Icons.visibility_off;
    }
    notifyListeners();
  }
}
