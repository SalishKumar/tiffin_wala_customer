import 'package:flutter/material.dart';
import 'color.dart' as color;

class MyLogo extends StatelessWidget {
  MyLogo({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      child: Image.asset("assets/logo.png"),
      
    );
  }
}
