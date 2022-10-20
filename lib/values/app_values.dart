import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppValues {
  static const double padding = 16;
  static const double padding_zero = 0;
  static const double halfPadding = 8;
  static const double smallPadding = 10;
  static const double extraSmallPadding = 6;
  static const double largePadding = 24;
  static const double extraLargePadding = 32;
  static const double padding_4 = 4;
  static const double padding_2 = 2;
  static const double padding_3 = 3;
  static const double buttonVerticalPadding = 12;

  static const double margin = 16;
  static const double margin_zero = 0;
  static const double smallMargin = 8;
  static const double extraSmallMargin = 6;
  static const double largeMargin = 24;
  static const double margin_40 = 40;
  static const double margin_32 = 32;
  static const double margin_18 = 18;
  static const double margin_2 = 2;
  static const double margin_4 = 4;
  static const double margin_6 = 6;
  static const double margin_12 = 12;
  static const double margin_10 = 10;
  static const double margin_30 = 30;
  static const double margin_20 = 20;
  static const double extraLargeMargin = 36;
  static const double marginBelowVerticalLine = 64;
  static const double extraLargeSpacing = 96;

  static const double radius = 16;
  static const double radius_zero = 0;
  static const double smallRadius = 8;
  static const double radius_6 = 6;
  static const double radius_12 = 12;
  static const double largeRadius = 24;
  static const double roundedButtonRadius = 24;
  static const double extraLargeRadius = 36;

  static const double elevation = 16;
  static const double smallElevation = 8;
  static const double extraSmallElevation = 4;
  static const double largeElevation = 24;

  static const double circularImageDefaultSize = 90;
  static const double circularImageSize_30 = 30;
  static const double circularImageDefaultBorderSize = 0;
  static const double circularImageDefaultElevation = 0;
  static const double momentThumbnailDefaultSize = 80;
  static const double momentSmallThumbnailDefaultSize = 32;
  static const double collectionThumbnailDefaultSize = 150;
  static const double defaultViewPortFraction = 0.9;
  static const int defaultAnimationDuration = 300;
  static const double listBottomEmptySpace = 200;
  static const double maxButtonWidth = 496;
  static const double stackedImageDefaultBorderSize = 4;
  static const double stackedImageDefaultSpaceFactor = 0.4;
  static const double stackedImageDefaultSize = 30;

  static const double iconDefaultSize = 24;
  static const double emoticonDefaultSize = 22;
  static const double iconSize_20 = 20;
  static const double iconSize_22 = 22;
  static const double iconSize_18 = 18;
  static const double iconSmallSize = 16;
  static const double iconSmallerSize = 12;
  static const double iconSize_14 = 14;
  static const double iconSize_28 = 28;
  static const double iconLargeSize = 36;
  static const double iconExtraLargerSize = 96;
  static const double appBarIconSize = 32;

  static const double customAppBarSize = 144.0;
  static const double collapsedAppBarSize = 70.0;

  static const int loggerLineLength = 120;
  static const int loggerErrorMethodCount = 8;
  static const int loggerMethodCount = 2;

  static const double fullViewPort = 1;
  static const double indicatorDefaultSize = 8;
  static const double indicatorShadowBlurRadius = 1;
  static const double indicatorShadowSpreadRadius = 0;
  static const double appbarActionRippleRadius = 50;
  static const double activeIndicatorSize = 8;
  static const double inactiveIndicatorSize = 10;
  static const double datePickerHeightOnIos = 270;
  static const int maxCharacterCountOfQuote = 108;
  static const double barrierColorOpacity = 0.4;

  static const int defaultPageSize = 10;
  static const int defaultPageNumber = 1;
  static const int defaultDebounceTimeInMilliSeconds = 1000;
  static const int defaultThrottleTimeInMilliSeconds = 500;

  static const double height_16 = 16;
}

double submitButtonWith = 245;

Size get minButtonSize => Size(32.sp, 32.sp);

Size get minMediumButtonSize => Size(32.sp, 36.sp);

Size get minSubmitButtonSize => Size(45.sp, 44.sp);

double get borderButton => 6.sp;

//padding
double get padding => 16.w;
double get halfPadding => 8.w;
double get smallPadding => 8.w;
double get extraSmallPadding => 6.w;
double get largePadding => 24.w;
double get extraLargePadding => 32.w;
double get padding_4 => 4.w;
double get padding_2 => 2.w;
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
