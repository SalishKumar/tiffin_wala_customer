import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/register_view_model.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailCon = TextEditingController();
  String emailError = '';
  TextEditingController passCon = TextEditingController();
  String passError = '';
  IconData suffix = Icons.remove_red_eye;
  bool obsecure = true;
  Database db = Database();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  TextEditingController phoneCon = TextEditingController();
  String phoneError = '';
  final storage = FlutterSecureStorage();

  inputEmail() {
    notifyListeners();
  }

  inputPass() {}

  toggleSuffix() {
    obsecure = !obsecure;
    if (obsecure) {
      suffix = Icons.visibility;
    } else {
      suffix = Icons.visibility_off;
    }
    notifyListeners();
  }

  autoLogin(User1 user) async {
    disposeControllers();
    RegisterViewModel().disposeTestControllers();
    await storage.write(key: 'name', value: user.name);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'password', value: user.password);
    await storage.write(key: 'google', value: user.google.toString());
    await storage.write(key: 'token', value: user.token);
  }

  disposeControllers() {
    emailCon.text = '';
    passCon.text = '';
  }

  Future login(BuildContext context) async {
    if ((emailCon.text.trim().isNotEmpty && emailError == "") &&
        (passCon.text.trim().isNotEmpty && passError == "")) {
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
      dynamic result =
          await db.login(emailCon.text.trim(), passCon.text.trim());
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
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Login form is not correct.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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

  Future googleLogin(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
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
      if (googleUser == null) {
        Navigator.pop(context);
        return;
      }
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
          _googleSignIn.signOut();
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                        _googleSignIn.signOut();
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
                            //_googleSignIn.signOut();
                            userResult1.google = true;
                            await autoLogin(userResult1);
                            data.user = userResult1;
                            Navigator.pushReplacementNamed(
                                context, Home.routeName);
                          } else {
                            Fluttertoast.showToast(
                                msg: userResult1.msg,
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
                      _googleSignIn.signOut();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'Issue with connection. Try again later.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }
}
