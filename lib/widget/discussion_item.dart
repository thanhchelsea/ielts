import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/sign_in/index.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:ielts/widget/image_cache.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscussionItem extends StatelessWidget {
  DiscussionItem({
    Key? key,
    required this.item,
    this.margin,
    this.onTapLike,
  }) : super(key: key);
  Discussion item;
  EdgeInsets? margin;
  Function? onTapLike;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: padding12, right: extraLargePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCustom(
            width: 40.w,
            height: 40.w,
            shape: BoxShape.circle,
            url: item.imageURL,
            //  "https://scontent.fhan5-8.fna.fbcdn.net/v/t39.30808-6/313351409_840327683765737_6856931010520459187_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=dbeb18&_nc_ohc=AM58HrQxfa8AX_KLHq6&tn=KkiZPr2RM8Wgqpge&_nc_ht=scontent.fhan5-8.fna&oh=00_AfCZ7x-wFezP_jTmN0O9tTx53yxiaFZGw9USWntvI8G6zQ&oe=63665A91", //item.imageURL,
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
    Color colorLike;
    if (!item.like.contains(SignInController.to.user.value!.id)) {
      colorLike = const Color(0xff6B6B6B);
    } else {
      colorLike = AppColors.colorActive;
    }
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
              InkWell(
                onTap: () {
                  if (onTapLike != null) onTapLike!();
                },
                child: Icon(
                  AppIcons.like,
                  size: 22,
                  color: colorLike,
                ),
              ),
              SizedBox(width: padding_4),
              Text(
                "${item.like.length}",
                style: StyleApp.titleExtraSmall(
                  fontWeight: FontWeight.w600,
                  color: colorLike,
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
