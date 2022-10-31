import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:ielts/widget/image_cache.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscussionItem extends StatelessWidget {
  DiscussionItem({Key? key, required this.item}) : super(key: key);
  Discussion item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: padding12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            width: 45.w,
            height: 45.w,
            shape: BoxShape.circle,
          ),
          SizedBox(width: halfPadding),
          Expanded(
            child: Column(
              children: [
                content(),
                SizedBox(height: padding_6),
                action(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: halfPadding),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.fullName,
            style: StyleApp.titleBold(fontSize: 14.sp),
          ),
          SizedBox(height: padding_6),
          Text(
            item.content,
            style: StyleApp.titleSmall(),
          ),
        ],
      ),
    );
  }

  Widget action() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${ClientUltis.convertDateComment(item.createDate)}',
          style: StyleApp.titleExtraSmall(
            color: Color(0xff6B6B6B),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: padding20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                AppIcons.like,
                size: 22,
                color: Color(0xff6B6B6B),
              ),
              SizedBox(width: padding_4),
              Text(
                "${item.like.length}",
                style: StyleApp.titleExtraSmall(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff6B6B6B),
                ),
              )
            ],
          ),
        ),
        Text(
          '${item.childDiscussionIds.length} answer',
          style: StyleApp.titleExtraSmall(
            color: Color(0xff6B6B6B),
          ),
        ),
      ],
    );
  }
}
