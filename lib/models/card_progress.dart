import 'dart:convert';

import 'package:flutter/foundation.dart';

class CardProgress {
  String id;
  String userId;
  int cardId;
  int courseId;
  int topicId;
  int lastUpdate;
  int status;
  int cardType;
  int skill;
  int lastResult;
  int boxNum;
  int difficultyLevel;
  List<int> gamesPlayed;
  List<int> history;
  int progress;
  int reviewDate;
  CardProgress({
    required this.id,
    required this.userId,
    required this.cardId,
    required this.courseId,
    required this.topicId,
    required this.lastUpdate,
    required this.status,
    required this.cardType,
    required this.skill,
    required this.lastResult,
    required this.boxNum,
    required this.difficultyLevel,
    required this.gamesPlayed,
    required this.history,
    required this.progress,
    required this.reviewDate,
  });

  CardProgress copyWith({
    String? id,
    String? userId,
    int? cardId,
    int? courseId,
    int? topicId,
    int? lastUpdate,
    int? status,
    int? cardType,
    int? skill,
    int? lastResult,
    int? boxNum,
    int? difficultyLevel,
    List<int>? gamesPlayed,
    List<int>? history,
    int? progress,
    int? reviewDate,
  }) {
    return CardProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cardId: cardId ?? this.cardId,
      courseId: courseId ?? this.courseId,
      topicId: topicId ?? this.topicId,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      status: status ?? this.status,
      cardType: cardType ?? this.cardType,
      skill: skill ?? this.skill,
      lastResult: lastResult ?? this.lastResult,
      boxNum: boxNum ?? this.boxNum,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      history: history ?? this.history,
      progress: progress ?? this.progress,
      reviewDate: reviewDate ?? this.reviewDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'cardId': cardId,
      'courseId': courseId,
      'topicId': topicId,
      'lastUpdate': lastUpdate,
      'status': status,
      'cardType': cardType,
      'skill': skill,
      'lastResult': lastResult,
      'boxNum': boxNum,
      'difficultyLevel': difficultyLevel,
      'gamesPlayed': gamesPlayed,
      'history': history,
      'progress': progress,
      'reviewDate': reviewDate,
    };
  }

  factory CardProgress.fromMap(Map<String, dynamic> map) {
    return CardProgress(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      cardId: map['cardId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      topicId: map['topicId']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      cardType: map['cardType']?.toInt() ?? 0,
      skill: map['skill']?.toInt() ?? 0,
      lastResult: map['lastResult']?.toInt() ?? 0,
      boxNum: map['boxNum']?.toInt() ?? 0,
      difficultyLevel: map['difficultyLevel']?.toInt() ?? 0,
      gamesPlayed: List<int>.from(map['gamesPlayed']),
      history: List<int>.from(map['history']),
      progress: map['progress']?.toInt() ?? 0,
      reviewDate: map['reviewDate']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardProgress.fromJson(String source) => CardProgress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardProgress(id: $id, userId: $userId, cardId: $cardId, courseId: $courseId, topicId: $topicId, lastUpdate: $lastUpdate, status: $status, cardType: $cardType, skill: $skill, lastResult: $lastResult, boxNum: $boxNum, difficultyLevel: $difficultyLevel, gamesPlayed: $gamesPlayed, history: $history, progress: $progress, reviewDate: $reviewDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardProgress &&
        other.id == id &&
        other.userId == userId &&
        other.cardId == cardId &&
        other.courseId == courseId &&
        other.topicId == topicId &&
        other.lastUpdate == lastUpdate &&
        other.status == status &&
        other.cardType == cardType &&
        other.skill == skill &&
        other.lastResult == lastResult &&
        other.boxNum == boxNum &&
        other.difficultyLevel == difficultyLevel &&
        listEquals(other.gamesPlayed, gamesPlayed) &&
        listEquals(other.history, history) &&
        other.progress == progress &&
        other.reviewDate == reviewDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        cardId.hashCode ^
        courseId.hashCode ^
        topicId.hashCode ^
        lastUpdate.hashCode ^
        status.hashCode ^
        cardType.hashCode ^
        skill.hashCode ^
        lastResult.hashCode ^
        boxNum.hashCode ^
        difficultyLevel.hashCode ^
        gamesPlayed.hashCode ^
        history.hashCode ^
        progress.hashCode ^
        reviewDate.hashCode;
  }
}
