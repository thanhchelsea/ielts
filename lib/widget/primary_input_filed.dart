import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../index.dart';

class InputFiledCustom extends StatefulWidget {
  InputFiledCustom({
    required this.controller,
    this.iconPrefix,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines,
    required this.onChanged,
    this.color,
    this.fontSize = 14,
    this.enable = true,
    this.fillColor,
  });

  final TextEditingController controller;
  final Widget? iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  bool obscureText;
  Color? fillColor;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  double fontSize;
  Color? color;
  bool enable;
  @override
  _InputFiledCustomState createState() => _InputFiledCustomState();
}

class _InputFiledCustomState extends State<InputFiledCustom> {
  InputPrimaryController controllerInput = Get.find<InputPrimaryController>();

  @override
  void initState() {
    controllerInput.initStateTextInput(widget.obscureText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.fillColor ??
                      Get.theme
                          .cardColor, // Get.isDarkMode ? Get.theme.cardColor : Colors.red,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Color(0xffEAEFF2))),
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.iconPrefix != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: widget.iconPrefix,
                        )
                      : Container(width: 20),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        enabled: widget.enable,
                        onTap: () {
                          controllerInput.showLabelText();
                        },
                        decoration: InputDecoration(
                          fillColor: widget.fillColor != null
                              ? Colors.transparent
                              : Get.theme.cardColor,
                          filled: true,
                          errorText: null,
                          errorStyle: TextStyle(
                            color: Colors.transparent,
                            height: 0,
                            fontSize: 0,
                          ),
                          hintStyle: StyleApp.textFieldStyle(
                            context,
                            fontSize: 14.sp,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: InputBorder.none,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: InputBorder.none,
                          hintText: widget.labelText,
                          enabledBorder: InputBorder.none,
                        ),
                        controller: widget.controller,
                        onFieldSubmitted: (value) {},
                        onChanged: (v) {
                          if (widget.validator!(v) == null) {
                            controllerInput.changeCheckShowValidate(true);
                          } else {
                            controllerInput.changeCheckShowValidate(false);
                          }
                          widget.onChanged;
                        },
                        keyboardType: widget.keyboardType,
                        obscureText: controllerInput.isHideText.value,
                        maxLines: 1,
                        validator: (v) {
                          controllerInput
                              .updateValidField(widget.validator!(v));
                          return widget.validator!(v);
                        },
                      ),
                    ),
                  ),
                  controllerInput.isShowSuccessValidate.value &&
                          widget.keyboardType == TextInputType.emailAddress
                      ? Container()
                      : InkWell(
                          onTap: () {
                            controllerInput.changeStateShowText();
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 12),
                            child: widget.obscureText
                                ? !controllerInput.isHideText.value
                                    ? Icon(
                                        Icons.remove_red_eye_outlined,
                                        // color: AppColors.red,
                                        size: 18,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        color: Get.isDarkMode
                                            ? AppColors.colorWhite
                                            : null,
                                        size: 14,
                                      )
                                : Container(),
                          ),
                        ),
                ],
              ),
            ),
            controllerInput.validFiled.value.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      controllerInput.validFiled.value,
                      style: TextStyle(
                        color: Colors
                            .red, // widget.color != null ? AppColors.colorPrimary : AppColors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}

class InputPrimaryController extends GetxController {
  RxBool isHideText = false.obs;
  RxBool isShowSuccessValidate = false.obs;
  RxBool isShowLabel = false.obs;
  RxString validFiled = "".obs;
  void updateValidField(String? v) {
    if (v != null)
      validFiled.value = v;
    else
      validFiled.value = "";
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void initStateTextInput(bool showText) {
    isHideText.value = showText;
    update();
  }

  void changeStateShowText() {
    isHideText.value = !isHideText.value;
    update();
  }

  void changeCheckShowValidate(bool check) {
    isShowSuccessValidate.value = check;
    update();
  }

  void showLabelText() {
    isShowLabel.value = true;
    update();
  }
}
