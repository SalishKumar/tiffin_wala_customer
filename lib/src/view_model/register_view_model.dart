import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';


class RegisterViewModel extends ChangeNotifier {
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();
  String nameError = '';
  String emailError = '';
  String phoneError = '';
  String passError = '';
  String confirmPassError = '';
  IconData suffix1 = Icons.visibility;
  bool obsecure1 = true;
  IconData suffix2 = Icons.visibility;
  bool obsecure2 = true;

  inputName(){
    //print(val + '*');
    bool isValid = isAlpha(nameCon.text.trim());
    if(isValid){
      nameError = '';
    } else {
      if(nameCon.text.trim().isNotEmpty){
        nameError = 'Name Format is not correct';
      } else{
        nameError = 'Name is empty.';
      }
    }
  }

  inputEmail(){
    //print(val + '*');
    bool isValid = isEmail(emailCon.text.trim());
    if(isValid){
      emailError = '';
    } else {
      if(emailCon.text.trim().isNotEmpty){
        emailError = 'Email Format is not correct';
      } else{
        emailError = 'Email is empty.';
      }
    }
  }

  inputPhone(){
    //print(val + '*');
    String  pattern = r'^(?=.*?[0-9]).{11}$';
    RegExp regExp = new RegExp(pattern);
    bool isValid = regExp.hasMatch(passCon.text.trim());
    if(isValid){
      phoneError = '';
    } else {
      if(phoneCon.text.trim().isNotEmpty){
        phoneError = 'Phone Format is not correct';
      } else{
        phoneError = 'Phone is empty.';
      }
    }
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

  comparePass(){
    //print(val + '*');
    if(passCon.text.trim() == confirmPassCon.text.trim()){
      confirmPassError = '';
    } else {
      if(confirmPassCon.text.trim().isNotEmpty){
        confirmPassError = 'Passwords does not match.';
      } else{
        confirmPassError = 'Password is empty.';
      }
    }
  }

  toggleSuffix1(){
    obsecure1 = !obsecure1;
    if(obsecure1){
      suffix1 = Icons.visibility;
    } else {
      suffix1 = Icons.visibility_off;
    }
    notifyListeners();
  }

  toggleSuffix2(){
    obsecure2 = !obsecure2;
    if(obsecure2){
      suffix2 = Icons.visibility;
    } else {
      suffix2 = Icons.visibility_off;
    }
    notifyListeners();
  }
}
