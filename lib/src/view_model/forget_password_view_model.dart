import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;

class ForgetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailOrPassCon = TextEditingController();
  String emailOrPassError = '';
  Database db = Database();

  Future forgetPass(BuildContext context) async {
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
    dynamic result = await db.forget(emailOrPassCon.text.trim());
    Navigator.pop(context); //pop dialog
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
      if (result['status'] == true) {
        emailOrPassCon.text = '';
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: AlertDialog(
                  title: Text("Success"),
                  content: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(result['message'])),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        //style: TextStyle(color: color.dark),
                      ),
                    ),
                  ],
                ),
              );
            });
      } else {
        Fluttertoast.showToast(
            msg: result['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
