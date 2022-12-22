import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:html/parser.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:video_player/video_player.dart';
import 'package:subtitle/subtitle.dart' as S;

import '../sign_in/controller.dart';

class VideoController extends BaseController {
  //data
  Rxn<Topic> video = Rxn<Topic>();
  RxList<Document> documents = <Document>[].obs;
  RxList<Discussion> discussion = <Discussion>[].obs;
  TextEditingController textEditingController = TextEditingController();
  ServerRepository serverRepo = ServerRepository();
  List<String> nameTabs = ["Comment", "Document"];
  @override
  void onReady() async {
    video.value = LevelSkillController.to.topicChildSelected.value;

    await getComment();
    super.onReady();
  }

  changeTab(String tab) async {
    switch (tab) {
      case "Comment":
        {
          break;
        }
      case "Document":
        {
          await getDocuments();
          break;
        }
    }
  }

//document
  Future getDocuments() async {
    if (documents.isNotEmpty) return;
    var getDoucment = serverRepo.getDocument(idsDocument: video.value!.documentIds);
    callDataService(
      getDoucment,
      onSuccess: (response) {
        documents.value = response as List<Document>;
      },
    );
  }

//get comment
  Future getComment() async {
    var getComment = serverRepo.getComment(topicId: video.value!.id);
    await callDataService(
      getComment,
      onSuccess: (response) {
        discussion.value = response as List<Discussion>;
      },
    );
  }

  //insert comment
  Future sendComment() async {
    String ssId = SignInController.to.getSessionId();
    Discussion discussion = Discussion.initDicussion(
      pId: video.value!.id,
      cId: video.value!.courseId,
      tId: video.value!.id,
      uId: SignInController.to.user.value!.id,
      uName: SignInController.to.user.value!.fullName,
      ct: textEditingController.text,
    );
    var getComment = serverRepo.sendComment(data: discussion, ssId: ssId);
    await callDataService(
      getComment,
      onSuccess: (response) {
        textEditingController.text = "";
      },
    );
  }

  Future likeOrDislikeComment(Discussion d) async {
    String ssId = SignInController.to.getSessionId();
    String userId = SignInController.to.user.value!.id;
    if (d.like.contains(userId)) {
      d.like.remove(userId);
    } else {
      d.like.add(userId);
    }
    var action = serverRepo.sendComment(data: d, ssId: ssId, update: true);
    await callDataService(
      action,
      onSuccess: (response) {},
    );
  }

  void nextTopic() {
    LevelSkillController.to.selectTopicChild(video.value!, nextTopic: true);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
