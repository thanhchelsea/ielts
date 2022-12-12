import 'dart:async';
import 'dart:io';

import 'index.dart';
import 'package:intl/intl.dart';

class ClientUltis {
  static String convertStatus(int status) {
    String message = "";
    switch (status) {
      // case Configs.LOGIN_SUCCESS:
      //   {
      //     message = "Đăng nhập thành công";
      //     break;
      //   }
      case Configs.LOGIN_FAILED:
        {
          message = "Đăng nhập thất bại";
          break;
        }
      case Configs.LOGIN_WRONG_PASSWORD:
        {
          message = "Sai mật khẩu";
          break;
        }
      case Configs.LOGIN_ACCOUNT_IS_USED:
        {
          message = "Tài khoản đã được sử dụng";
          break;
        }
      case Configs.TOKEN_VALID:
        {
          message = "Phiên đăng nhập hết hạn";
          break;
        }
      case Configs.LOGIN_ACCOUNT_NOT_EXIST:
        {
          message = "Tài khoản không tồn tại";
          break;
        }
      case Configs.LOGIN_NOT_EXISTED:
        {
          message = "${Configs.LOGIN_NOT_EXISTED}";
          break;
        }
    }
    return message;
  }

  static String getIdsFromList(List<dynamic> list) {
    String data = '';
    int index = 0;
    for (var q in list) {
      if (index > 0) {
        data += ',';
      }
      data += "${q}";
      index++;
    }
    data += '';
    return data;
  }

  static String convertDateComment(int date) {
    String time = "";
    int toDayDate = DateTime.now().millisecondsSinceEpoch;
    int second = (toDayDate / 1000 - date / 1000).round();

    if (second < 60) {
      time = "1 minute ago";
    } else if (second >= 60 && second < 60 * 60) {
      int minute = second ~/ 60;
      time = "$minute ${minute > 1 ? "minutes ago" : "minute ago"}";
    } else if (second >= 60 * 60 && second < 24 * 60 * 60) {
      int hour = second ~/ (60 * 60);
      // int minute = (second % (60 * 60)) ~/ 60;
      time = "$hour hour ago";
    } else {
      DateTime t = DateTime.fromMillisecondsSinceEpoch(date);
      String formattedDate = DateFormat('dd/MM/yyyy').format(t);
      time = formattedDate;
    }
    return time;
  }

  static List<String> stringToListString(String data) {
    List<String> s = [];
    s = data.replaceAll(RegExp('\\n'), ' ').split(" ");
    return s;
  }

  static bool textCompareTo({required String text1, required String text2}) {
    int checkCompare = text1
        .toLowerCase()
        .replaceAll(RegExp('[^A-Za-z0-9]'), '')
        .compareTo(text2.toLowerCase().replaceAll(RegExp('[^A-Za-z0-9]'), ''));
    return (checkCompare < 0 || checkCompare > 0) ? false : true;
  }

  static Future<List<FileSystemEntity>> dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen((file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }

  static String getFileName(String path) {
    return path.split("/").last;
  }

  static String getTimeCreteFile(String path) {
    final stat = FileStat.statSync(path);
    DateFormat("hh:mm");
    Duration diff = getStartDate(DateTime.now()).difference(getStartDate(stat.accessed));

    String createDate = "";
    if (diff.inHours < 24) {
      createDate = "Today at ${DateFormat("HH:mm").format(stat.accessed)}";
    } else {
      createDate = DateFormat('yyyy-MM-dd HH:mm').format(stat.accessed);
    }
    return createDate;
  }

  static DateTime getStartDate(DateTime time) {
    DateTime date = DateTime(time.year, time.month, time.day);
    return date;
  }

  static String getTimeAudio(Duration duration, {bool hasHour = true}) {
    if (hasHour) {
      return "${duration.inHours.remainder(24).toString().padLeft(2, "0")}:${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
    } else {
      return "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
    }
  }

  static double percentProgressBar(Duration a, Duration b) {
    if (a.inSeconds != 0 && b.inSeconds != 0) return a.inSeconds / b.inSeconds;
    return 0;
  }

  static String generateTopicProgressId(int courseId, int topicId, String userId) {
    return courseId.toString() + "_" + topicId.toString() + "_" + userId;
  }
}
