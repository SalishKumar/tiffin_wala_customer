import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:string_validator/string_validator.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

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
  Database db = Database();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  final storage = FlutterSecureStorage();

  inputName() {
    //print(val + '*');
    bool isValid = true;
    List<String> tempName = nameCon.text.trim().split(" ");
    for (var name in tempName) {
      if (isAlpha(name) == false) {
        isValid = false;
        break;
      }
    }
    if (isValid) {
      nameError = '';
    } else {
      if (nameCon.text.trim().isNotEmpty) {
        nameError = 'Name Format is not correct';
      } else {
        nameError = 'Name is empty.';
      }
    }
  }

  inputEmail() {
    //print(val + '*');
    bool isValid = isEmail(emailCon.text.trim());
    if (isValid) {
      emailError = '';
    } else {
      if (emailCon.text.trim().isNotEmpty) {
        emailError = 'Email Format is not correct';
      } else {
        emailError = 'Email is empty.';
      }
    }
  }

  autoLogin(User1 user) async {
    disposeTestControllers();
    LoginViewModel().disposeControllers();
    await storage.write(key: 'name', value: user.name);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'password', value: user.password);
    await storage.write(key: 'google', value: user.google.toString());
    await storage.write(key: 'token', value: user.token);
  }

  disposeTestControllers(){
    nameCon.text='';
    emailCon.text='';
    phoneCon.text='';
    passCon.text='';
    confirmPassCon.text='';
  }

  inputPhone() {
    //print(val + '*');
    String pattern = r'^(?=.*?[0-9]).{11}$';
    RegExp regExp = new RegExp(pattern);
    bool isValid = regExp.hasMatch(phoneCon.text.trim());
    if (isValid) {
      phoneError = '';
    } else {
      if (phoneCon.text.trim().isNotEmpty) {
        phoneError = 'Phone Format is not correct';
      } else {
        phoneError = 'Phone is empty.';
      }
    }
  }

  inputPass() {
    //print(val + '*');
    // bool isValidText = isAlpha(passCon.text.trim());
    // print('alpha = '+ isValidText.toString());
    // bool isValidNumeric = isNumeric(passCon.text.trim());
    // print('numbers = '+ isValidNumeric.toString());
    String pattern = r'^(?=.*[a-z])(?=.*[0-9])[a-z0-9]+$';
    RegExp regExp = new RegExp(pattern);
    bool isValid = regExp.hasMatch(passCon.text.trim());
    print(isValid);
    if (isValid) {
      if (passCon.text.trim().length > 5) {
        passError = '';
      } else {
        passError = 'Password is too short.';
      }
    } else {
      if (passCon.text.trim().isNotEmpty) {
        passError = 'Password Format is not correct.';
      } else {
        passError = 'Password is empty.';
      }
    }
  }

  comparePass() {
    //print(val + '*');
    if (passCon.text.trim() == confirmPassCon.text.trim()) {
      confirmPassError = '';
    } else {
      if (confirmPassCon.text.trim().isNotEmpty) {
        confirmPassError = 'Passwords does not match.';
      } else {
        confirmPassError = 'Password is empty.';
      }
    }
  }

  toggleSuffix1() {
    obsecure1 = !obsecure1;
    if (obsecure1) {
      suffix1 = Icons.visibility;
    } else {
      suffix1 = Icons.visibility_off;
    }
    notifyListeners();
  }

  toggleSuffix2() {
    obsecure2 = !obsecure2;
    if (obsecure2) {
      suffix2 = Icons.visibility;
    } else {
      suffix2 = Icons.visibility_off;
    }
    notifyListeners();
  }

  Future register(BuildContext context) async {
    if ((nameCon.text.trim().isNotEmpty && nameError == "") &&
        (emailCon.text.trim().isNotEmpty && emailError == "") &&
        (phoneCon.text.trim().isNotEmpty && phoneError == "") &&
        (passCon.text.trim().isNotEmpty && passError == "") &&
        (confirmPassCon.text.trim().isNotEmpty && confirmPassError == "")) {
      User1 user = User1(
          name: nameCon.text,
          email: emailCon.text,
          phone: phoneCon.text,
          password: passCon.text);
      user.google = false;
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
      dynamic result = await db.register(user.toJSON());
      Navigator.pop(context);
      if (result != null) {
        User1 userResult = User1.fromJson(result);
        if (userResult.status == true) {
          userResult.google = false;
          await autoLogin(userResult);
          data.user = userResult;
          Navigator.pushReplacementNamed(context, Home.routeName);
        } else if (userResult.status == false) {
          Fluttertoast.showToast(
              msg: userResult.msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Registration form is not correct.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  GoogleSignInAccount get _user => _currentUser!;

  Future googleLogin(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _currentUser = googleUser;
      String? access, id;
      await googleUser.authentication.then((value) async {
        if (value != null) {
          access = value.accessToken;
          id = value.idToken;
        }
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(
              GoogleAuthProvider.credential(idToken: id, accessToken: access));
      phoneCon.text = '';
      phoneError = '';

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
      dynamic result = await db.loginGoogle(_currentUser?.id);
      Navigator.pop(context);

      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        User1 userResult = User1.fromJson(result);
        if (userResult.status == true) {
          userResult.google = true;
          await autoLogin(userResult);
          data.user = userResult;
          Navigator.pushReplacementNamed(context, Home.routeName);
        } else if (userResult.status == false) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
                title: Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: Container(
                  // width: MediaQuery.of(context).size.width * 0.6,
                  // height: 300,
                  child: MyCustomTextfieldWithoutSuffix(
                    size: 11,
                    textInputType: TextInputType.phone,
                    prefix: Icons.phone,
                    hintText: 'Phone',
                    error: phoneError,
                    controller: phoneCon,
                    lines: 1,
                    onValidation: () {
                      inputPhone();
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      if (phoneCon.text.trim().isNotEmpty && phoneError == "") {
                        User1 user = User1(
                            email: _currentUser?.email,
                            name: _currentUser?.displayName,
                            password: _currentUser?.id,
                            phone: phoneCon.text.trim());
                        user.google = true;
                        //Navigator.pop(context);
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

                        dynamic result1 =
                            await db.registerGoogle(user.toJSON());
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (result1 == null) {
                          Fluttertoast.showToast(
                              msg: 'Issue with connection. Try again later.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          User1 userResult1 = User1.fromJson(result1);

                          if (userResult1.status == true) {
                            userResult.google = true;
                            await autoLogin(userResult);
                            data.user = userResult;
                            Navigator.pushReplacementNamed(
                                context, Home.routeName);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Issue with connection. Try again later.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      } else {
                        if (phoneCon.text.trim().isNotEmpty) {
                          Fluttertoast.showToast(
                              msg: phoneError,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Phone is Empty',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        }
      }

      notifyListeners();

      if (_currentUser != null) {
        print(
            '${_currentUser?.email} + ${_currentUser?.displayName} + ${_currentUser?.id}');
      }
    } catch (error) {
      print(error);
    }
  }
}
