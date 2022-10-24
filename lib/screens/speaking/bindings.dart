import 'package:get/instance_manager.dart';

import 'controller.dart';

class SpeakingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeakingController());
  }
}
