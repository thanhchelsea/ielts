import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/speaking/text_to_speech_controller.dart';
import 'package:ielts/screens/speaking/widget/button_record.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:ielts/widget/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../widget/index.dart';

class SpeakingUI extends BaseView<SpeakingController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Speaking",
      onBack: () {
        Get.back();
        // controller.backScreenPrevious();
      },
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
              GetX<SpeakingController>(
                builder: (controller) {
                  if (controller.cards.isEmpty) return Container();
                  return VideoCustom(
                    idParentOfVideo: controller.cards[0].id,
                    textContainLinkVideo: controller.cards[0].frontText,
                  );
                },
              ),
              SizedBox(height: 12.h),
              practiceView()
              // Expanded(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: padding, vertical: halfPadding),
              //     child: TabBarPage(
              //       nameTabs: const ["Practice", "History"],
              //       iconTabs: const [AppIcons.practice, AppIcons.history],
              //       id: Get.currentRoute,
              //       tabsView: [practiceView(), Text("document")],
              //       marginTabbar: EdgeInsets.only(bottom: padding_6),
              //     ),
              //   ),
              // ),
            ],
          ),
          // Positioned(bottom: 0, child: bottomTab()),
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
              Obx(
                () {
                  if (controller.cards.isEmpty) return Container();
                  return Container(
                    decoration:
                        BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(10), boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ]),
                    child: Column(
                      children: [
                        ...List.generate(
                          controller.cards[0].childCards.length,
                          (index) {
                            print(controller.subCards[controller.cards[0].childCards[index].id]?.statusSpeech);
                            return GrammarAndSpellingCheckDoc(
                              key: Key(controller.cards[0].childCards[index].id.toString()),
                              tag: controller.cards[0].childCards[index].id.toString(),
                              doc: controller.subCards[controller.cards[0].childCards[index].id]?.dataSubList ?? [],
                              onTextReaded: (texts) {
                                print("thanhsuuuu $texts");
                                controller.updateAnswerCard(
                                  id: controller.cards[0].childCards[index].id,
                                  result: texts,
                                );
                              },
                              isFocus: controller.subCards[controller.cards[0].childCards[index].id]?.statusSpeech ==
                                      StatuSpeech.FOCUS ||
                                  controller.subCards[controller.cards[0].childCards[index].id]?.statusSpeech !=
                                      StatuSpeech.NONE,
                              // textReaded: ["I", "currently", "reside", "in", "balcony"],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Obx(
              //   () => controller.recordeds.value.isNotEmpty
              //       ? Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               margin: EdgeInsets.only(top: padding20),
              //               child: Text(
              //                 "Voice Memos",
              //                 style: StyleApp.titleBold(fontSize: 14.sp),
              //               ),
              //             ),
              //             SizedBox(height: padding_6),
              //             ListView(
              //               shrinkWrap: true,
              //               physics: NeverScrollableScrollPhysics(),
              //               children: List.generate(
              //                 controller.recordeds.length,
              //                 (index) => Container(
              //                   margin: EdgeInsets.only(bottom: padding12),
              //                   child: RecordWidget(
              //                     file: controller.recordeds[index],
              //                     onTapMore: () {
              //                       // controller.onTapMoreOfFile(controller.recordeds[index]);
              //                     },
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         )
              //       : Container(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTab() {
    return Container(
      padding: EdgeInsets.only(
        left: padding,
        right: padding,
        bottom: 24.h,
        top: extraLargePadding,
      ),
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
          Obx(
            () => Get.find<TextToSpeakController>().state == STATESTT.PLAYING
                ? SliderAudio(
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
                  )
                : Container(),
          ),
          SizedBox(height: 16.h),
          Obx(() {
            if (controller.appRecorder.value.isRecording) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.appRecorder.value.isPasue ? Colors.black : Color(0xffFF3F39),
                    ),
                  ),
                  SizedBox(width: padding_6),
                  Text(
                    "${ClientUltis.getTimeAudio(controller.durationCurrentRecord.value, hasHour: false)}/${ClientUltis.getTimeAudio(Configs.maxRecordDuation, hasHour: false)}",
                    style: StyleApp.titleSmall(color: AppColors.colorActive, fontSize: 12.sp),
                  ),
                ],
              );
            }
            return Container();
          }),
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
                      // controller.textToSpeakData();
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
                    // controller.startRecord();
                  },
                  recording: controller.appRecorder.value.isRecording,
                ),
              ),
              Obx(
                () => itemBottomTab(
                  name: "Record",
                  icon: AppIcons.record,
                  onTap: () {
                    // controller.reRecord();
                  },
                  color: !controller.appRecorder.value.isRecording ? AppColors.colorInActive.withOpacity(0.4) : null,
                ),
              ),
              Obx(
                () => itemBottomTab(
                  name: "Finish",
                  icon: AppIcons.finsh,
                  onTap: () {
                    // controller.finishRecord();
                  },
                  color: !controller.appRecorder.value.isRecording ? AppColors.colorInActive.withOpacity(0.4) : null,
                ),
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
    Color? color,
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
              color: !isActive ? color ?? AppColors.colorInActive : AppColors.colorActive,
            ),
          ),
          SizedBox(height: padding10),
          Text(
            name,
            style: StyleApp.titleSmall(
              fontSize: 12.sp,
              color: !isActive ? color ?? AppColors.colorInActive : AppColors.colorActive,
            ),
          )
        ],
      ),
    );
  }
}
