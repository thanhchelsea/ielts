import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoUI extends BaseView<VideoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Video",
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            video(),
            SizedBox(height: padding10),
            tabAction(),
          ],
        ),
      ),
    );
  }

  Widget video() {
    return Container(
      margin: EdgeInsets.only(top: padding),
      height: Get.height / 3.5,
      child: Obx(
        () {
          if (controller.chewieController.value != null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Chewie(
                controller: controller.chewieController.value!,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget tabAction() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TabBarPage(
            nameTabs: ["Comment", "Document"],
            iconTabs: [AppIcons.comment, AppIcons.dowload_file],
            id: Get.currentRoute,
          ),
        ),
        PrimaryButton(
          colorBackground: AppColors.colorPrimaryApp,
          borderRadius: 15,
          labelText: "Next",
          fontWeight: FontWeight.w800,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          onPressed: () {},
          showShadow: true,
          titleWidget: Container(
            padding: EdgeInsets.only(top: halfPadding, bottom: halfPadding, left: padding12, right: halfPadding),
            child: Row(
              children: [
                Text("Next", textAlign: TextAlign.center, style: StyleApp.titleButton()),
                SizedBox(width: 8),
                Icon(Icons.navigate_next)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
