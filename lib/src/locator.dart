import 'package:get_it/get_it.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HomeViewModel());
}
