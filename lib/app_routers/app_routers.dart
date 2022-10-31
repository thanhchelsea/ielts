import 'package:get/get.dart';
import 'package:ielts/screens/home/bindings.dart';
import 'package:ielts/screens/sign_in/bindings.dart';
import 'package:ielts/screens/sign_in/view.dart';
import '../screens/index.dart';
import '../screens/splash/index.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(
      name: RouterNames.SFLASH,
      binding: HomeBindings(),
      page: () => HomeUi(),
    ),
    GetPage(
      name: RouterNames.SIGN_IN,
      binding: SignBindings(),
      page: () => SignInUI(),
    ),
    GetPage(
      name: RouterNames.LEVEL_SKILL,
      binding: LevelSkillBindings(),
      page: () => LevelSkillUI(),
    ),
    GetPage(
      name: RouterNames.SPEAKING,
      binding: SpeakingBindings(),
      page: () => SpeakingUI(),
    ),
    GetPage(
      name: RouterNames.SPLASH,
      binding: SplashBindings(),
      page: () => SplashUI(),
    ),
    GetPage(
      name: RouterNames.VIDEO,
      binding: VideoBindings(),
      page: () => VideoUI(),
    ),
  ];
}

class RouterNames {
  RouterNames._();
  static const SFLASH = '/';
  static const SIGN_IN = '/sign_in';
  static const HOME = '/home';
  static const LEVEL_SKILL = '/level_skill';
  static const SPEAKING = '/speaking';
  static const SPLASH = '/splash';
  static const VIDEO = '/video';
}
