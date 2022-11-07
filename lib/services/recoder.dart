import 'dart:io';
import 'dart:typed_data';
import 'package:logger/logger.dart';
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
  // String filePath = '/sdcard/Download/temp.wav';
  bool isRecording = false;
  bool isPasue = false;
//micro access
  void startIt({required String folderName}) async {
    var tempDir = await getApplicationDocumentsDirectory();
    String path = join(
      tempDir.path,
      folderName,
      "audio.txt",
    );
    if (!File(path).existsSync()) {
      await File(path).create(recursive: true);
    }
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

//record
  Future<FileSystemEntity?> startRecord(
      {required String folderName,
      Function? onRecording,
      Function? onStopRecord}) async {
    isRecording = !isRecording;
    if (isRecording) {
      isPasue = false;
      if (onRecording != null) onRecording();
      var tempDir = await getApplicationDocumentsDirectory();
      String nameFile = DateTime.now().millisecondsSinceEpoch.toString();
      String path = join(
        tempDir.path,
        folderName,
        "$nameFile.aac",
      ); //'${tempDir.path}/$folderName/$nameFile.aac';
      await recorder.startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
      );
    } else {
      isPasue = false;
      print("stop record");
      if (onStopRecord != null) onStopRecord();
      return await stopRecord();
    }
  }

  Future<void> pauseRecord() async {
    if (recorder.isRecording) {
      print("pause nhe");
      await recorder.pauseRecorder();
    }

    isPasue = true;
  }

  Future<void> continueRecord() async {
    isPasue = false;
    await recorder.resumeRecorder();
  }

  Future<FileSystemEntity?> stopRecord({bool saveFile = true}) async {
    isRecording = false;
    isPasue = false;
    final filePath = await recorder.stopRecorder();
    if (!saveFile) {
      if (File(filePath ?? "null").existsSync()) {
        await File(filePath ?? "null").delete();
      }
      return null;
    } else {
      final file = await File(filePath ?? "null")
          .create(recursive: true)
          .then((value) async {
        Uint8List bytes = await value.readAsBytes();
        value.writeAsBytes(bytes);
        return value as FileSystemEntity;
      });
      return file;
    }
  }

  Future closeRecord() async {
    await stopRecord(saveFile: false);
    await recorder.closeRecorder();
  }
}
