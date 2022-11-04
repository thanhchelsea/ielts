import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielts/screens/main/index.dart';
import 'package:ielts/screens/main/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  MainBindings().dependencies();
  ScreenUtil.init(
    BoxConstraints(
      maxWidth: Get.width,
      maxHeight: Get.height,
    ),
    orientation: Orientation.portrait,
  );
  ScreenUtil().setWidth(Get.width);
  ScreenUtil().setHeight(Get.height);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) async {
    runApp(MainView());
  });
}
