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
    print(":xxxxxx $data");
    return data;
  }

  static String convertDateComment(int date) {
    // print("time rb");
    String time = "";
    int toDayDate = DateTime.now().millisecondsSinceEpoch;
    int second = (toDayDate / 1000 - date / 1000).round();

    if (second < 60) {
      time = "1 " + "minute ago";
    } else if (second >= 60 && second < 60 * 60) {
      int minute = second ~/ 60;
      time = "$minute " + "${minute > 1 ? "minutes ago" : "minute ago"}";
    } else if (second >= 60 * 60 && second < 24 * 60 * 60) {
      int hour = second ~/ (60 * 60);
      int minute = (second % (60 * 60)) ~/ 60;
      time = "$hour " + "hour ago";
    } else {
      DateTime t = DateTime.fromMillisecondsSinceEpoch(date);
      String formattedDate = DateFormat('dd/MM/yyyy').format(t);
      time = formattedDate;
    }
    return time;
  }

  static bool compareTo({required String text1, required String text2}) {
    return text1
                .toLowerCase()
                .replaceAll(RegExp('[^A-Za-z0-9]'), '')
                .compareTo(text2.toLowerCase().replaceAll(RegExp('[^A-Za-z0-9]'), '')) <
            0
        ? false
        : true;
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
}
