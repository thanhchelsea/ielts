import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';

import '../sign_in/controller.dart';

class SplashController extends BaseController {
  final store = PreferenceImpl();
  Future<bool> checkLogin() async {
    // await Future.delayed(
    //   Duration(seconds: 3),
    // );
    String sessionId = await store.readStore(key: PreferenceManager.sessionId) ?? "";
    bool check = await SignInController.to.signInWithToken();
    return check;
  }

  @override
  void onReady() async {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        callDataService(
          checkLogin(),
          onSuccess: (response) {
            if ((response as bool)) {
              Get.offAllNamed(RouterNames.HOME);
            } else {
              Get.offAllNamed(RouterNames.SIGN_IN);
            }
          },
        );
      },
    );
    super.onReady();
  }
}
