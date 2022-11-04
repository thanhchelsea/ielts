import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'dart:io' show Platform;

enum STATESTT {
  STOP,
  PLAYING,
  CONTINUE,
  PAUSE,
}

class TextToSpeakController extends BaseController {
  Rx<STATESTT> state = STATESTT.STOP.obs;
  FlutterTts flutterTts = FlutterTts();
  RxList<String> readed = <String>[].obs;
  initTTS() async {
    // await flutterTts.awaitSpeakCompletion(true);
    // await flutterTts.awaitSynthCompletion(true);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    // await flutterTts.setVoice({"name": "Lee", "locale": "en-AU"});
  }

  Future<void> speak(String text) async {
    await flutterTts.stop();
    readed.clear();
    await flutterTts.speak(text.toLowerCase());
  }

  @override
  void onReady() async {
    await initTTS();
    flutterTts.setProgressHandler((text, start, end, word) {
      word = word.replaceAll(RegExp('\\n'), '').replaceAll(RegExp('[^A-Za-z0-9]'), '').toLowerCase();
      readed.add(word);
      state.value = STATESTT.PLAYING;
      // print(readed);
    });
    flutterTts.setCompletionHandler(() {
      state.value = STATESTT.STOP;
    });
    super.onReady();
  }

  @override
  void onClose() async {
    await flutterTts.stop();
    super.onClose();
  }
}
