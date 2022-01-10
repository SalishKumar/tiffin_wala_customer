import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    String input = '';
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          "Login",
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
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  MyCustomTextfield(
                    controller: loginViewModel.emailCon,
                    textInputType: TextInputType.emailAddress,
                    onPressed: () {},
                    hintText: "Email",
                    error: loginViewModel.emailError,
                    prefix: Icons.email,
                    onValidation: () {
                      loginViewModel.inputEmail();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfield(
                    onValidation: () {
                      loginViewModel.inputPass();
                    },
                    controller: loginViewModel.passCon,
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () {
                      loginViewModel.toggleSuffix();
                    },
                    hintText: "Password",
                    error: loginViewModel.passError,
                    prefix: Icons.lock,
                    obscureText: loginViewModel.obsecure,
                    suffix: loginViewModel.suffix,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Home.routeName);
                    },
                    child: Center(
                        child: Container(
                      width: width * 0.85,
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                          color: color.purple,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: color.orange, width: 2)),
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      text: "Login with Google",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
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
              "Don't have an account?  ",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Register.routeName);
              },
              child: Text(
                "Register.",
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
