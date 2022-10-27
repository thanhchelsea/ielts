import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:html/parser.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:video_player/video_player.dart';

class VideoController extends BaseController {
  Rxn<Topic> video = Rxn<Topic>();
  VideoPlayerController? videoPlayerController;
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  RxString nameTab = "".obs;

  @override
  void onReady() {
    video.value = LevelSkillController.to.topicChildSelected.value;
    initVideo();
    super.onReady();
  }

  initVideo() async {
    String url = getLinkVideo(video.value!.description);
    videoPlayerController = videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController!.initialize();
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController!,
      materialProgressColors: ChewieProgressColors(),
      autoPlay: true,
      looping: false,
    );
  }

  String getLinkVideo(String description) {
    String url = "";
    var document = parse(description);
    url = document.getElementsByTagName("img")[0].attributes["src-video-js"].toString();
    return url;
  }

  @override
  void onClose() {
    if (videoPlayerController != null) videoPlayerController!.dispose();
    if (chewieController.value != null) chewieController.value!.dispose();
    super.onClose();
  }
}
