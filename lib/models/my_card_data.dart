import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

const String tableMyCardData = 'myCardData';
const String _columnId = 'id';
const String _columnUserId = 'userId';
const String _columnTopicId = 'topicId';
const String _columnCourseId = 'courseId';
const String _columnCardBox1 = 'cardBox1';
const String _columnCardBox2 = 'cardBox2';
const String _columnCardBox3 = 'cardBox3';
const String _columnCardBox4 = 'cardBox4';
const String _columnCardBoxn = 'cardBoxn';
const String _columnCardIgnores = 'cardIgnores';
const String _columnCardBookmarks = 'cardBookmarks';
const String _columnIsSync = 'isSync';
const String createMyCardDataTable = '''
        create table IF NOT EXISTS $tableMyCardData (
          $_columnId text primary key ,
          $_columnUserId text,
          $_columnTopicId integer,
          $_columnCourseId integer,
          $_columnCardBox1 text,
          $_columnCardBox2 text,
          $_columnCardBox3 text,
          $_columnCardBox4 text,
          $_columnCardBoxn text,
          $_columnCardIgnores text,
          $_columnCardBookmarks text,
          $_columnIsSync integer
          )
        ''';

class MyCardData {
  String id;
  String userId;

  int topicId;

  int courseId;

  List<int> cardBox1 = []; //Box of cards that are answered incorrectly

  List<int> cardBox2 = []; //Box of cards that are answered correctly once

  List<int> cardBox3 = []; //Box of cards that are answered correctly twice

  List<int> cardBox4 = []; //Box of cards that are answered correctly triple

  List<int> cardBoxn = []; //Box of cards that are answered correctly four times

  List<int> cardIgnores = []; //Box of cards that user ignore

  List<int> cardBookmarks = [];
  MyCardData({
    required this.id,
    required this.userId,
    required this.topicId,
    required this.courseId,
    required this.cardBox1,
    required this.cardBox2,
    required this.cardBox3,
    required this.cardBox4,
    required this.cardBoxn,
    required this.cardIgnores,
    required this.cardBookmarks,
  });

  List<int> getChuaHoc(List<int> allId) {
    List<int> data = [];
    for (int i in allId) {
      if (!cardBox1.contains(i) &&
          !cardBox2.contains(i) &&
          !cardBox3.contains(i) &&
          !cardBox4.contains(i) &&
          !cardBoxn.contains(i)) {
        data.add(i);
      }
    }
    return data;
  }

  List<int> getDaThuoc() {
    List<int> data = [];
    data.addAll(cardBox3);
    data.addAll(cardBox4);
    data.addAll(cardBoxn);
    return data;
  }

  List<int> getChuaThuoc() {
    List<int> data = [];
    data.addAll(cardBox1);
    data.addAll(cardBox2);
    return data;
  }

  List<int> getDanhDau() {
    List<int> data = [];
    data.addAll(cardBookmarks);
    return data;
  }

  void updateBookmark(int id) async {
    if (!cardBookmarks.contains(id))
      cardBookmarks.add(id);
    else
      cardBookmarks.remove(id);
  }

  void updateBoxNum(int id, int boxNumCard) async {
    if (boxNumCard > 4) {
      if (!cardBoxn.contains(id)) cardBoxn.add(id); // chua co thi them
      cardBoxn.removeWhere((element) => element == 0);
      cardBox2.remove(id);
      cardBox3.remove(id);
      cardBox4.remove(id);
      cardBox1.remove(id);
    }
    switch (boxNumCard) {
      case 1:
        {
          if (!cardBox1.contains(id)) cardBox1.add(id);
          cardBox1.removeWhere((element) => element == 0);
          //
          cardBox2.remove(id);
          cardBox3.remove(id);
          cardBox4.remove(id);
          cardBoxn.remove(id);
          break;
        }
      case 2:
        {
          if (!cardBox2.contains(id)) cardBox2.add(id);
          cardBox2.removeWhere((element) => element == 0);
          //
          cardBox1.remove(id);
          cardBox3.remove(id);
          cardBox4.remove(id);
          cardBoxn.remove(id);
          break;
        }
      case 3:
        {
          if (!cardBox3.contains(id)) cardBox3.add(id);
          cardBox3.removeWhere((element) => element == 0);
          //
          cardBox2.remove(id);
          cardBox1.remove(id);
          cardBox4.remove(id);
          cardBoxn.remove(id);
          break;
        }
      case 4:
        {
          if (!cardBox4.contains(id)) cardBox4.add(id);
          cardBox4.removeWhere((element) => element == 0);
          //
          cardBox2.remove(id);
          cardBox3.remove(id);
          cardBox1.remove(id);
          cardBoxn.remove(id);
          break;
        }
    }
  }

  MyCardData copyWith({
    String? id,
    String? userId,
    int? topicId,
    int? courseId,
    List<int>? cardBox1,
    List<int>? cardBox2,
    List<int>? cardBox3,
    List<int>? cardBox4,
    List<int>? cardBoxn,
    List<int>? cardIgnores,
    List<int>? cardBookmarks,
  }) {
    return MyCardData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      topicId: topicId ?? this.topicId,
      courseId: courseId ?? this.courseId,
      cardBox1: cardBox1 ?? this.cardBox1,
      cardBox2: cardBox2 ?? this.cardBox2,
      cardBox3: cardBox3 ?? this.cardBox3,
      cardBox4: cardBox4 ?? this.cardBox4,
      cardBoxn: cardBoxn ?? this.cardBoxn,
      cardIgnores: cardIgnores ?? this.cardIgnores,
      cardBookmarks: cardBookmarks ?? this.cardBookmarks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'topicId': topicId,
      'courseId': courseId,
      'cardBox1': cardBox1,
      'cardBox2': cardBox2,
      'cardBox3': cardBox3,
      'cardBox4': cardBox4,
      'cardBoxn': cardBoxn,
      'cardIgnores': cardIgnores,
      'cardBookmarks': cardBookmarks,
    };
  }

  factory MyCardData.fromMap(Map<String, dynamic> map) {
    return MyCardData(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      topicId: map['topicId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      cardBox1: List<int>.from(map['cardBox1']),
      cardBox2: List<int>.from(map['cardBox2']),
      cardBox3: List<int>.from(map['cardBox3']),
      cardBox4: List<int>.from(map['cardBox4']),
      cardBoxn: List<int>.from(map['cardBoxn']),
      cardIgnores: List<int>.from(map['cardIgnores']),
      cardBookmarks: List<int>.from(map['cardBookmarks']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCardData.fromJson(String source) => MyCardData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyCardData(id: $id, userId: $userId, topicId: $topicId, courseId: $courseId, cardBox1: $cardBox1, cardBox2: $cardBox2, cardBox3: $cardBox3, cardBox4: $cardBox4, cardBoxn: $cardBoxn, cardIgnores: $cardIgnores, cardBookmarks: $cardBookmarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyCardData &&
        other.id == id &&
        other.userId == userId &&
        other.topicId == topicId &&
        other.courseId == courseId &&
        listEquals(other.cardBox1, cardBox1) &&
        listEquals(other.cardBox2, cardBox2) &&
        listEquals(other.cardBox3, cardBox3) &&
        listEquals(other.cardBox4, cardBox4) &&
        listEquals(other.cardBoxn, cardBoxn) &&
        listEquals(other.cardIgnores, cardIgnores) &&
        listEquals(other.cardBookmarks, cardBookmarks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        topicId.hashCode ^
        courseId.hashCode ^
        cardBox1.hashCode ^
        cardBox2.hashCode ^
        cardBox3.hashCode ^
        cardBox4.hashCode ^
        cardBoxn.hashCode ^
        cardIgnores.hashCode ^
        cardBookmarks.hashCode;
  }
}
