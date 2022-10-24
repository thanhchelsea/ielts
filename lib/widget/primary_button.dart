import 'package:flutter/material.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.labelText,
    required this.onPressed,
    this.colorBackground = AppColors.colorPrimaryApp,
    this.colorText = Colors.white,
    this.width,
    this.fontWeight = FontWeight.w600,
    this.fontSizeText,
    this.showShadow = true,
  });
  final double? width;
  final String labelText;
  final void Function() onPressed;
  final Color colorBackground;
  final Color colorText;
  final FontWeight fontWeight;
  final double? fontSizeText;
  final bool showShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0, 15),
                  color: Color(0xffFFBBC7).withOpacity(0.5),
                )
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: colorBackground.withOpacity(0.2),
          primary: colorBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: padding14),
          width: double.infinity,
          child: Text(
            labelText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSizeText ?? 14.sp,
              fontWeight: fontWeight,
              color: colorText,
            ),
          ),
        ),
      ),
    );
  }
}
