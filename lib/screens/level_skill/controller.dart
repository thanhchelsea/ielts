import 'package:get/get.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/sign_in/index.dart';

class LevelSkillController extends BaseController {
  static LevelSkillController to = Get.find();
  RxList<Topic> topics = <Topic>[].obs;
  ServerRepository serverRepo = ServerRepository();
  HomeController homeC = Get.find();
  Rxn<Topic> topicSelected = Rxn<Topic>();
  Rxn<Topic> topicChildSelected = Rxn<Topic>();

  RxMap<int, List<Topic>> topicChilds = RxMap<int, List<Topic>>();
  int courseId = 5112644562321408;
  Future loadTopicByParent({int? parentId}) async {
    String ssId = SignInController.to.getSessionId();
    var getTopic = serverRepo.getTopic(
      sessionId: ssId,
      parentId: "${parentId ?? courseId}",
      courseId: "$courseId",
    );
    await callDataService(
      getTopic,
      onSuccess: (response) {
        if (parentId == null) {
          //topic parent
          topics.value = response as List<Topic>;
          if (topics.isNotEmpty) {
            topicSelected.value = topics[0];
            for (var element in topics) {
              topicChilds.putIfAbsent(element.id, () => []);
            }
          }
        } else {
          //topic child
          List<Topic> topicChild = response as List<Topic>;
          topicChilds[parentId] = topicChild;
        }
      },
    );
  }

  void selectTopic(Topic t) {
    topicSelected.value = t;
    if (topicChilds[t.id] != null && topicChilds[t.id]!.isEmpty) loadTopicByParent(parentId: t.id);
  }

  void selectTopicChild(
    Topic t, {
    bool nextTopic = false,
  }) {
    print(t.id);
    topicChildSelected.value = t;
    if (nextTopic) {
      //next topic in video
      int index = 0;
      topicChilds.forEach((key, value) {
        if (t.parentId == key) {
          index = value.indexWhere((element) => element.id == t.id);
          if (index >= 0 && index < value.length) {
            topicChildSelected.value = value[index + 1];
          }
          return;
        }
      });
    }
    switch (topicChildSelected.value!.type) {
      case Configs.TOPIC_TYPE_LESSON:
        {
          !nextTopic ? Get.toNamed(RouterNames.VIDEO) : Get.offNamed(RouterNames.VIDEO);
          return;
        }
      case Configs.TOPIC_TYPE_TEST:
        {
          !nextTopic ? Get.toNamed(RouterNames.SPEAKING) : Get.offNamed(RouterNames.SPEAKING);
          return;
        }
    }
  }

  @override
  void onReady() {
    loadTopicByParent().then((value) {
      if (topicSelected.value != null) loadTopicByParent(parentId: topicSelected.value!.id);
    });
    super.onReady();
  }
}
