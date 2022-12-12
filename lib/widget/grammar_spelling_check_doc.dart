import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ielts/utils/client_utils.dart';
import '../index.dart';

class GrammarAndSpellingCheckDoc extends StatelessWidget {
  GrammarAndSpellingCheckDoc({
    Key? key,
    required this.doc,
    required this.textReaded,
  }) : super(key: key);
  List<String> doc;
  List<String> textReaded;
  List<int> indexMatch = [];
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: List.generate(
          doc.length,
          (index) {
            Color color = colorText(index);
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
    );
  }

  Color colorText(int index) {
    Color color = Colors.black;
    if (index < textReaded.length) {
      MatchStatus matchStatus = checkTextMatchWithIndex(
        currentIndexText: doc[index],
        afterIndexText: doc[index + 1 > doc.length ? index : index + 1],
        textCurrentReaded: textReaded[index],
      );
      // print(
      //     "math status: ${doc[index]} ${doc[index + 1 > doc.length ? index : index + 1]} ${textReaded[index]}  index: $index \n $matchStatus ");
      if (matchStatus == MatchStatus.MATCH_CURRENT) {
        color = AppColors.colorPrimaryApp2;
        indexMatch.add(index);
      } else {
        if ((matchStatus == MatchStatus.MATCH_AFTER)) {
          int indexAfter = index + 1 > doc.length ? index : index + 1;
          textReaded.insert(index, "111");
          indexMatch.add(indexAfter);
          color = AppColors.colorPrimaryApp2;
        } else {
          color = AppColors.errorColor;
        }
      }
      print(textReaded);
    }
    return indexMatch.contains(index)
        ? AppColors.colorPrimaryApp2
        : index < textReaded.length
            ? AppColors.errorColor
            : Colors.black;
  }

  ///Đọc đầy đủ : check theo index trả ra trạng thái của từng từ so với từ (*indẽx) trong đoạn văn mẫu
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
  List<int> indexMatch = [];
}

enum MatchStatus {
  DONT_MATCH,
  MATCH_AFTER,
  MATCH_CURRENT,
}
