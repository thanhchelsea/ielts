import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/index.dart';

class TabBarPage extends StatelessWidget {
  TabBarPage({
    Key? key,
    required this.currentNameTab,
    required this.imageIcon,
    required this.nameTab,
    required this.onPressed,
  }) : super(key: key);

  String nameTab, imageIcon, currentNameTab;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return tabBar();
  }

  Widget tabBar() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(right: 3),
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
                onPressed();
              },
              child: Row(
                children: [
                  Image(
                    width: 23.w,
                    height: 20.h,
                    image: AssetImage(imageIcon),
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
