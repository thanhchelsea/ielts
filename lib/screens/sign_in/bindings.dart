import 'package:get/instance_manager.dart';
import 'package:ielts/screens/sign_in/controller.dart';
import 'package:ielts/widget/primary_input_filed.dart';

class SignBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.create<InputPrimaryController>(() => InputPrimaryController());
  }
}
