import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/splash/controller.dart';

class SplashUI extends BaseView<SplashController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      color: Colors.white,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppImages.splash,
            width: Get.width,
            // height: Get.height / 2,
            // fit: BoxFit.cover,
          ),
          Positioned(
            top: Get.height / 3,
            width: Get.width,
            child: SvgPicture.asset(
              AppImages.logoInApp,
            ),
          ),
        ],
      ),
    );
  }
}
