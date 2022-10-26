import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:ielts/base/base_repository.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:logger/logger.dart';

import '../index.dart';
import 'error_handlers.dart';
import 'exceptions/index.dart';

class ServerRepository extends BaseRepository {
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

  Future<List<Topic>> getTopic({required String sessionId, required String parentId, required String courseId}) async {
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
}
