import 'package:get/instance_manager.dart';
import 'package:ielts/screens/sign_in/index.dart';
import 'package:ielts/screens/splash/controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
