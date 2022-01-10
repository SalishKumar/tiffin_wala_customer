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
          child: Consumer<RegisterViewModel>(
              builder: (context, registerViewModel, child) {
            return Container(
              child:  Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  MyCustomTextfield(
                    controller: registerViewModel.nameCon,
                    textInputType: TextInputType.name,
                    onPressed: () {},
                    hintText: "Name",
                    error: registerViewModel.nameError,
                    prefix: Icons.person,
                    onValidation: () {
                      registerViewModel.inputName();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfield(
                    controller: registerViewModel.emailCon,
                    textInputType: TextInputType.emailAddress,
                    onPressed: () {},
                    hintText: "Email",
                    error: registerViewModel.emailError,
                    prefix: Icons.email,
                    onValidation: () {
                      registerViewModel.inputEmail();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfield(
                    controller: registerViewModel.phoneCon,
                    textInputType: TextInputType.phone,
                    onPressed: () {},
                    hintText: "Phone",
                    error: registerViewModel.phoneError,
                    prefix: Icons.phone,
                    onValidation: () {
                      registerViewModel.inputPhone();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfield(
                    onValidation: () {
                      registerViewModel.inputPass();
                    },
                    controller: registerViewModel.passCon,
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () {
                      registerViewModel.toggleSuffix1();
                    },
                    hintText: "Password",
                    error: registerViewModel.passError,
                    prefix: Icons.lock,
                    obscureText: registerViewModel.obsecure1,
                    suffix: registerViewModel.suffix1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfield(
                    onValidation: () {
                      registerViewModel.comparePass();
                    },
                    controller: registerViewModel.confirmPassCon,
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () {
                      registerViewModel.toggleSuffix2();
                    },
                    hintText: "Confirm Password",
                    error: registerViewModel.confirmPassError,
                    prefix: Icons.lock,
                    obscureText: registerViewModel.obsecure2,
                    suffix: registerViewModel.suffix2,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Center(
                        child: Container(
                      width: width * 0.85,
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Register",
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
                      text: "Register with Google",
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
