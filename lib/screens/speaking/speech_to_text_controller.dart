import '../../base/base_contrller.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakToTextController extends BaseController {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void startListening() async {
    await _speechToText.listen(onResult: onSpeechResult);
  }

  void stopListening() async {
    await _speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    print("text recog: ${result.recognizedWords}");
    _lastWords = result.recognizedWords;
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    _speechToText.stop();
    _speechToText.cancel();
    super.onClose();
  }
}
