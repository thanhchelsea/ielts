import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts/screens/speaking/speech_to_text_controller.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:path/path.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/speaking/text_to_speech_controller.dart';
import 'package:ielts/services/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakingController extends BaseController {
  GlobalKey globalKeyListen = GlobalKey();
  Rxn<Topic> topic = Rxn<Topic>();
  LevelSkillController levelSkillCtrl = Get.find();
  List<TargetFocus> listTargets = [];
  RxList<FileSystemEntity> recordeds = <FileSystemEntity>[].obs;
  var durationCurrentRecord = Duration.zero.obs;
  final store = PreferenceImpl();
  late TutorialCoachMark tutorialCoachMark;
  var appRecorder = AppRecorder().obs;
  TextEditingController textEditingCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SpeakToTextController speakToTextCtrl = Get.find();
  void initTargetsTutorial() {
    listTargets.add(
      TargetFocus(
        color: const Color(0xFF323232),
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

  Future showAppTutorial() async {
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
    var showGuildExists = await store.readStore(key: PreferenceManager.guildPratice);
    if (showGuildExists == null) {
      await Future.delayed(
        Duration(milliseconds: 500),
        () {
          tutorialCoachMark.show(
            context: Get.overlayContext!,
            rootOverlay: true,
          );
        },
      );
    }
    await store.writeStore(key: PreferenceManager.guildPratice, value: true);
  }

  @override
  void onInit() async {
    initTargetsTutorial();
    super.onInit();
  }

  @override
  void onReady() async {
    showAppTutorial();
    topic.value = levelSkillCtrl.topicChildSelected.value;
    appRecorder.value = AppRecorder();
    appRecorder.value.startIt(folderName: topic.value!.id.toString());
    await getRecords();
    dataSubList.value = ClientUltis.stringToListString(data);
    super.onReady();
  }

  void textToSpeakData() async {
    var sTTCtrl = Get.find<TextToSpeakController>();
    await sTTCtrl.speak(data);
  }

  RxList<String> dataSubList = <String>[].obs;

//recorder
  Timer? timer;

  Future getRecords() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String path = join(
      tempDir.path,
      topic.value!.id.toString(),
    ); //'${tempDir.path}/$folderName/$nameFile.aac';

    callDataService(
      ClientUltis.dirContents(Directory(path)),
      onSuccess: (response) {
        recordeds.value = response as List<FileSystemEntity>;
        recordeds.forEach((element) {
          print("nanana ${element.path}");
        });
        recordeds.removeWhere(
          (element) => element.path.split("/").last.split(".").last.contains("txt"),
        );
        recordeds.sort(
          (a, b) => b.statSync().accessed.compareTo(a.statSync().accessed),
        );
      },
    );
  }

  Future startRecord() async {
    durationCurrentRecord.value = Duration.zero;

    FileSystemEntity? r = await appRecorder.value.startRecord(
      folderName: topic.value!.id.toString(),
      onRecording: () {
        speakToTextCtrl.startListening();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (appRecorder.value.isPasue == false) {
            durationCurrentRecord.value = Duration(seconds: durationCurrentRecord.value.inSeconds + 1);
          }
        });
      },
      onStopRecord: () {
        if (timer != null) timer!.cancel();
      },
    );
    // if (timer != null) {
    //   timer!.cancel();
    // }
    if (r != null) recordeds.insert(0, r);
    appRecorder.refresh();
  }

  void reRecord() async {
    await appRecorder.value.pauseRecord();
    appRecorder.refresh();
    if (appRecorder.value.isRecording) {
      Get.dialog(
        DialogApp(
          icon: SvgPicture.asset(AppImages.again),
          // icon: Image(image: AssetImage(AppImages.again)),
          titleCofirm: "Record",
          titleCancle: "Keep recording",
          description: "You want to record from scratch?",
          onCancel: () async {
            Get.back();
            await appRecorder.value.continueRecord();
            appRecorder.refresh();
          },
          onConfirm: () async {
            if (timer != null) timer!.cancel();
            await appRecorder.value.stopRecord(saveFile: false);
            await startRecord();
            Get.back();
          },
        ),
      );
    }
  }

  void finishRecord() async {
    await appRecorder.value.pauseRecord();
    appRecorder.refresh();
    if (appRecorder.value.isRecording) {
      Get.dialog(
        DialogApp(
          icon: SvgPicture.asset(AppImages.cut),
          // icon: Image(image: AssetImage(AppImages.again)),
          titleCofirm: "Finish",
          titleCancle: "Keep recording",
          description: "Haven't recorded the entire reading,\n do you want to end it?",
          onCancel: () async {
            Get.back();
            await appRecorder.value.continueRecord();
            appRecorder.refresh();
          },
          onConfirm: () async {
            if (timer != null) timer!.cancel();
            await startRecord();
            Get.back();
          },
        ),
      );
    }
  }

  void backScreenPrevious() async {
    if (appRecorder.value.isRecording) {
      await appRecorder.value.pauseRecord();
      appRecorder.refresh();
      if (appRecorder.value.isRecording) {
        Get.dialog(
          DialogApp(
            icon: SvgPicture.asset(AppImages.delete),
            titleCofirm: "Exit",
            titleCancle: "Keep recording",
            description: "Not finished recording, do you want to exit?",
            onCancel: () async {
              Get.back();
              await appRecorder.value.continueRecord();
              appRecorder.refresh();
            },
            onConfirm: () async {
              if (Get.isDialogOpen ?? false) {
                Get.until((route) => !Get.isDialogOpen!);
              }
              Get.back();
            },
          ),
        );
      }
    } else {
      Get.back();
    }
  }

  onTapMoreOfFile(FileSystemEntity fileSystemEntity) {
    BottomSheetApp().showActionSheet(
      actions: [
        ActionBottomSheet(
          title: "Share(pro)",
          onTap: () {},
        ),
        ActionBottomSheet(
          title: "Rename",
          onTap: () async {
            Get.back();
            Get.dialog(
              DialogApp(
                icon: Text(
                  "Rename",
                  style: StyleApp.titleNormal(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // icon: Image(image: AssetImage(AppImages.again)),
                titleCofirm: "Rename",
                titleCancle: "Cancel",
                description: "",
                desWidget: Form(
                  key: _formKey,
                  child: InputFiledCustom(
                    fillColor: Color(0xffEAEAEA).withOpacity(0.8),
                    controller: textEditingCtrl,
                    // iconPrefix: Icon(AppIcons.user),
                    labelText: "${ClientUltis.getFileName(fileSystemEntity.path).split(".").first}",
                    validator: (v) {
                      return Validator().nameFile(v ?? "");
                    },
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    color: AppColors.colorDark,
                  ),
                ),
                onCancel: () async {
                  Get.back();
                  textEditingCtrl.text = "";
                },
                onConfirm: () async {
                  if (_formKey.currentState!.validate()) {
                    if (File(fileSystemEntity.path).existsSync() && textEditingCtrl.text.isNotEmpty) {
                      var path = fileSystemEntity.path;
                      var lastSeparator = path.lastIndexOf(Platform.pathSeparator);

                      var newPath = path.substring(0, lastSeparator + 1) + "${textEditingCtrl.text}.aac";
                      int index = recordeds.indexWhere((element) => element.path == fileSystemEntity.path);
                      var replace = await fileSystemEntity.rename(newPath);
                      recordeds.removeAt(index);
                      recordeds.insert(index, replace);
                      textEditingCtrl.text = "";
                    }
                    Get.back();
                  }
                },
              ),
            );
          },
        ),
        ActionBottomSheet(
          title: "Delete",
          onTap: () async {
            if (File(fileSystemEntity.path).existsSync()) {
              await File(fileSystemEntity.path).delete();
              recordeds.remove(fileSystemEntity);
            }
            Get.back();
          },
        ),
      ],
    );
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    appRecorder.value.closeRecord();
    super.onClose();
  }

  String data = """How World War One changed United States Society?
Early 1900s was a time of great changes in the United States. At the time, United States was considered the world leader because the country was changing rapidly. This was the progressive era when United States became highly industrialized.
""";
}
