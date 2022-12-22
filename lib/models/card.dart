import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ielts/models/card_progress.dart';

class Card {
  int id;
  int orderIndex;
  String userId;
  int difficultyLevel;
  int type;
  int parentId;
  int hasChild;
  int status;
  int lastUpdate;
  String code;
  int shuffleAnser;
  String frontText;
  String frontImage;
  String frontSound;
  String frontVideo;
  String frontHint;
  int frontLanguage;
  String backText;
  String backImage;
  String backSound;
  String backVideo;
  String backHint;
  int backLanguage;
  String typeOfWord;
  List<String> backTexts;
  List<int> childIds;
  int topicId;
  int childCardDiscussion;
  int number;
  String topicName;
  int oldCardId;
  bool bookmark;
  List<int> gameTypesForGame;
  bool longCard;
  bool spellingSupported;
  bool onlyTypingSpellingSupported;
  int userLevel;
  List<Card> childCards;
  CardProgress? progress;

  Card({
    required this.id,
    required this.orderIndex,
    required this.userId,
    required this.difficultyLevel,
    required this.type,
    required this.parentId,
    required this.hasChild,
    required this.status,
    required this.lastUpdate,
    required this.code,
    required this.shuffleAnser,
    required this.frontText,
    required this.frontImage,
    required this.frontSound,
    required this.frontVideo,
    required this.frontHint,
    required this.frontLanguage,
    required this.backText,
    required this.backImage,
    required this.backSound,
    required this.backVideo,
    required this.backHint,
    required this.backLanguage,
    required this.typeOfWord,
    required this.backTexts,
    required this.childIds,
    required this.topicId,
    required this.childCardDiscussion,
    required this.number,
    required this.topicName,
    required this.oldCardId,
    required this.bookmark,
    required this.gameTypesForGame,
    required this.longCard,
    required this.spellingSupported,
    required this.onlyTypingSpellingSupported,
    required this.userLevel,
    required this.progress,
    required this.childCards,
  });

  Card copyWith({
    int? id,
    int? orderIndex,
    String? userId,
    int? difficultyLevel,
    int? type,
    int? parentId,
    int? hasChild,
    int? status,
    int? lastUpdate,
    String? code,
    int? shuffleAnser,
    String? frontText,
    String? frontImage,
    String? frontSound,
    String? frontVideo,
    String? frontHint,
    int? frontLanguage,
    String? backText,
    String? backImage,
    String? backSound,
    String? backVideo,
    String? backHint,
    int? backLanguage,
    String? typeOfWord,
    List<String>? backTexts,
    List<int>? childIds,
    int? topicId,
    int? childCardDiscussion,
    int? number,
    String? topicName,
    int? oldCardId,
    bool? bookmark,
    List<int>? gameTypesForGame,
    bool? longCard,
    bool? spellingSupported,
    bool? onlyTypingSpellingSupported,
    int? userLevel,
    CardProgress? progress,
    List<Card>? childCards,
  }) {
    return Card(
      id: id ?? this.id,
      orderIndex: orderIndex ?? this.orderIndex,
      userId: userId ?? this.userId,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      type: type ?? this.type,
      parentId: parentId ?? this.parentId,
      hasChild: hasChild ?? this.hasChild,
      status: status ?? this.status,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      code: code ?? this.code,
      shuffleAnser: shuffleAnser ?? this.shuffleAnser,
      frontText: frontText ?? this.frontText,
      frontImage: frontImage ?? this.frontImage,
      frontSound: frontSound ?? this.frontSound,
      frontVideo: frontVideo ?? this.frontVideo,
      frontHint: frontHint ?? this.frontHint,
      frontLanguage: frontLanguage ?? this.frontLanguage,
      backText: backText ?? this.backText,
      backImage: backImage ?? this.backImage,
      backSound: backSound ?? this.backSound,
      backVideo: backVideo ?? this.backVideo,
      backHint: backHint ?? this.backHint,
      backLanguage: backLanguage ?? this.backLanguage,
      typeOfWord: typeOfWord ?? this.typeOfWord,
      backTexts: backTexts ?? this.backTexts,
      childIds: childIds ?? this.childIds,
      topicId: topicId ?? this.topicId,
      childCardDiscussion: childCardDiscussion ?? this.childCardDiscussion,
      number: number ?? this.number,
      topicName: topicName ?? this.topicName,
      oldCardId: oldCardId ?? this.oldCardId,
      bookmark: bookmark ?? this.bookmark,
      gameTypesForGame: gameTypesForGame ?? this.gameTypesForGame,
      longCard: longCard ?? this.longCard,
      spellingSupported: spellingSupported ?? this.spellingSupported,
      onlyTypingSpellingSupported: onlyTypingSpellingSupported ?? this.onlyTypingSpellingSupported,
      userLevel: userLevel ?? this.userLevel,
      progress: progress ?? this.progress,
      childCards: childCards ?? this.childCards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderIndex': orderIndex,
      'userId': userId,
      'difficultyLevel': difficultyLevel,
      'type': type,
      'parentId': parentId,
      'hasChild': hasChild,
      'status': status,
      'lastUpdate': lastUpdate,
      'code': code,
      'shuffleAnser': shuffleAnser,
      'frontText': frontText,
      'frontImage': frontImage,
      'frontSound': frontSound,
      'frontVideo': frontVideo,
      'frontHint': frontHint,
      'frontLanguage': frontLanguage,
      'backText': backText,
      'backImage': backImage,
      'backSound': backSound,
      'backVideo': backVideo,
      'backHint': backHint,
      'backLanguage': backLanguage,
      'typeOfWord': typeOfWord,
      'backTexts': backTexts,
      'childIds': childIds,
      'topicId': topicId,
      'childCardDiscussion': childCardDiscussion,
      'number': number,
      'topicName': topicName,
      'oldCardId': oldCardId,
      'bookmark': bookmark,
      'gameTypesForGame': gameTypesForGame,
      'longCard': longCard,
      'spellingSupported': spellingSupported,
      'onlyTypingSpellingSupported': onlyTypingSpellingSupported,
      'userLevel': userLevel,
      'progress': progress?.toJson(),
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      id: map['id']?.toInt() ?? 0,
      orderIndex: map['orderIndex']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      difficultyLevel: map['difficultyLevel']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      parentId: map['parentId']?.toInt() ?? 0,
      hasChild: map['hasChild']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      code: map['code'] ?? '',
      shuffleAnser: map['shuffleAnser']?.toInt() ?? 0,
      frontText: map['frontText'] ?? '',
      frontImage: map['frontImage'] ?? '',
      frontSound: map['frontSound'] ?? '',
      frontVideo: map['frontVideo'] ?? '',
      frontHint: map['frontHint'] ?? '',
      frontLanguage: map['frontLanguage']?.toInt() ?? 0,
      backText: map['backText'] ?? '',
      backImage: map['backImage'] ?? '',
      backSound: map['backSound'] ?? '',
      backVideo: map['backVideo'] ?? '',
      backHint: map['backHint'] ?? '',
      backLanguage: map['backLanguage']?.toInt() ?? 0,
      typeOfWord: map['typeOfWord'] ?? '',
      backTexts: List<String>.from(map['backTexts']),
      childIds: List<int>.from(map['childIds']),
      topicId: map['topicId']?.toInt() ?? 0,
      childCardDiscussion: map['childCardDiscussion']?.toInt() ?? 0,
      number: map['number']?.toInt() ?? 0,
      topicName: map['topicName'] ?? '',
      oldCardId: map['oldCardId']?.toInt() ?? 0,
      bookmark: map['bookmark'] ?? false,
      gameTypesForGame: List<int>.from(map['gameTypesForGame']),
      longCard: map['longCard'] ?? false,
      spellingSupported: map['spellingSupported'] ?? false,
      onlyTypingSpellingSupported: map['onlyTypingSpellingSupported'] ?? false,
      userLevel: map['userLevel']?.toInt() ?? 0,
      progress: map['progress'] != null ? CardProgress.fromMap(map['progress']) : null,
      childCards: (map['childCards'] as List<dynamic>?)?.map((e) => Card.fromMap(e)).toList() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Card(id: $id, orderIndex: $orderIndex, userId: $userId, difficultyLevel: $difficultyLevel, type: $type, parentId: $parentId, hasChild: $hasChild, status: $status, lastUpdate: $lastUpdate, code: $code, shuffleAnser: $shuffleAnser, frontText: $frontText, frontImage: $frontImage, frontSound: $frontSound, frontVideo: $frontVideo, frontHint: $frontHint, frontLanguage: $frontLanguage, backText: $backText, backImage: $backImage, backSound: $backSound, backVideo: $backVideo, backHint: $backHint, backLanguage: $backLanguage, typeOfWord: $typeOfWord, backTexts: $backTexts, childIds: $childIds, topicId: $topicId, childCardDiscussion: $childCardDiscussion, number: $number, topicName: $topicName, oldCardId: $oldCardId, bookmark: $bookmark, gameTypesForGame: $gameTypesForGame, longCard: $longCard, spellingSupported: $spellingSupported, onlyTypingSpellingSupported: $onlyTypingSpellingSupported, userLevel: $userLevel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card &&
        other.id == id &&
        other.orderIndex == orderIndex &&
        other.userId == userId &&
        other.difficultyLevel == difficultyLevel &&
        other.type == type &&
        other.parentId == parentId &&
        other.hasChild == hasChild &&
        other.status == status &&
        other.lastUpdate == lastUpdate &&
        other.code == code &&
        other.shuffleAnser == shuffleAnser &&
        other.frontText == frontText &&
        other.frontImage == frontImage &&
        other.frontSound == frontSound &&
        other.frontVideo == frontVideo &&
        other.frontHint == frontHint &&
        other.frontLanguage == frontLanguage &&
        other.backText == backText &&
        other.backImage == backImage &&
        other.backSound == backSound &&
        other.backVideo == backVideo &&
        other.backHint == backHint &&
        other.backLanguage == backLanguage &&
        other.typeOfWord == typeOfWord &&
        listEquals(other.backTexts, backTexts) &&
        listEquals(other.childIds, childIds) &&
        other.topicId == topicId &&
        other.childCardDiscussion == childCardDiscussion &&
        other.number == number &&
        other.topicName == topicName &&
        other.oldCardId == oldCardId &&
        other.bookmark == bookmark &&
        listEquals(other.gameTypesForGame, gameTypesForGame) &&
        other.longCard == longCard &&
        other.spellingSupported == spellingSupported &&
        other.onlyTypingSpellingSupported == onlyTypingSpellingSupported &&
        other.userLevel == userLevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderIndex.hashCode ^
        userId.hashCode ^
        difficultyLevel.hashCode ^
        type.hashCode ^
        parentId.hashCode ^
        hasChild.hashCode ^
        status.hashCode ^
        lastUpdate.hashCode ^
        code.hashCode ^
        shuffleAnser.hashCode ^
        frontText.hashCode ^
        frontImage.hashCode ^
        frontSound.hashCode ^
        frontVideo.hashCode ^
        frontHint.hashCode ^
        frontLanguage.hashCode ^
        backText.hashCode ^
        backImage.hashCode ^
        backSound.hashCode ^
        backVideo.hashCode ^
        backHint.hashCode ^
        backLanguage.hashCode ^
        typeOfWord.hashCode ^
        backTexts.hashCode ^
        childIds.hashCode ^
        topicId.hashCode ^
        childCardDiscussion.hashCode ^
        number.hashCode ^
        topicName.hashCode ^
        oldCardId.hashCode ^
        bookmark.hashCode ^
        gameTypesForGame.hashCode ^
        longCard.hashCode ^
        spellingSupported.hashCode ^
        onlyTypingSpellingSupported.hashCode ^
        userLevel.hashCode;
  }
}
