import 'package:get/state_manager.dart';
import 'package:ielts/base/index.dart';

class SpeakingController extends BaseController {
  RxString nameTab = "".obs;
  void changeSelectTab(String name) {
    if (nameTab.value != name) {
      nameTab.value = name;
    }
  }

  @override
  void onInit() {
    nameTab.value = "Practice";
    super.onInit();
  }
}
