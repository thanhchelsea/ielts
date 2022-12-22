import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:ielts/index.dart';
import 'package:ielts/utils/client_utils.dart';

import 'primary_button.dart';

class RecordWidget extends StatelessWidget {
  RecordWidget({
    Key? key,
    required this.file,
    required this.onTapMore,
  }) : super(key: key);
  FileSystemEntity file;
  Function onTapMore;
  @override
  Widget build(BuildContext context) {
    AudioController audioCtrl = Get.put(AudioController(filePath: file.path), tag: file.path.split("/").last);
    return Container(
      padding: EdgeInsets.symmetric(vertical: halfPadding, horizontal: halfPadding),
      decoration: BoxDecoration(color: Get.theme.cardColor, borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0,
          color: Color(0xff6F87C3).withOpacity(0.2),
        )
      ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  audioCtrl.playAudio();
                },
                child: Obx(
                  () => Icon(
                    !audioCtrl.isPlaying.value ? Icons.play_circle_outline_outlined : Icons.pause,
                    color: AppColors.colorInActive,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: padding),
              Expanded(
                child: StreamBuilder(
                  stream: audioCtrl.player.positionStream,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Obx(
                              () => SizedBox(
                                height: 6.h,
                                child: LinearProgressIndicator(
                                  value: audioCtrl.duration.value != null
                                      ? ClientUltis.percentProgressBar(
                                          snapshot.data as Duration, audioCtrl.duration.value!)
                                      : 0, // percent filled
                                  // ignore: prefer_const_constructors
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.colorActive,
                                  ),
                                  backgroundColor: AppColors.colorActive.withOpacity(0.5),
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ),
              SizedBox(width: padding),
              Container(
                margin: EdgeInsets.only(right: padding18),
                child: Obx(
                  () => Text(
                    audioCtrl.duration.value != null ? "${ClientUltis.getTimeAudio(audioCtrl.duration.value!)}" : "",
                    style: StyleApp.titleSmall(
                      fontSize: 10.sp,
                      color: AppColors.colorActive,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: padding10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  onTapMore();
                },
                child: Icon(
                  Icons.more_vert_outlined,
                  size: 20,
                ),
              ),
              SizedBox(width: padding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ClientUltis.getFileName(file.path),
                      style: StyleApp.titleBold(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: padding_4),
                    Text(
                      ClientUltis.getTimeCreteFile(file.path),
                      style: StyleApp.titleBold(fontSize: 12.sp, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(width: padding),
              PrimaryButton(
                labelText: "Submit",
                onPressed: () {},
                fontSizeText: 12.sp,
                padding: EdgeInsets.symmetric(horizontal: halfPadding, vertical: padding_6),
                colorBackground: AppColors.colorActive,
                borderRadius: 12,
                showShadow: false,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AudioController extends GetxController {
  String filePath;
  RxBool isPlaying = false.obs;
  Rxn<Duration> duration = Rxn<Duration>();
  AudioController({
    required this.filePath,
  });
  final player = AudioPlayer();

  void playAudio() async {
    isPlaying.value = player.playing;
    isPlaying.value = !isPlaying.value;

    if (isPlaying.value) {
      await player.play().then((value) async {
        if (isPlaying.value) await player.seek(Duration.zero);
        isPlaying.value = false;
        await player.stop();
      });
    } else {
      await player.pause();
    }
  }

  @override
  void onInit() async {
    await player.setFilePath(filePath);
    duration.value = player.duration;
    super.onInit();
  }

  @override
  void onClose() {
    player.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {}
}
