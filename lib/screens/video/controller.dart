import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:html/parser.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:video_player/video_player.dart';
import 'package:subtitle/subtitle.dart' as S;

import '../sign_in/controller.dart';

class VideoController extends BaseController {
  Rxn<Topic> video = Rxn<Topic>();
  Rxn<VideoScenario> videoScenario = Rxn<VideoScenario>();
  RxList<Document> documents = <Document>[].obs;
  VideoPlayerController? videoPlayerController;
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  ServerRepository serverRepo = ServerRepository();
  List<String> nameTabs = ["Comment", "Document"];
  @override
  void onReady() async {
    video.value = LevelSkillController.to.topicChildSelected.value;
    await getVideoScenarios();
    await initVideo();
    super.onReady();
  }

  changeTab(String tab) async {
    switch (tab) {
      case "Comment":
        {
          break;
        }
      case "Document":
        {
          await getDocuments();
          break;
        }
    }
  }

//video
  initVideo() async {
    String? subtile;
    if (videoScenario.value != null) {
      if (videoScenario.value!.getUrlSubTitle() != null) {
        var url1 = Uri.parse(
          videoScenario.value!.getUrlSubTitle()!,
        );
        S.SubtitleProvider provider = S.NetworkSubtitle(url1);
        S.SubtitleObject object = await provider.getSubtitle();
        S.SubtitleParser parser = S.SubtitleParser(object);
        subtile = object.data;
      }
    } else {}
    String url = getLinkVideo(video.value!.description);
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController!.initialize();
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      subtitle: Subtitles(
        subtile != null ? [...convertStringToSubTitle(subtile!)] : [],
      ),
      subtitleBuilder: (context, subtitle) {
        return Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0x96000000),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              subtitle.toString(),
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  String getLinkVideo(String description) {
    String url = "";
    var document = parse(description);
    url = document.getElementsByTagName("img")[0].attributes["src-video-js"].toString();
    return url;
  }

  List<Subtitle> convertStringToSubTitle(String vtt) {
    var regex = RegExp(
        r'((\d{2}):(\d{2}):(\d{2})\.(\d+)) +--> +((\d{2}):(\d{2}):(\d{2})\.(\d{3})).*[\r\n]+\s*((?:(?!\r?\n\r?).)*(\r\n|\r|\n)(?:.*))');
    final matches = regex.allMatches(vtt);
    final List<Subtitle> subtitleList = [];
    int index = 0;
    for (final RegExpMatch regExpMatch in matches) {
      final startTimeHours = int.parse(regExpMatch.group(2)!);
      final startTimeMinutes = int.parse(regExpMatch.group(3)!);
      final startTimeSeconds = int.parse(regExpMatch.group(4)!);
      final startTimeMilliseconds = int.parse(regExpMatch.group(5)!);

      final endTimeHours = int.parse(regExpMatch.group(7)!);
      final endTimeMinutes = int.parse(regExpMatch.group(8)!);
      final endTimeSeconds = int.parse(regExpMatch.group(9)!);
      final endTimeMilliseconds = int.parse(regExpMatch.group(10)!);
      final text = removeAllHtmlTags(regExpMatch.group(11)!);

      final startTime = Duration(
        hours: startTimeHours,
        minutes: startTimeMinutes,
        seconds: startTimeSeconds,
        milliseconds: startTimeMilliseconds,
      );
      final endTime = Duration(
        hours: endTimeHours,
        minutes: endTimeMinutes,
        seconds: endTimeSeconds,
        milliseconds: endTimeMilliseconds,
      );
      Subtitle s = Subtitle(
        index: index,
        start: startTime,
        end: endTime,
        text: text,
      );
      // print(s);
      subtitleList.add(Subtitle(index: index, start: startTime, end: endTime, text: text.trim()));
      index++;
    }
    return subtitleList;
  }

  String removeAllHtmlTags(String htmlText) {
    final exp = RegExp(
      '(<[^>]*>)',
      multiLine: true,
    );
    var newHtmlText = htmlText;
    exp.allMatches(htmlText).toList().forEach(
      (RegExpMatch regExpMatch) {
        newHtmlText = regExpMatch.group(0) == '<br>'
            ? newHtmlText.replaceAll(regExpMatch.group(0)!, '\n')
            : newHtmlText.replaceAll(regExpMatch.group(0)!, '');
      },
    );
    return newHtmlText;
  }

//document
  Future getDocuments() async {
    if (documents.isNotEmpty) return;
    var getDoucment = serverRepo.getDocument(idsDocument: video.value!.documentIds);
    callDataService(
      getDoucment,
      onSuccess: (response) {
        documents.value = response as List<Document>;
      },
    );
  }

  //get-video-scenarios
  Future getVideoScenarios() async {
    var getDoucment = serverRepo.getVideoScrenarios(topicId: video.value!.id);
    await callDataService(
      getDoucment,
      onSuccess: (response) {
        videoScenario.value = response as VideoScenario;
      },
    );
  }

  @override
  void onClose() {
    if (videoPlayerController != null) videoPlayerController!.dispose();
    if (chewieController.value != null) chewieController.value!.dispose();
    super.onClose();
  }
}
