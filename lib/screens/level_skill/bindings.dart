import 'package:get/instance_manager.dart';

import 'controller.dart';

class LevelSkillBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LevelSkillController());
  }
}
