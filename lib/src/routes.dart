import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/addresses.dart';
import 'package:tiffin_wala_customer/src/views/cart.dart';
import 'package:tiffin_wala_customer/src/views/complain_list.dart';
import 'package:tiffin_wala_customer/src/views/complaint_view.dart';
import 'package:tiffin_wala_customer/src/views/filter.dart';
import 'package:tiffin_wala_customer/src/views/forget_password.dart';
import 'package:tiffin_wala_customer/src/views/home.dart';
import 'package:tiffin_wala_customer/src/views/item.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/views/menu.dart';
import 'package:tiffin_wala_customer/src/views/order_list.dart';
import 'package:tiffin_wala_customer/src/views/order_view.dart';
import 'package:tiffin_wala_customer/src/views/payment_and_address.dart';
import 'package:tiffin_wala_customer/src/views/register.dart';
import 'package:tiffin_wala_customer/src/views/review_view.dart';
import 'package:tiffin_wala_customer/src/views/splash_screen.dart';
import 'package:tiffin_wala_customer/src/views/subscription_menu.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case Login.routeName:
      return MaterialPageRoute(builder: (_) => Login());
    case Register.routeName:
      return MaterialPageRoute(builder: (_) => const Register());
    case Home.routeName:
      return MaterialPageRoute(builder: (_) => const Home());
    case Filter.routeName:
      return MaterialPageRoute(builder: (_) => Filter());
    case Cart.routeName:
      return MaterialPageRoute(builder: (_) => Cart());
    case Menu.routeName:
      return MaterialPageRoute(builder: (_) => Menu());
    case Item.routeName:
      return MaterialPageRoute(builder: (_) => const Item());
    case PaymentAndAddress.routeName:
      return MaterialPageRoute(builder: (_) => PaymentAndAddress());
    case Addresses.routeName:
      return MaterialPageRoute(builder: (_) => Addresses());
    case Maps.routeName:
      return MaterialPageRoute(builder: (_) => Maps());
    case AddressView.routeName:
      return MaterialPageRoute(builder: (_) => const AddressView());
    case ForgetPassword.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPassword());
    case ComplainList.routeName:
      return MaterialPageRoute(builder: (_) => ComplainList());
    case OrderView.routeName:
      return MaterialPageRoute(builder: (_) => OrderView());
    case Review.routeName:
      return MaterialPageRoute(builder: (_) => Review());
    case ComplainView.routeName:
      return MaterialPageRoute(builder: (_) => ComplainView());
    case SubscriptionMenu.routeName:
      return MaterialPageRoute(builder: (_) => SubscriptionMenu());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
