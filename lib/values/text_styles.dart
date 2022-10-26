import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The 2018 spec has thirteen text styles:
/// ```
/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25  => OVERRIDE TO 30
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
/// ```
///
class StyleApp {
  static TextStyle pageTitle({
    double? fontSize,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

//headline
  static TextStyle headlineNormal({
    double fontSize = 18,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      // fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle headlineBold({
    double? fontSize = 18,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 18.sp,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

//title
//title bold
  static TextStyle titleBold({
    double fontSize = 16,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color,
    );
  }

  //title small
  static TextStyle titleExtraSmall({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  //title small
  static TextStyle titleSmall({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  //title nornam
  static TextStyle titleNormal({
    double fontSize = 16,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      // fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // title button
  static TextStyle titleButton({
    double fontSize = 14,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
      color: color ?? Colors.white,
    );
  }

//________________________________________
  // di an cap

  static Color getShimmerColor(BuildContext context) {
    return Colors.grey;
  }

  //- Dùng cho tiêu đề in đậm (Semi-bold)
  static TextStyle titleBoldStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
  }) {
    return StyleApp.subtitle1(context, true)!.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
    );
  }

  //- Dùng cho tiêu đề in đậm size 30 (Semi-bold)
  static TextStyle titleBigBoldStyle(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return StyleApp.subtitle1(context, true)!.copyWith(
      color: color,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? StyleApp.subtitle1(context)?.fontSize,
    );
  }

  //- Dùng cho tiêu đề kiểu Medium
  static TextStyle titleStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
  }) {
    return StyleApp.subtitle1(context, true)!.copyWith(
      color: color,
      fontSize: fontSize,
    );
  }

  //- Dùng cho mô tả kiểu regular, màu caption
  static TextStyle descStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return StyleApp.bodyText2(context)!.copyWith(
      color: color ?? captionColor(context),
      fontWeight: fontWeight,
    );
  }

  //- Dùng cho mô tả kiểu regular, màu nhạt
  static TextStyle bodyStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return StyleApp.bodyText1(context)!.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  //- Dùng cho caption kiểu regular, màu nhạt
  static TextStyle captionStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return StyleApp.caption(context)!.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  //- Dùng cho text input
  static TextStyle textFieldStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return StyleApp.subtitle1(context)!.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  //- Dùng cho tiêu đề button
  static TextStyle buttonStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return StyleApp.subtitle1(context)!.copyWith(
      fontWeight: fontWeight,
      color: color,
    );
  }

  //- Dùng cho tiêu đề của header
  static TextStyle? headerStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    final textColor = (color != null ? color : StyleApp.titleColor(context)?.withOpacity(0.8));
    return StyleApp.subtitle1(context)?.copyWith(
      fontWeight: fontWeight,
      color: textColor,
    );
  }

  //- Dùng cho tiêu đề của setting
  static TextStyle? settingStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
  }) {
    return StyleApp.bodyText2(context)?.copyWith(
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  //- Dùng cho tiêu đề của segment
  static TextStyle? segmentStyle(
    BuildContext context, {
    double? fontSize,
    Color? color,
  }) {
    return StyleApp.caption(context)?.copyWith(
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  //- Dùng cho text input money
  static TextStyle? textMoneyStyle(
    BuildContext context, {
    double fontSize = 20,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return StyleApp.headline6(context)?.copyWith(
      fontWeight: fontWeight,
      color: color,
    );
  }

  static Color? titleColor(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1?.color;
  }

  static Color? captionColor(BuildContext context) {
    return Theme.of(context).textTheme.caption?.color;
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color accentColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color buttonColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  //chữ thường mờ
  static TextStyle? bodyText1(BuildContext context, [bool? bold]) {
    var bodyText1 = Theme.of(context).textTheme.bodyText1;
    if (bold == true) {
      return bodyText1?.copyWith(fontWeight: FontWeight.w500);
    }
    return bodyText1;
  }

  //chữ thường
  static TextStyle? bodyText2(BuildContext context, [bool? bold]) {
    var bodyText2 = Theme.of(context).textTheme.bodyText2;
    if (bold == true) {
      return bodyText2?.copyWith(fontWeight: FontWeight.w500);
    }
    return bodyText2;
  }

  //chữ thường đậm
  static TextStyle? subtitle2(BuildContext context, [bool? strongBold]) {
    var subtitle2 = Theme.of(context).textTheme.subtitle2;
    if (strongBold == true) {
      return subtitle2?.copyWith(fontWeight: FontWeight.w700);
    }
    return subtitle2;
  }

  //chữ thường lớn
  static TextStyle? subtitle1(BuildContext context, [bool? bold]) {
    var subtitle1 = Theme.of(context).textTheme.subtitle1;
    if (bold == true) {
      return subtitle1?.copyWith(fontWeight: FontWeight.w500);
    }
    return subtitle1;
  }

  //caption chữ bé mờ
  static TextStyle? caption(BuildContext context, [bool? bold]) {
    var caption = Theme.of(context).textTheme.caption;
    if (bold == true) {
      return caption?.copyWith(fontWeight: FontWeight.w500);
    }
    return caption;
  }

  //tiêu đề lớn
  static TextStyle? headline5(BuildContext context, [FontWeight? fontWeight]) {
    var headline5 = Theme.of(context).textTheme.headline5;
    if (fontWeight != null) {
      return headline5?.copyWith(fontWeight: fontWeight);
    }
    return headline5;
  }

  //tiêu đề đậm
  static TextStyle? headline6(BuildContext context, [bool? strongBold]) {
    var headline6 = Theme.of(context).textTheme.headline6;
    if (strongBold == true) {
      return headline6?.copyWith(fontWeight: FontWeight.w700);
    }
    return headline6;
  }

  //chữ siêu nhỏ
  static TextStyle? overline(BuildContext context, [FontWeight? fontWeight]) {
    var overline = Theme.of(context).textTheme.overline;
    if (fontWeight != null) {
      return overline?.copyWith(fontWeight: fontWeight);
    }
    return overline;
  }

  //tiêu đề lớn 30
  static TextStyle? headline4(BuildContext context, [FontWeight? fontWeight]) {
    var headline4 = Theme.of(context).textTheme.headline4;
    if (fontWeight != null) {
      return headline4?.copyWith(fontWeight: fontWeight);
    }
    return headline4;
  }
}
