import 'dart:convert';
import 'package:ielts/base/base_repository.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:logger/logger.dart';

import '../index.dart';

class ServerRepository extends BaseRepository {
  ServerRepository._getIntance();
  static ServerRepository? _intance;
  factory ServerRepository() {
    _intance ??= ServerRepository._getIntance();
    return _intance!;
  }

  var logger = Logger();
  Future<User?> loginAccount(String account, String password) async {
    User? user;
    String endpoint = "${ApiConfig.BASE_URL}/login";
    var params = {"account": account, "password": password, "token": ApiConfig.TOKEN};
    var dioCall = dioClient.post(
      endpoint,
      queryParameters: params,
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        user = User.fromMap(response.data['data']);
        return user;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> loginWithSessionId(String sessionId) async {
    User? user;
    String endpoint = "${ApiConfig.BASE_URL}/login-with-sessionId";
    var params = {
      "sessionId": sessionId,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(
      endpoint,
      queryParameters: params,
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        user = User.fromMap(response.data['data']);
        return user;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future getCourse(String sessionId) async {
    String endPoint = "${ApiConfig.BASE_URL}/get-courses";
    var params = {
      "sessionId": sessionId,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(dioCall).then((value) => null);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Topic>> getTopics({required String sessionId, required String parentId, required String courseId}) async {
    List<Topic> topics = [];
    String endPoint = "${ApiConfig.BASE_URL}/get-topics-by-parentId";
    var params = {
      "parentId": parentId,
      "courseId": courseId,
      "sessionId": sessionId,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        Map<String, dynamic> data = response.data;
        topics = (data['data'] as List).map((e) {
          return Topic.fromMap(e);
        }).toList();
        return topics;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Card>> getCardBytopicId({
    required List<int> ids,
    required int courseId,
    required String sessionId,
  }) async {
    List<Card> cards = [];

    String endPoint = "${ApiConfig.BASE_URL}/get-cards";
    var params = {
      "courseId": '$courseId',
      "ids": "${ClientUltis.getIdsFromList(ids)}",
      "sessionId": "$sessionId",
      "token": ApiConfig.TOKEN,
    };
    var diaCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(diaCall).then((response) {
        Map<String, dynamic> data = response.data;
        cards = (data['data'] as List).map((e) {
          return Card.fromMap(e);
        }).toList();
        return cards;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Document>> getDocument({required List<int> idsDocument}) async {
    String endPoint = "${ApiConfig.BASE_URL}/get-documents";
    List<Document> documents = [];
    var params = {
      // "sessionId": sessionId,
      "ids": ClientUltis.getIdsFromList(idsDocument),
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        Map<String, dynamic> data = response.data;
        documents = (data['data'] as List).map((e) => Document.fromMap(e)).toList();
        return documents;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<VideoScenario?> getVideoScrenarios({required int topicId}) async {
    String endPoint = "${ApiConfig.BASE_URL}/get-video-scenarios";
    var params = {
      // "sessionId": sessionId,
      "topicId": topicId,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        Map<String, dynamic> data = response.data;
        VideoScenario videoScenario = VideoScenario.fromMap(data['data'][0]);
        return videoScenario;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Discussion>> getComment({required int topicId}) async {
    String endPoint = "${ApiConfig.BASE_URL}/get-comments";
    var params = {
      // "sessionId": sessionId,
      "topicId": topicId,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(endPoint, queryParameters: params);
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) {
          Map<String, dynamic> data = response.data;
          var list = (data['data'] as List).map((e) => Discussion.fromMap(e)).toList();
          list.sort((a, b) => b.createDate.compareTo(a.createDate));
          return list;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendComment({required String ssId, required Discussion data, bool update = false}) async {
    String endPoint = "${ApiConfig.BASE_URL}/insert-comment";
    var params = {
      "sessionId": ssId,
      "token": ApiConfig.TOKEN,
    };
    print(data.toJson());
    var dioCall = dioClient.post(
      endPoint,
      queryParameters: params,
      data: jsonEncode(
        !update ? data.toMapSendComment() : data.toJson(),
      ),
    );
  }
}
