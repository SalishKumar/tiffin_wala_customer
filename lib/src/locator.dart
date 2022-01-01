import 'package:get_it/get_it.dart';
import 'package:tiffin_wala_customer/src/constants/custom_widgets.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';
import 'package:tiffin_wala_customer/src/view_model/login_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => CustomWidgets());
}
