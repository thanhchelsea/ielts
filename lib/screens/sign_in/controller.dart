import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';

class SignInController extends BaseController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signIn() async {
    Get.offAllNamed(RouterNames.HOME);
  }
}
