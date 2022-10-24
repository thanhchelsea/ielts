import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? appBarTitleText;
  final List<Widget>? actions;
  final bool isBackButtonEnabled;
  final bool showBackScreen;
  final double elevation;
  final Color? backgroundColor;
  CustomAppBar({
    Key? key,
    this.appBarTitleText,
    this.actions,
    this.isBackButtonEnabled = true,
    this.showBackScreen = true,
    this.elevation = 5,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;
  var overlayStyle = SystemUiOverlayStyle.light; // 1

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.colorWhite,
      centerTitle: false,
      elevation: elevation,
      shadowColor: Color.fromARGB(66, 240, 240, 240),
      automaticallyImplyLeading: false,
      actions: actions,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: padding14),
            child: showBackScreen
                ? IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.navigate_before,
                      color: Colors.black,
                      size: 34,
                    ),
                  )
                : InkWell(
                    onTap: () {},
                    child: Container(
                      width: 22.w,
                      height: 18.h,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage(AppImages.menu),
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: appBarTitleText != null
                ? Text(
                    appBarTitleText!,
                    style: StyleApp.pageTitle(fontSize: 16.sp),
                    textAlign: TextAlign.start,
                  )
                : Container(),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              AppIcons.notifi_icon,
              size: 22,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
