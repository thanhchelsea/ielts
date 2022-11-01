import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';

import 'widget/topic_road_map.dart';

class LevelSkillUI extends BaseView<LevelSkillController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Speaking",
    );
  }

  int lengthList = 10;
  late List<String> listNumber;

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        listTabTopic(),
        SizedBox(height: 20.h),
        Obx(
          () {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: padding10),
                child: TopicRoadMap(
                  topics: controller.topicChilds[controller.topicSelected.value?.id ?? 0] ?? [],
                  tapToic: (t) {
                    controller.selectTopicChild(t);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget listTabTopic() {
    return Obx(
      () {
        return controller.topics.isNotEmpty
            ? Container(
                padding: EdgeInsets.only(
                  left: padding_6,
                  right: padding_6,
                  top: padding_2,
                  bottom: padding_2,
                ),
                margin: EdgeInsets.all(halfPadding),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Get.theme.cardColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.topics.length, (index) {
                      bool selected = false;
                      if (controller.topicSelected.value!.id == controller.topics[index].id) {
                        selected = true;
                      }
                      return Container(
                        padding: EdgeInsets.only(top: padding_6, bottom: padding_6, right: halfPadding),
                        child: Wrap(
                          children: [
                            PrimaryButton(
                              colorBackground: !selected ? Colors.transparent : AppColors.colorPrimaryApp,
                              borderRadius: 15,
                              labelText: "${controller.topics[index].name}",
                              fontSizeText: 12.sp,
                              fontWeight: FontWeight.w800,
                              padding:
                                  EdgeInsets.symmetric(vertical: 7.h, horizontal: selected ? padding18 : padding12),
                              onPressed: () {
                                controller.selectTopic(controller.topics[index]);
                              },
                              showShadow: selected,
                              colorText: !selected ? AppColors.colorInActive : Colors.white,
                              boxShadow: selected
                                  ? BoxShadow(
                                      blurRadius: 020,
                                      spreadRadius: 0,
                                      offset: Offset(0, 2),
                                      color: !selected ? Colors.transparent : Color(0xffFFBBC7).withOpacity(0.5),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
