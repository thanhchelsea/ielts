import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/index.dart';

// class DialogApp {

//   void showAlertDialog({
//     required String description,
//     required String titleCancle,
//     required String titleCofirm,
//     Color? colorTitleCancel,
//     Color? colorTitleConfirm,
//     Widget? icon,
//     required Function onCancel,
//     required Function onConfirm,
//   }) {
//     showCupertinoModalPopup<void>(
//       context: Get.context!,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: icon ?? const Text('Alert'),
//         content: Container(
//           color: Colors.red,
//           width: 400,
//           // margin: EdgeInsets.symmetric(horizontal: 32.w),
//           child: Text(
//             '$description',
//           ),
//         ),
//         actions: <CupertinoDialogAction>[
//           CupertinoDialogAction(
//             /// This parameter indicates this action is the default,
//             /// and turns the action's text to bold text.
//             isDefaultAction: true,
//             onPressed: () {
//               onCancel();
//             },
//             child: Container(
//               child: Text(
//                 titleCancle,
//                 style: TextStyle(
//                   color: colorTitleCancel ??
//                       const Color(0xff477CD1).withOpacity(0.8),
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           CupertinoDialogAction(
//             /// This parameter indicates the action would perform
//             /// a destructive action such as deletion, and turns
//             /// the action's text color to red.
//             isDestructiveAction: true,
//             onPressed: () {
//               onConfirm();
//             },
//             child: Text(
//               titleCofirm,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: colorTitleCancel ?? const Color(0xff477CD1),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DialogApp extends StatelessWidget {
  DialogApp({
    Key? key,
    required this.titleCofirm,
    required this.titleCancle,
    required this.description,
    this.icon,
    this.colorTitleCancel,
    this.colorTitleConfirm,
    required this.onCancel,
    required this.onConfirm,
    this.desWidget,
  }) : super(key: key);
  String description;
  Widget? desWidget;
  String titleCancle;
  String titleCofirm;
  Color? colorTitleCancel;
  Color? colorTitleConfirm;
  Widget? icon;
  Function onCancel;
  Function onConfirm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff010101).withOpacity(0.6),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Get.back();
          },
          child: Container(
            height: Get.height,
            color: Colors.transparent,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 300.w,
                    padding: EdgeInsets.only(
                      top: padding,
                      // left: padding,
                      // right: padding,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // SizedBox(height: 12.h),
                        icon ?? Container(),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: padding),
                          child: desWidget ??
                              Text(
                                description,
                                textAlign: TextAlign.center,
                                style: StyleApp.titleSmall(
                                    color: Color(0xff6D6D6D)),
                              ),
                        ),
                        SizedBox(height: 32.h),
                        Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            border: const Border(
                              top: BorderSide(
                                color: Color(0xffEAEAEA),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    onCancel();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: padding14,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xffEAEAEA),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      titleCancle,
                                      textAlign: TextAlign.center,
                                      style: StyleApp.titleNormal(
                                        color: AppColors.colorPrimaryApp2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    onConfirm();
                                  },
                                  child: Container(
                                    // ignore: prefer_const_constructors
                                    padding: EdgeInsets.symmetric(
                                        vertical: padding14),
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      titleCofirm,
                                      textAlign: TextAlign.center,
                                      style: StyleApp.titleNormal(
                                        color: AppColors.colorPrimaryApp2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
}
