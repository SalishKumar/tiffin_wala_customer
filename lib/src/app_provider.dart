
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/custom_widgets.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/view_model/register_view_model.dart';

///[AppProvider] returns a [MultiProvider] widget that can be used to
///wrap a widget to provide the state through a dependency injection to
///all the child widgets. We wrap the [MaterialApp] with widget to provide
///the state from view models in the whole app.
class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
      ],
      child: child,
    );
  }
}
