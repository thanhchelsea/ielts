import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:ielts/widget/index.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../index.dart';
import '../screens/speaking/widget/button_record.dart';

typedef OnTextReaded = Function(List<String> texts);

class GrammarAndSpellingCheckDoc extends StatelessWidget {
  GrammarAndSpellingCheckDoc({
    Key? key,
    required this.tag,
    required this.doc,
    this.onTextReaded,
    this.isFocus = true,
  }) : super(key: key);
  String tag;
  List<String> doc;
  OnTextReaded? onTextReaded;
  bool isFocus;

  @override
  Widget build(BuildContext context) {
    return GetX<GrammarAndSpellingCheckDocController>(
      init: GrammarAndSpellingCheckDocController(
        onReaded: onTextReaded,
        raw: doc,
      ),
      tag: tag,
      builder: (controller) {
        if (isFocus) {
          return Rectangle3D(
            child: UIGame(controller),
          );
        }
        return UIGame(controller);
      },
    );
  }

  Widget UIGame(GrammarAndSpellingCheckDocController controller) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          width: double.infinity,
          padding: EdgeInsets.only(left: padding, right: padding, top: padding, bottom: padding_6),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: List.generate(
                    doc.length,
                    (index) {
                      Color color = colorText(index, controller);
                      return TextSpan(
                        text: doc[index] + " ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: color,
                          // decoration: TextDecoration.underline,
                        ),
                      );
                    },
                  ),
                ),
              ),
              isFocus
                  ? Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(top: 30),
                      child: MicroComponent(
                        onTap: () {
                          controller.onTapMicro();
                        },
                        recording: controller.isListening.value,
                        size: 50.w,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        isFocus ? Container() : const Divider(),
      ],
    );
  }

  Color colorText(int index, GrammarAndSpellingCheckDocController controller) {
    Color color = Colors.black;

    return controller.checkTextMatch(index)
        ? AppColors.colorPrimaryApp2
        : index < controller.textRecogni.length
            ? AppColors.errorColor
            : Colors.black;
  }

  ///Đọc đầy đủ : check theo index trả ra trạng thái của từng từ so với từ (*index) trong đoạn văn mẫu
  ///Đọc thiếu từ (nhảy cóc): từ sau (index+1) đúng với từ hiện tại đang đọc thì bỏ qua từ thiếu ( gán = ""), từ sau đó (index+1) bằng từ đã đọc và mảng đã được thêm từ trước đó mà kí tự rỗng
  MatchStatus checkTextMatchWithIndex({
    required String currentIndexText,
    required String afterIndexText,
    required String textCurrentReaded,
  }) {
    // print("$currentIndexText  $afterIndexText  $textCurrentReaded");
    bool checkReadedWithCurrentDoc = ClientUltis.textCompareTo(text1: currentIndexText, text2: textCurrentReaded);
    if (checkReadedWithCurrentDoc) {
      return MatchStatus.MATCH_CURRENT;
    } else {
      bool checkReadedWithAfterDoc = ClientUltis.textCompareTo(text1: afterIndexText, text2: textCurrentReaded);
      if (checkReadedWithAfterDoc) {
        return MatchStatus.MATCH_AFTER;
      }
    }
    return MatchStatus.DONT_MATCH;
  }
}

class GrammarAndSpellingCheckDocController extends GetxController {
  RxBool isTargetDoc = false.obs;
  Rxn<SpeechToText> speechToText = Rxn<SpeechToText>();
  RxBool isListening = false.obs;
  RxList<String> textRecogni = <String>[].obs;
  OnTextReaded? onTextReaded;
  late List<String> doc;

  RxList<int> indexMatch = <int>[].obs;

  GrammarAndSpellingCheckDocController({
    OnTextReaded? onReaded,
    required List<String> raw,
  }) {
    onTextReaded = onReaded;
    doc = raw;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    // _initSpeech();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _initSpeech();
    super.onInit();
  }

  void _initSpeech() async {
    speechToText.value = SpeechToText();
    await speechToText.value!.initialize(
      onStatus: (status) async {
        print("status speech to text: $status");
        if (status != "listening") {
          isListening.value = false;
          speechToText.refresh();
        }
      },
      onError: (errorNotification) async {
        print("error speech to text: ${errorNotification.errorMsg}");
        isListening.value = false;
        speechToText.refresh();
      },
    );
  }

  void onTapMicro() {
    speechToText.refresh();
    // textRecogni.clear();
    if (isListening.value == false) {
      startListening();
    } else {
      stopListening();
    }
  }

  void startListening() async {
    isListening.value = true;
    await speechToText.value!.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(minutes: 10),
      localeId: "en-US",
    );
  }

  void stopListening() async {
    isListening.value = false;
    await speechToText.value!.stop();
  }

  bool checkTextMatch(int index) {
    bool check = false;
    if (index < textRecogni.length) {
      MatchStatus matchStatus = checkTextMatchWithIndex(
        currentIndexText: doc[index],
        afterIndexText: doc[index + 1 > doc.length - 1 ? index : index + 1],
        textCurrentReaded: textRecogni[index],
      );

      if (matchStatus == MatchStatus.MATCH_CURRENT) {
        indexMatch.add(index);
      } else {
        if ((matchStatus == MatchStatus.MATCH_AFTER)) {
          int indexAfter = index + 1 > doc.length ? index : index + 1;
          textRecogni.insert(index, "${Configs.skipText} ");
          indexMatch.add(indexAfter);
        } else {}
      }
      // print(controller.textRecogni);
    }
    if (indexMatch.contains(index)) {
      check = true;
    }
    return check;
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    textRecogni.value = result.recognizedWords.split(" ");

    if (onTextReaded != null) {
      onTextReaded!(textRecogni.value);
    }
    // String lastText = result.recognizedWords.split(" ").last;
    // if (lastText.isNotEmpty) {
    //   if (!ClientUltis.textCompareTo(text1: lastText, text2: textRecogni.isNotEmpty ? textRecogni.last : "")) {
    //     textRecogni.add(lastText);
    //   }
    // }
  }

  @override
  void dispose() async {
    await speechToText.value!.stop();
    await speechToText.value!.cancel();
    super.dispose();
  }

  @override
  void onClose() async {
    await speechToText.value!.stop();
    await speechToText.value!.cancel();
    super.onClose();
  }

  MatchStatus checkTextMatchWithIndex({
    required String currentIndexText,
    required String afterIndexText,
    required String textCurrentReaded,
  }) {
    // print("$currentIndexText  $afterIndexText  $textCurrentReaded");
    bool checkReadedWithCurrentDoc = ClientUltis.textCompareTo(text1: currentIndexText, text2: textCurrentReaded);
    if (checkReadedWithCurrentDoc) {
      return MatchStatus.MATCH_CURRENT;
    } else {
      bool checkReadedWithAfterDoc = ClientUltis.textCompareTo(text1: afterIndexText, text2: textCurrentReaded);
      if (checkReadedWithAfterDoc) {
        return MatchStatus.MATCH_AFTER;
      }
    }
    return MatchStatus.DONT_MATCH;
  }
}

enum MatchStatus {
  DONT_MATCH,
  MATCH_AFTER,
  MATCH_CURRENT,
}
