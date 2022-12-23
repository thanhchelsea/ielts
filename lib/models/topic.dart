import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ielts/utils/client_utils.dart';

import '../index.dart';

class Topic {
  int id;
  String userId;
  int parentId;
  int courseId;
  int ranking;
  int lastUpdate;
  int status;
  int startTime;
  int endTime;
  String name;
  String description;
  int totalCardNum;
  int questionNumber;
  int timePractice;
  double scoreScale;
  int questionPracticeNum;
  int totalTest;
  List<int> childrentIds;
  String shortDescription;
  int type;
  int studyMode;
  int duration;
  int pass;
  MyCardData? myCardData;
  TopicProgress? progress;
  List<int> documentIds;

  TopicProgress getTopicProgress() {
    if (this.progress != null) {
      this.progress!.lastChildCardNum = this.childrentIds.length;
      return this.progress!;
    } else {
      String userID = ClientData.user?.id ?? "";
      String id = ClientUltis.generateTopicProgressId(courseId, this.id, userID);
      TopicProgress data = TopicProgress(
        id: id,
        parentId: this.parentId,
        topicId: this.id,
        userId: userID,
        courseId: this.courseId,
        lastUpdate: this.lastUpdate,
        lastChildCardNum: childrentIds.length,
        categoryName: "",
        languageId: 0,
        passed: 0,
        progress: 0,
        status: 1,
        studyStatus: 1,
        testScore: 0,
        topicDatabase: 0,
        userName: "",
        viewNum: 0,
      );

      this.progress = data;
      return data;
    }
  }

  Topic({
    required this.id,
    required this.userId,
    required this.parentId,
    required this.courseId,
    required this.ranking,
    required this.lastUpdate,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.description,
    required this.totalCardNum,
    required this.questionNumber,
    required this.timePractice,
    required this.scoreScale,
    required this.questionPracticeNum,
    required this.totalTest,
    required this.childrentIds,
    required this.shortDescription,
    required this.type,
    required this.studyMode,
    required this.duration,
    required this.pass,
    required this.myCardData,
    required this.documentIds,
    required this.progress,
  });

  Topic copyWith({
    int? id,
    String? userId,
    int? parentId,
    int? courseId,
    int? ranking,
    int? lastUpdate,
    int? status,
    int? startTime,
    int? endTime,
    String? name,
    String? description,
    int? totalCardNum,
    int? questionNumber,
    int? timePractice,
    double? scoreScale,
    int? questionPracticeNum,
    int? totalTest,
    List<int>? childrentIds,
    String? shortDescription,
    int? type,
    int? studyMode,
    int? duration,
    int? pass,
    MyCardData? myCardData,
    TopicProgress? topicProgress,
    List<int>? documentIds,
  }) {
    return Topic(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      parentId: parentId ?? this.parentId,
      courseId: courseId ?? this.courseId,
      ranking: ranking ?? this.ranking,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      name: name ?? this.name,
      description: description ?? this.description,
      totalCardNum: totalCardNum ?? this.totalCardNum,
      questionNumber: questionNumber ?? this.questionNumber,
      timePractice: timePractice ?? this.timePractice,
      scoreScale: scoreScale ?? this.scoreScale,
      questionPracticeNum: questionPracticeNum ?? this.questionPracticeNum,
      totalTest: totalTest ?? this.totalTest,
      childrentIds: childrentIds ?? this.childrentIds,
      shortDescription: shortDescription ?? this.shortDescription,
      type: type ?? this.type,
      studyMode: studyMode ?? this.studyMode,
      duration: duration ?? this.duration,
      pass: pass ?? this.pass,
      myCardData: myCardData ?? this.myCardData,
      documentIds: documentIds ?? this.documentIds,
      progress: topicProgress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'parentId': parentId,
      'courseId': courseId,
      'ranking': ranking,
      'lastUpdate': lastUpdate,
      'status': status,
      'startTime': startTime,
      'endTime': endTime,
      'name': name,
      'description': description,
      'totalCardNum': totalCardNum,
      'questionNumber': questionNumber,
      'timePractice': timePractice,
      'scoreScale': scoreScale,
      'questionPracticeNum': questionPracticeNum,
      'totalTest': totalTest,
      'childrentIds': childrentIds,
      'shortDescription': shortDescription,
      'type': type,
      'studyMode': studyMode,
      'duration': duration,
      'pass': pass,
      'myCardData': myCardData?.toMap(),
      'documentIds': documentIds,
      'progress': progress,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      parentId: map['parentId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      ranking: map['ranking']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      startTime: map['startTime']?.toInt() ?? 0,
      endTime: map['endTime']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      totalCardNum: map['totalCardNum']?.toInt() ?? 0,
      questionNumber: map['questionNumber']?.toInt() ?? 0,
      timePractice: map['timePractice']?.toInt() ?? 0,
      scoreScale: map['scoreScale']?.toDouble() ?? 0.0,
      questionPracticeNum: map['questionPracticeNum']?.toInt() ?? 0,
      totalTest: map['totalTest']?.toInt() ?? 0,
      childrentIds: List<int>.from(map['childrentIds']),
      shortDescription: map['shortDescription'] ?? '',
      type: map['type']?.toInt() ?? 0,
      studyMode: map['studyMode']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      pass: map['pass']?.toInt() ?? 0,
      myCardData: map['myCardData'] != null ? MyCardData.fromMap(map['myCardData']) : null,
      documentIds: List<int>.from(map['documentIds']),
      progress: map['progress'] != null ? TopicProgress.fromMap(map['progress']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Topic(id: $id, userId: $userId, parentId: $parentId, courseId: $courseId, ranking: $ranking, lastUpdate: $lastUpdate, status: $status, startTime: $startTime, endTime: $endTime, name: $name, description: $description, totalCardNum: $totalCardNum, questionNumber: $questionNumber, timePractice: $timePractice, scoreScale: $scoreScale, questionPracticeNum: $questionPracticeNum, totalTest: $totalTest, childrentIds: $childrentIds, shortDescription: $shortDescription, type: $type, studyMode: $studyMode, duration: $duration, pass: $pass, myCardData: $myCardData, documentIds: $documentIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Topic &&
        other.id == id &&
        other.userId == userId &&
        other.parentId == parentId &&
        other.courseId == courseId &&
        other.ranking == ranking &&
        other.lastUpdate == lastUpdate &&
        other.status == status &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.name == name &&
        other.description == description &&
        other.totalCardNum == totalCardNum &&
        other.questionNumber == questionNumber &&
        other.timePractice == timePractice &&
        other.scoreScale == scoreScale &&
        other.questionPracticeNum == questionPracticeNum &&
        other.totalTest == totalTest &&
        listEquals(other.childrentIds, childrentIds) &&
        other.shortDescription == shortDescription &&
        other.type == type &&
        other.studyMode == studyMode &&
        other.duration == duration &&
        other.pass == pass &&
        other.myCardData == myCardData &&
        listEquals(other.documentIds, documentIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        parentId.hashCode ^
        courseId.hashCode ^
        ranking.hashCode ^
        lastUpdate.hashCode ^
        status.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        name.hashCode ^
        description.hashCode ^
        totalCardNum.hashCode ^
        questionNumber.hashCode ^
        timePractice.hashCode ^
        scoreScale.hashCode ^
        questionPracticeNum.hashCode ^
        totalTest.hashCode ^
        childrentIds.hashCode ^
        shortDescription.hashCode ^
        type.hashCode ^
        studyMode.hashCode ^
        duration.hashCode ^
        pass.hashCode ^
        myCardData.hashCode ^
        documentIds.hashCode;
  }
}
