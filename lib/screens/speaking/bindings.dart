import 'package:get/instance_manager.dart';
import 'package:ielts/screens/speaking/text_to_speach_controller.dart';

import 'controller.dart';

class SpeakingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TextToSpeakController());
    Get.put(SpeakingController());
  }
}
