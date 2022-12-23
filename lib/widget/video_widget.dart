import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/widget/index.dart';
import 'package:subtitle/subtitle.dart' as S;
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCustom extends StatelessWidget {
  VideoCustom({
    Key? key,
    // required this.tag,
    required this.idParentOfVideo,
    required this.textContainLinkVideo,
    this.height,
  }) : super(key: key);
  // String tag;
  int idParentOfVideo;
  String textContainLinkVideo;
  double? height;
  @override
  Widget build(BuildContext context) {
    return GetX<VideoCustomController>(
      tag: "${idParentOfVideo}",
      init: VideoCustomController(
        id: idParentOfVideo,
        textDes: textContainLinkVideo,
      ),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          margin: EdgeInsets.only(top: padding),
          child: controller.showVideo.value
              ? Container(
                  height: height ?? Get.height / 3.5,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: controller.chewieController.value != null
                            ? Container(
                                color: Colors.black,
                                child: controller.isLoading.value
                                    ? Chewie(
                                        controller: controller.chewieController.value!,
                                      )
                                    : const Loading(),
                              )
                            : Container(),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: buttonChangeShow(controller, title: "Hide"),
                      )
                    ],
                  ),
                )
              : buttonChangeShow(
                  controller,
                  title: "Show",
                ),
        );
      },
    );
  }

  Widget buttonChangeShow(
    VideoCustomController controller, {
    required String title,
  }) {
    return Row(
      children: [
        PrimaryButton(
          labelText: "$title",
          onPressed: () {
            controller.changeShowVideo();
          },
          colorBackground: Colors.black.withOpacity(0.5),
          fontSizeText: 10.sp,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          borderRadius: 12,
          titleWidget: Container(
            padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$title",
                  style: StyleApp.titleSmall(fontSize: 10.sp),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    !controller.showVideo.value ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                    size: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoCustomController extends BaseController {
  VideoCustomController({
    required int id,
    required textDes,
  }) {
    idParentOfVideo.value = id;
    textContainLinkVideo.value = textDes;
  }
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  ServerRepository serverRepo = ServerRepository();
  Rxn<VideoScenario> videoScenario = Rxn<VideoScenario>();
  VideoPlayerController? videoPlayerController;

  // Rxn<Topic> video = Rxn<Topic>();
  RxInt idParentOfVideo = 0.obs;
  RxString textContainLinkVideo = "".obs;
  RxBool showVideo = true.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    initVideo();
    super.onInit();
  }

  changeShowVideo() {
    showVideo.value = !showVideo.value;
    chewieController.value!.pause();
  }

  initVideo() async {
    isLoading.value = false;
    await getVideoScenarios();
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
    String url = getLinkVideo(textContainLinkVideo.value);
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController!.initialize();
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      looping: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      subtitle: Subtitles(
        subtile != null ? [...convertStringToSubTitle(subtile)] : [],
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
    isLoading.value = true;
  }

  Future getVideoScenarios() async {
    var getDoucment = serverRepo.getVideoScrenarios(topicId: idParentOfVideo.value);
    await callDataService(
      getDoucment,
      onSuccess: (response) {
        if (response != null) videoScenario.value = response as VideoScenario;
      },
    );
  }

  String getLinkVideo(String description) {
    String url = "";
    var document = parse(description);

    url = document.getElementsByTagName("img")[0].attributes["src-video-js"].toString();
    print("url video ${url.trim()} mm");
    return url.trim();
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

  @override
  void onClose() {
    // TODO: implement onClose
    if (videoPlayerController != null) videoPlayerController!.dispose();
    if (chewieController.value != null) chewieController.value!.dispose();
    super.onClose();
  }
}
