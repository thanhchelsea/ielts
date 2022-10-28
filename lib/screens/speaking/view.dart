import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class SpeakingUI extends BaseView<SpeakingController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Speaking",
    );
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: padding, vertical: halfPadding),
                  child: TabBarPage(
                    nameTabs: ["Practice", "History"],
                    iconTabs: [AppIcons.practice, AppIcons.history],
                    id: Get.currentRoute,
                    tabsView: [practiceView(), Text("document")],
                  ),
                ),
              ),
            ],
          ),
          Positioned(bottom: 0, child: bottomTab()),
        ],
      ),
    );
  }

  Widget practiceView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: padding),
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            controller.data,
          ),
        ),
      ),
    );
  }

  Widget bottomTab() {
    return Container(
      padding: EdgeInsets.only(left: padding, right: padding, bottom: 24.h, top: extraLargePadding),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.white.withOpacity(0.0),
            // Colors.white.withOpacity(0.6),
            // Colors.white.withOpacity(0.8),
            // Colors.white.withOpacity(0.8),
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      width: Get.width,
      // color: Colors.red,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          SliderAudio(
            progress: const Duration(seconds: 30),
            total: const Duration(seconds: 100),
            width: 300.w,
            widgetAction: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.pause_circle_outline,
                color: AppColors.colorActive,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: itemBottomTab(
                  name: "Listen",
                  icon: AppIcons.listen,
                  onTap: () {},
                ),
              ),
              itemBottomTab(
                name: "Sound",
                icon: AppIcons.sound,
                onTap: () {},
              ),
              Container(
                padding: EdgeInsets.all(padding10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFFE4DE),
                ),
                child: Container(
                  padding: EdgeInsets.all(padding10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [Color(0xffFF8E4F), Color(0xffFF3636)],
                    ),
                  ),
                  child: const Icon(
                    AppIcons.mic,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              itemBottomTab(
                name: "Record",
                icon: AppIcons.record,
                onTap: () {},
              ),
              itemBottomTab(
                name: "Finish",
                icon: AppIcons.finsh,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemBottomTab({
    required String name,
    required IconData icon,
    required Function onTap,
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          key: name == "Listen" ? controller.globalKeyListen : null,
          child: Icon(
            icon,
            size: 22,
            color: !isActive ? AppColors.colorInActive : AppColors.colorActive,
          ),
        ),
        SizedBox(height: padding10),
        Text(
          name,
          style: StyleApp.titleSmall(
            fontSize: 12.sp,
            color: !isActive ? AppColors.colorInActive : AppColors.colorActive,
          ),
        )
      ],
    );
  }
}
