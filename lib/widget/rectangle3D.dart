import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Rectangle3D extends StatelessWidget {
  Rectangle3D({Key? key, required this.child, this.shadowWidth}) : super(key: key);
  Widget child;
  double borderRadius = 10;
  double? shadowWidth = Get.width - 100.w;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: -16.h,
                child: Container(
                  margin: EdgeInsets.all(30.w),
                  padding: EdgeInsets.only(bottom: 12),
                  width: shadowWidth ?? Get.width - 100.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Get.isDarkMode
                            ? Get.theme.shadowColor.withOpacity(0.4)
                            : Color(0xFF6F87C3).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.w),
                padding: EdgeInsets.only(bottom: 11),
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Get.theme.cardColor.withOpacity(0.5) : Color(0xffEEEEEE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                    bottomLeft: Radius.circular(borderRadius + 10),
                    bottomRight: Radius.circular(borderRadius + 10),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Get.theme.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Get.isDarkMode
                            ? Get.theme.shadowColor.withOpacity(0.4)
                            : Color(0xFF6F87C3).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 0.01,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 16.w),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
