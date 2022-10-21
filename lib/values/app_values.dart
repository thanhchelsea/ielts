import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double submitButtonWith = 245;

Size get minButtonSize => Size(32.sp, 32.sp);

Size get minMediumButtonSize => Size(32.sp, 36.sp);

Size get minSubmitButtonSize => Size(45.sp, 44.sp);

double get borderButton => 6.sp;

//padding
double get padding_2 => 2.w;
double get padding_6 => 6.w;
double get halfPadding => 8.w;
double get padding_4 => 4.w;
double get padding10 => 10.w;
double get padding12 => 12.w;
double get padding => 16.w;
double get padding18 => 18.w;
double get padding20 => 20.w;
double get largePadding => 24.w;
double get extraLargePadding => 32.w;
double get buttonVerticalPadding => 16.w;

//text
double get sp4 => 4.0.sp;
double get sp8 => 8.0.sp;
double get sp14 => 14.0.sp;
double get sp12 => 12.0.sp;
double get sp16 => 16.0.sp;
double get sp23 => 23.0.sp;
double get sp24 => 24.0.sp;

double toSp(num value) {
  return value.sp;
}

TextStyle? tabBarTextStyle(TextTheme textTheme) {
  return textTheme.subtitle2;
}

//https://api.flutter.dev/flutter/material/TextTheme-class.html
getTextTheme(TextTheme textTheme) {
  // return textTheme;
  return textTheme.copyWith(
    //chữ thường
    bodyText2: textTheme.bodyText2?.copyWith(
      fontSize: 14.sp,
    ),

    //chữ thường mờ
    bodyText1:
        textTheme.bodyText1?.copyWith(fontSize: 14.sp, color: textTheme.caption?.color, fontWeight: FontWeight.w400),

    //chữ thường đậm
    subtitle2: textTheme.subtitle2?.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),

    //chữ thường lớn
    subtitle1: textTheme.subtitle1?.copyWith(
      fontSize: 16.sp,
    ),

    //caption chữ bé mờ
    caption: textTheme.caption?.copyWith(
      fontSize: 12.sp,
    ),

    //tiêu đề lớn
    headline5: textTheme.headline5?.copyWith(
      fontSize: 24.sp,
    ),
    //tiêu đề đậm
    headline6: textTheme.headline6?.copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),

    headline4: textTheme.headline4?.copyWith(
      fontSize: 30.sp,
    ),

    //caption chữ bé mờ
    overline: textTheme.overline?.copyWith(
      fontSize: 10.sp,
    ),
  );
}

ElevatedButtonThemeData getElevatedButtonTheme(TextTheme textTheme, {Color? primaryColor}) => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: minButtonSize,
        elevation: 0.0,
        primary: primaryColor,
        textStyle: textTheme.subtitle2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderButton),
        ),
      ),
    );
OutlinedButtonThemeData getOutlinedButtonTheme(TextTheme textTheme) => OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: minButtonSize,
        textStyle: textTheme.subtitle2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderButton),
        ),
      ),
    );
TextButtonThemeData getTextButtonTheme(TextTheme textTheme) => TextButtonThemeData(
      style: TextButton.styleFrom(minimumSize: minButtonSize),
    );
