import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({Key? key}) : super(key: key);
  void showActionSheet({
    String? title,
    String? message,
    required List<ActionBottomSheet> actions,
  }) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: CupertinoActionSheet(
                    title: title != null ? const Text('Title') : null,
                    message: message != null ? const Text('Message') : null,
                    actions: <CupertinoActionSheetAction>[
                      ...List.generate(
                        actions.length,
                        (index) {
                          return CupertinoActionSheetAction(
                            onPressed: () {
                              actions[index].onTap();
                            },
                            child: Text(
                              '${actions[index].title}',
                              style: StyleApp.titleNormal(
                                  color: AppColors.colorTextPrimay),
                            ),
                          );
                        },
                      ).toList()
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: halfPadding,
                        right: halfPadding,
                        bottom: halfPadding,
                        top: padding_4),
                    padding: EdgeInsets.symmetric(vertical: padding18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: StyleApp.titleBold(
                        fontSize: 18.sp,
                        color: AppColors.colorActive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ActionBottomSheet {
  String title;
  Function onTap;
  ActionBottomSheet({
    required this.title,
    required this.onTap,
  });
}
