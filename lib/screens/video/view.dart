import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class VideoUI extends BaseView<VideoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Video",
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: [
          video(),
          SizedBox(height: padding10),
          Expanded(child: tabAction()),
        ],
      ),
    );
  }

  Widget video() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      margin: EdgeInsets.only(top: padding),
      height: Get.height / 3.5,
      child: Obx(
        () {
          if (controller.chewieController.value != null && controller.videoPlayerController != null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Chewie(
                controller: controller.chewieController.value!,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget tabAction() {
    return TabBarPage(
      nameTabs: controller.nameTabs,
      iconTabs: [AppIcons.comment, AppIcons.dowload_file],
      id: Get.currentRoute,
      tabsView: [discussionWidget(), documentWidget()],
      onTap: (tab) {
        controller.changeTab(tab);
      },
      marginTabbar: EdgeInsets.symmetric(horizontal: padding),
      showDivider: true,
      actionInsert: [
        PrimaryButton(
          colorBackground: AppColors.colorPrimaryApp,
          borderRadius: 15,
          labelText: "Next",
          fontWeight: FontWeight.w800,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          onPressed: () {},
          showShadow: true,
          titleWidget: Container(
            padding: EdgeInsets.only(top: 7.h, bottom: 7.h, left: padding12, right: halfPadding),
            child: Row(
              children: [
                Text("Next", textAlign: TextAlign.center, style: StyleApp.titleButton()),
                const SizedBox(width: 8),
                const Icon(Icons.navigate_next)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget discussionWidget() {
    return Expanded(
      child: Stack(
        children: [
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: padding),
              child: ListView.builder(
                padding: EdgeInsets.only(top: padding12, bottom: 100),
                itemCount: controller.discussion.length,
                itemBuilder: (context, index) {
                  return DiscussionItem(item: controller.discussion[index]);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: halfPadding),
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
              ),
              width: Get.width,
              child: Row(
                children: [
                  SizedBox(width: padding20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: padding20, vertical: 0),
                      decoration: BoxDecoration(
                        color: Color(0xffF0F2F5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: controller.textEditingController,
                        decoration: InputDecoration(
                          hintText: "Type your message here...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print("send comment");
                      controller.sendComment();
                    },
                    icon: const Icon(
                      AppIcons.send,
                      color: Color(0xff388CFD),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget documentWidget() {
    return Expanded(
      child: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: List.generate(
                controller.documents.length,
                (index) => Container(
                  margin: EdgeInsets.only(bottom: padding10),
                  // padding: EdgeInsets.symmetric(horizontal: padding14, vertical: padding14),
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    child: ExpansionTile(
                      trailing: const Icon(
                        AppIcons.download,
                        color: AppColors.colorActive,
                        size: 20,
                      ),
                      title: Row(
                        children: [
                          SizedBox(width: padding_2),
                          const Icon(
                            AppIcons.document,
                          ),
                          SizedBox(width: padding10),
                          Expanded(
                            child: Text(
                              controller.documents[index].title,
                              style: StyleApp.titleNormal(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: padding12),
                            // width: 300,
                            height: 500.h,
                            child: SfPdfViewer.network(
                              controller.documents[index].url,
                            )
                            // child: SfPdfViewer.network(controller.documents[index].url),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        //  ListView.builder(
        //   controller: ScrollController(),
        //   padding: EdgeInsets.only(top: padding10, bottom: 350.h),
        //   // shrinkWrap: true,
        //   itemCount: controller.documents.length,
        //   // physics: NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return Container(
        //       margin: EdgeInsets.only(bottom: padding10),
        //       // padding: EdgeInsets.symmetric(horizontal: padding14, vertical: padding14),
        //       decoration: BoxDecoration(
        //         color: Get.theme.cardColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Container(
        //         child: ExpansionTile(
        //           trailing: const Icon(
        //             AppIcons.download,
        //             color: AppColors.colorActive,
        //             size: 20,
        //           ),
        //           title: Row(
        //             children: [
        //               SizedBox(width: padding_2),
        //               const Icon(
        //                 AppIcons.document,
        //               ),
        //               SizedBox(width: padding10),
        //               Expanded(
        //                 child: Text(
        //                   controller.documents[index].title,
        //                   style: StyleApp.titleNormal(
        //                     fontSize: 14.sp,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           children: <Widget>[
        //             Container(
        //                 margin: EdgeInsets.symmetric(horizontal: padding12),
        //                 // width: 300,
        //                 height: 500.h,
        //                 child: SfPdfViewer.network(
        //                   controller.documents[index].url,
        //                 )
        //                 // child: SfPdfViewer.network(controller.documents[index].url),
        //                 ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
