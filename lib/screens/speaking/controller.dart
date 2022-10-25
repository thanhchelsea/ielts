import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakingController extends BaseController {
  RxString nameTab = "".obs;
  GlobalKey globalKeyListen = GlobalKey();

  String data = """Only you know how I feel
Only you know what I miss
Can you see you're just what I need?
After all that we've been through
After all I've done for you
You should know my love is for real

Am I asking for too much?
Am I lwaiting for too long?
All I need is your tender touch
Don't you know I'm on my knees
Don't you know I'm begging please
Won't you take a look at me now?
Only you know how I feel
Only you know what I miss
After all that we've been through
After all I've done for you
You should know my love is for real

Am I asking for too much?
Am I lwaiting for too long?
All I need is your tender touch
Don't you know I'm on my knees
Don't you know I'm begging please
Won't you take a look at me now?
Only you know how I feel
Only you know what I miss
Am I asking for too much?
Am I lwaiting for too long?
All I need is your tender touch
Don't you know I'm on my knees
Don't you know I'm begging please
Won't you take a look at me now?
Only you know how I feel
Only you know what I miss

Am I asking for too much?
Am I lwaiting for too long?
All I need is your tender touch
Don't you know I'm on my knees
Don't you know I'm begging please
Won't you take a look at me now?
Only you know how I feel
Only you know what I miss
Am I asking for too much?
Am I lwaiting for too long?
All I need is your tender touch
Don't you know I'm on my knees
Don't you know I'm begging please
Won't you take a look at me now?
Only you know how I feel
Only you know what I miss""";
  List<TargetFocus> listTargets = [];
  late TutorialCoachMark tutorialCoachMark;

  void changeSelectTab(String name) {
    if (nameTab.value != name) {
      nameTab.value = name;
    }
  }

  void initTargets() {
    listTargets.add(
      TargetFocus(
        color: Color(0xFF323232),
        identify: "Target listen",
        keyTarget: globalKeyListen,
        paddingFocus: 6,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 260.w,
                      height: 100.h,
                      padding: EdgeInsets.symmetric(horizontal: largePadding, vertical: largePadding),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(AppImages.boxChat),
                        ),
                      ),
                      child: Text(
                        "You can, listen to the sample before recording!",
                        style: StyleApp.titleBold(
                          color: AppColors.colorActive,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Image(
                        width: 40.w,
                        height: 90.h,
                        image: AssetImage(AppImages.arrow),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );
  }

  void showAppTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: listTargets,
      colorShadow: Colors.grey,
      hideSkip: true,
      paddingFocus: 8,
      opacityShadow: 0.9,
      onFinish: () {},
      onClickTarget: (target) {},
      onSkip: () {},
      onClickOverlay: (target) {},
    );
  }

  @override
  void onInit() async {
    nameTab.value = "Practice";
    initTargets();
    showAppTutorial();

    super.onInit();
  }

  @override
  void onReady() async {
    if (Get.context == null) print("dmdmmd");
    await Future.delayed(
      Duration(seconds: 1),
      () => tutorialCoachMark.show(context: Get.overlayContext!, rootOverlay: true),
    );
    super.onReady();
  }
}
