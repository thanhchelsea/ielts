// import 'package:get/get.dart';
// import 'package:ielts/utils/client_utils.dart';
// import '../../base/base_contrller.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class SpeakToTextController extends BaseController {
//   late SpeechToText _speechToText;
//   RxBool isListening = false.obs;
//   RxList<String> textRecogni = <String>[].obs;

//   @override
//   void onReady() {
//     _initSpeech();
//     super.onReady();
//   }

//   void _initSpeech() async {
//     _speechToText = SpeechToText();
//     await _speechToText.initialize(
//       onStatus: (status) async {
//         print("status speech to text12: $status");
//         if (status != "listening") {
//           await _speechToText.cancel();

//           isListening.value = false;
//           refresh();
//         }
//       },
//       onError: (errorNotification) async {
//         print("error status speech to text111: ${errorNotification.errorMsg}");
//         isListening.value = false;
//         await _speechToText.cancel();

//         refresh();
//       },
//       finalTimeout: const Duration(seconds: 10),
//     );
//   }

//   void onTapMicro() {
//     textRecogni.clear();
//     if (isListening.value == false) {
//       startListening();
//     } else {
//       stopListening();
//     }
//   }

//   void startListening() async {
//     isListening.value = true;
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: const Duration(minutes: 10),
//       localeId: "en-US",
//     );
//   }

//   void stopListening() async {
//     isListening.value = false;
//     await _speechToText.stop();
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     // print(result.recognizedWords);
//     String lastText = result.recognizedWords.split(" ").last;
//     if (lastText.isNotEmpty) {
//       if (!ClientUltis.textCompareTo(text1: lastText, text2: textRecogni.isNotEmpty ? textRecogni.last : "")) {
//         textRecogni.add(lastText);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _speechToText.stop();
//     _speechToText.cancel();
//     super.dispose();
//   }

//   @override
//   void onClose() {
//     _speechToText.stop();
//     _speechToText.cancel();
//     super.onClose();
//   }
// }
