import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/speaking/text_to_speach_controller.dart';
import 'package:ielts/screens/speaking/widget/button_record.dart';
import 'package:ielts/utils/client_utils.dart';
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
                    marginTabbar: EdgeInsets.only(bottom: padding_6),
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
          margin: EdgeInsets.only(
            bottom: 200.h,
            left: padding,
            right: padding,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
                decoration: BoxDecoration(
                  color: Get.theme.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(
                  () => RichText(
                    text: TextSpan(
                      children: List.generate(
                        controller.dataSubList.length,
                        (index) {
                          TextToSpeakController ttsCtrl = Get.find<TextToSpeakController>();
                          Color color = Colors.black;
                          // if (ttsCtrl.readed.isNotEmpty) {
                          //   if (index == ttsCtrl.readed.length - 1) {
                          //     print("${ttsCtrl.readed[index]} __ ${controller.dataSubList.value[index]}");
                          //     if (ClientUltis.compareTo(
                          //         text1: controller.dataSubList.value[index], text2: ttsCtrl.readed[index])) {
                          //       color = AppColors.colorPrimaryApp2;
                          //     }
                          //   }
                          // }
                          if (index < ttsCtrl.readed.length) {
                            if (ttsCtrl.readed.contains(
                              controller.dataSubList[index]
                                  .replaceAll(RegExp('\\n'), ' ')
                                  .replaceAll(RegExp('[^A-Za-z0-9]'), '')
                                  .toLowerCase(),
                            )) {
                              color = AppColors.colorPrimaryApp2;
                            } else {}
                          }
                          return TextSpan(
                            text: controller.dataSubList.value[index] + " ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: color,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.recordeds.value.isNotEmpty
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: padding20),
                              child: Text(
                                "Voice Memos",
                                style: StyleApp.titleBold(fontSize: 14.sp),
                              ),
                            ),
                            SizedBox(height: padding_6),
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                controller.recordeds.length,
                                (index) => Container(
                                    margin: EdgeInsets.only(bottom: padding12),
                                    child: RecordWidget(file: controller.recordeds[index])),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              )
            ],
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
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      width: Get.width,
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
                child: Obx(
                  () => itemBottomTab(
                    name: "Listen",
                    icon: AppIcons.listen,
                    onTap: () {
                      controller.textToSpeakData();
                    },
                    isActive: Get.find<TextToSpeakController>().state == STATESTT.PLAYING,
                  ),
                ),
              ),
              itemBottomTab(
                name: "Sound",
                icon: AppIcons.sound,
                onTap: () {},
              ),
              Obx(
                () => MicroComponent(
                  onTap: () {
                    print("record press");
                    controller.startRecord();
                  },
                  recording: controller.appRecorder.value.isRecording,
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
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
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
      ),
    );
  }
}
