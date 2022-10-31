import 'package:get/instance_manager.dart';
import 'package:ielts/screens/video/controller.dart';

class VideoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoController());
  }
}
