import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/screens/sign_in/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/widget/primary_button.dart';

import '../../index.dart';
import '../../widget/primary_input_filed.dart';

class SignInUI extends BaseView<SignInController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: Get.isDarkMode
              ? null
              : RadialGradient(
                  colors: [Color.fromRGBO(142, 235, 255, 0.4), Colors.white.withOpacity(0.1)],
                  center: Alignment(-1.0, 1.0),
                  radius: 1,
                ),
        ),
        child: Container(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.height / 6),
              logo(context),
              SizedBox(height: 50.h),
              Column(
                children: [
                  input(),
                  SizedBox(height: Get.height * 0.06),
                  buttonBottom(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logo(BuildContext context) {
    return Column(
      children: [
        Image(
          width: 130.w,
          image: AssetImage(AppImages.logoInApp),
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget input() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputFiledCustom(
                controller: controller.userName,
                iconPrefix: Icon(AppIcons.mic),
                labelText: 'Username',
                validator: (p0) {
                  return null;
                  // return Validator().notEmpty(p0, 'username');
                },
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => null,
                color: AppColors.colorDark,
              ),
              SizedBox(height: 16),
              InputFiledCustom(
                controller: controller.password,
                iconPrefix: Icon(AppIcons.sound),
                labelText: 'auth.password'.tr,
                validator: (p0) {
                  return null;

                  // return Validator().notEmpty(p0, "password") ?? Validator().password(p0);
                },
                obscureText: true,
                color: AppColors.colorDark,
                onChanged: (value) => null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonBottom(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: PrimaryButton(
              labelText: "Login",
              onPressed: () {
                controller.signIn();
              },
              width: 150.w,
            ),
          ),
          SizedBox(height: Get.height * 0.033),
          SizedBox(height: Get.height * 0.05),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    "Have not had any account?",
                    style: StyleApp.titleExtraSmall(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ), //Đăng ký ngay
                WidgetSpan(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Sign up now",
                      style: StyleApp.titleExtraSmall(
                        color: AppColors.colorPrimaryApp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
