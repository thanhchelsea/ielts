import 'dart:io';
import 'dart:typed_data';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class AppRecorder {
  // AppRecorder._getIntance();
  // static AppRecorder? _intance;
  // factory AppRecorder() {
  //   _intance ??= AppRecorder._getIntance();
  //   return _intance!;
  // }

  FlutterSoundRecorder recorder = FlutterSoundRecorder(logLevel: Level.nothing);
  String filePath = '/sdcard/Download/temp.wav';
  bool isRecording = false;
//micro access
  void startIt() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

//record
  Future<FileSystemEntity?> startRecord({required String folderName}) async {
    isRecording = !isRecording;
    if (isRecording) {
      var tempDir = await getApplicationDocumentsDirectory();
      String nameFile = DateTime.now().millisecondsSinceEpoch.toString();
      String path = join(tempDir.path, folderName, "$nameFile.aac"); //'${tempDir.path}/$folderName/$nameFile.aac';
      await recorder.startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
      );
    } else {
      print("stop record");
      return await stopRecord();
    }
  }

  Future<void> pauseRecord() async {
    await recorder.pauseRecorder();
  }

  Future<void> continueRecord() async {
    await recorder.resumeRecorder();
  }

  Future<FileSystemEntity> stopRecord() async {
    final filePath = await recorder.stopRecorder();
    final file = await File(filePath ?? "null").create(recursive: true).then((value) async {
      Uint8List bytes = await value.readAsBytes();
      value.writeAsBytes(bytes);
      return value as FileSystemEntity;
    });
    return file;
  }

  Future closeRecord() async {
    await recorder.closeRecorder();
  }
}
