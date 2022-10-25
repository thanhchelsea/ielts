import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:logger/logger.dart';

class SignInController extends BaseController {
  static SignInController to = Get.find();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  ServerRepository serverRep = ServerRepository();
  final store = PreferenceImpl();

  Rxn<User> user = Rxn<User>();
  Future signInWithAccount() async {
    var loginService = serverRep.loginAccount(userName.text.trim(), password.text.trim());
    callDataService(
      loginService,
      onSuccess: (response) async {
        User userLogin = response as User;
        user.value = userLogin;
        if (user.value != null) {
          await store.writeStore(key: PreferenceManager.sessionId, value: user.value!.sessionId);
          Get.offAndToNamed(RouterNames.HOME);
        } else {}
      },
    );
  }

  Future<bool> signInWithToken() async {
    bool check = false;
    String? sessionId = await store.readStore(key: PreferenceManager.sessionId);
    if (sessionId != null && sessionId.isNotEmpty) {
      var loginService = serverRep.loginWithSessionId(sessionId);
      await callDataService(
        loginService,
        onSuccess: (response) async {
          User userLogin = response as User;
          user.value = userLogin;
          if (userLogin.sessionId.isNotEmpty) {
            await store.writeStore(key: PreferenceManager.sessionId, value: user.value!.sessionId);
          } else {
            user.value!.sessionId = sessionId;
          }
          check = true;
          // Get.offAndToNamed(RouterNames.HOME);
        },
      );
    }
    return check;
  }

  @override
  void onReady() {
    // signInWithToken();
    super.onReady();
  }
}
