import 'package:get/instance_manager.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/speaking/text_to_speech_controller.dart';

import '../../widget/index.dart';

class SpeakingBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(SpeakToTextController());
    Get.put(TextToSpeakController());
    Get.put(SpeakingController());

    Get.create<InputPrimaryController>(() => InputPrimaryController());
  }
}
