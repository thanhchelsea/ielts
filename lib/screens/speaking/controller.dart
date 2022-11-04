import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:path/path.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/speaking/text_to_speach_controller.dart';
import 'package:ielts/services/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakingController extends BaseController {
  GlobalKey globalKeyListen = GlobalKey();
  Rxn<Topic> topic = Rxn<Topic>();
  // RxBool audioReading = false.obs;
  LevelSkillController levelSkillCtrl = Get.find();
  List<TargetFocus> listTargets = [];
  RxList<FileSystemEntity> recordeds = <FileSystemEntity>[].obs;
  late TutorialCoachMark tutorialCoachMark;
  var appRecorder = AppRecorder().obs;
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
    initTargets();
    showAppTutorial();

    super.onInit();
  }

  @override
  void onReady() async {
    topic.value = levelSkillCtrl.topicChildSelected.value;
    appRecorder.value = new AppRecorder();
    appRecorder.value.startIt();

    await Future.delayed(
      Duration(milliseconds: 500),
      () => tutorialCoachMark.show(context: Get.overlayContext!, rootOverlay: true),
    );
    await getRecords();
    dataSubList.value = stringToListString();
    super.onReady();
  }

  void textToSpeakData() async {
    var sTTCtrl = Get.find<TextToSpeakController>();
    await sTTCtrl.speak(data);
  }

  RxList<String> dataSubList = <String>[].obs;
  List<String> stringToListString() {
    List<String> s = [];
    s = data.replaceAll(RegExp('\\n'), ' ').split(" ");

    return s;
  }

//recorder

  Future startRecord() async {
    FileSystemEntity? r = await appRecorder.value.startRecord(folderName: topic.value!.id.toString());
    if (r != null) recordeds.add(r);

    appRecorder.refresh();
  }

  Future getRecords() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String path = join(
      tempDir.path,
      topic.value!.id.toString(),
    ); //'${tempDir.path}/$folderName/$nameFile.aac';

    recordeds.value = await ClientUltis.dirContents(Directory(path));
    recordeds.forEach((element) {
      print("data: ${element.path.split("/").last}");
    });
  }

  String data = """How World War One changed United States Society?
Early 1900s was a time of great changes in the United States. At the time, United States was considered the world leader because the country was changing rapidly. This was the progressive era when United States became highly industrialized.
""";
}
