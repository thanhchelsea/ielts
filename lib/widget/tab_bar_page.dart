import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../values/index.dart';

class TabBarPage extends StatelessWidget {
  TabBarPage({
    Key? key,
    required this.nameTabs,
    required this.iconTabs,
    required this.id,
    // required this.currentTab,
  }) : super(key: key);
  List<String> nameTabs;
  List<IconData> iconTabs;
  String id;
  // String currentTab;
  @override
  Widget build(BuildContext context) {
    return GetX<TabController>(
      tag: id,
      assignId: true,
      init: TabController(),
      initState: (state) {
        state.controller!.init(nameTabs);
      },
      builder: (controller) {
        return Row(
          children: List.generate(
            nameTabs.length,
            (index) => TabBarPageWidget(
              nameTab: controller.listNameTab[index],
              iconData: iconTabs[index],
              currentNameTab: controller.currentNameTab.value,
              onPressed: (tab) {
                controller.changeSelectTab(tab);
              },
            ),
          ),
        );
      },
    );
  }
}

class TabBarPageWidget extends StatelessWidget {
  TabBarPageWidget({
    Key? key,
    required this.currentNameTab,
    required this.nameTab,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  String nameTab, currentNameTab;
  IconData iconData;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return tabBar();
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: currentNameTab == nameTab
                  ? [
                      const BoxShadow(
                        color: Color(0xFFE4EAFA),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                enableFeedback: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: currentNameTab == nameTab ? Get.theme.cardColor : Colors.transparent,
              ),
              onPressed: () {
                onPressed(nameTab);
              },
              child: Row(
                children: [
                  Icon(
                    iconData,
                    color: currentNameTab == nameTab ? AppColors.colorBoldCardPrimary : Color(0xffA4AEBE),
                  ),
                  currentNameTab == nameTab ? SizedBox(width: halfPadding) : Container(),
                  currentNameTab == nameTab
                      ? Text(
                          nameTab,
                          style: StyleApp.titleSmall(
                            fontSize: 12,
                            color: AppColors.colorTextPrimay,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabController extends GetxController {
  RxString currentNameTab = "".obs;
  List<String> listNameTab = [];
  // TabController({
  //   required this.listNameTab,
  // });
  void changeSelectTab(String name) {
    if (currentNameTab.value != name) {
      currentNameTab.value = name;
    }
  }

  init(List<String> list) {
    listNameTab = list;
    if (listNameTab.isNotEmpty) {
      currentNameTab.value = listNameTab.first;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
