import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakingUI extends BaseView<SpeakingController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Speaking",
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: padding, vertical: halfPadding),
            child: Row(
              children: [
                TabBarPage(
                    nameTab: "Practice",
                    imageIcon: AppImages.practice,
                    currentNameTab: controller.nameTab.value,
                    onPressed: () {
                      controller.changeSelectTab("Practice");
                    }),
                TabBarPage(
                    nameTab: "History",
                    imageIcon: AppImages.history,
                    currentNameTab: controller.nameTab.value,
                    onPressed: () {
                      controller.changeSelectTab("History");
                    }),
              ],
            ),
          ),
        )
      ],
    );
  }
}
