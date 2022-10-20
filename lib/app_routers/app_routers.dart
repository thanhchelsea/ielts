import 'package:get/get.dart';

import '../screens/index.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: RouterNames.SFLASH, page: () => HomeUi()),
  ];
}

class RouterNames {
  RouterNames._();
  static const SFLASH = '/';
  static const HOME = '/home';
}
