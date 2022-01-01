import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';

class Login extends StatelessWidget {
  static const routeName = '/';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    CustomWidgets customWidgets = CustomWidgets();
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
                  customWidgets.textField(
                      loginViewModel.inputEmail,
                      TextInputType.emailAddress,
                      false,
                      1,
                      'Email',
                      loginViewModel.emailError,
                      prefix: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  customWidgets.textField(
                      loginViewModel.inputPass,
                      TextInputType.visiblePassword,
                      loginViewModel.obsecure,
                      1,
                      'Password',
                      loginViewModel.passError,
                      prefix: Icons.vpn_key,
                      suffix: loginViewModel.suffix,
                      onPressed: loginViewModel.toggleSuffix),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Center(
                        child: Container(
                      width: width * 0.33,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
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
              onTap: (){
                Navigator.of(context).pushReplacementNamed(Register.routeName);
              },
              child: Text(
                "Register.",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
