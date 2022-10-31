import 'package:get/instance_manager.dart';
import 'package:ielts/index.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
