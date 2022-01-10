import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/view_model/register_view_model.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';

class Register extends StatelessWidget {
  static const routeName = '/register';

  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Consumer<LoginViewModel>(
              builder: (context, loginViewModel, child) {
            return Container(
              child: Text("data")
              // Column(
              //   children: [
              //     SizedBox(
              //       height: 200,
              //     ),
              //     customWidgets.textField(
              //         loginViewModel.inputEmail,
              //         TextInputType.name,
              //         false,
              //         1,
              //         'Name',
              //         loginViewModel.emailError,
              //         prefix: Icons.person),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     customWidgets.textField(
              //         loginViewModel.inputEmail,
              //         TextInputType.emailAddress,
              //         false,
              //         1,
              //         'Email',
              //         loginViewModel.emailError,
              //         prefix: Icons.email),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     customWidgets.textField(
              //         loginViewModel.inputEmail,
              //         TextInputType.phone,
              //         false,
              //         1,
              //         'Phone',
              //         loginViewModel.emailError,
              //         prefix: Icons.phone),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     customWidgets.textField(
              //         loginViewModel.inputPass,
              //         TextInputType.visiblePassword,
              //         loginViewModel.obsecure,
              //         1,
              //         'Password',
              //         loginViewModel.passError,
              //         prefix: Icons.vpn_key,
              //         suffix: loginViewModel.suffix,
              //         onPressed: loginViewModel.toggleSuffix),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     customWidgets.textField(
              //         loginViewModel.inputPass,
              //         TextInputType.visiblePassword,
              //         loginViewModel.obsecure,
              //         1,
              //         'Confirm Password',
              //         loginViewModel.passError,
              //         prefix: Icons.vpn_key,
              //         suffix: loginViewModel.suffix,
              //         onPressed: loginViewModel.toggleSuffix),
              //     SizedBox(
              //       height: 40,
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Center(
              //           child: Container(
              //         width: width * 0.33,
              //         padding: EdgeInsets.all(20),
              //         alignment: Alignment.center,
              //         child: Text(
              //           "Register",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //               fontSize: 24),
              //         ),
              //         decoration: BoxDecoration(
              //             color: color.purple,
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(color: color.orange, width: 2)),
              //       )),
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     Center(
              //       child: Text(
              //         'OR',
              //         style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     Container(
              //       alignment: Alignment.center,
              //       child: SignInButton(
              //         Buttons.Google,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         text: "Register with Google",
              //         onPressed: () {},
              //       ),
              //     ),
              //   ],
              // ),


            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?  ",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
              child: Text(
                "Login.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
