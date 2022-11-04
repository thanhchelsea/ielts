import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:ielts/utils/client_utils.dart';

class RecordWidget extends StatelessWidget {
  RecordWidget({Key? key, required this.file}) : super(key: key);
  FileSystemEntity file;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: halfPadding, horizontal: halfPadding),
      decoration: BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0,
          color: Color(0xff6F87C3).withOpacity(0.2),
        )
      ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline_outlined,
                color: AppColors.colorInActive,
                size: 20,
              ),
              SizedBox(width: padding),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 6.h,
                    child: LinearProgressIndicator(
                      value: 1, // percent filled
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorActive),
                      backgroundColor: AppColors.colorActive,
                    ),
                  ),
                ),
              ),
              SizedBox(width: padding),
              Container(
                margin: EdgeInsets.only(right: padding18),
                child: Text(
                  "2:53 ",
                  style: StyleApp.titleSmall(
                    fontSize: 10.sp,
                    color: AppColors.colorActive,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: padding10),
          Row(
            children: [
              Icon(
                Icons.more_vert_outlined,
                size: 20,
              ),
              SizedBox(width: padding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ClientUltis.getFileName(file.path),
                      style: StyleApp.titleBold(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: padding_4),
                    Text(
                      ClientUltis.getTimeCreteFile(file.path),
                      style: StyleApp.titleBold(fontSize: 12.sp, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(width: padding),
              PrimaryButton(
                labelText: "Submit",
                onPressed: () {},
                fontSizeText: 12.sp,
                padding: EdgeInsets.symmetric(horizontal: halfPadding, vertical: padding_6),
                colorBackground: AppColors.colorActive,
                borderRadius: 12,
                showShadow: false,
              )
            ],
          ),
        ],
      ),
    );
  }
}
