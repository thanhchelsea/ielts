import 'dart:convert';

import 'package:flutter/foundation.dart';

class Discussion {
  int id;
  int parentId;
  int parentCardId;
  String userId;
  int createDate;
  int courseId;
  int topicId;
  int type;
  int lastUpdate;
  String userName;
  String content;
  String imageURL;
  String sourceUrl;
  int status;
  List<String> like;
  List<int> childDiscussionIds;
  int commentStatus;
  String userReplyComment;
  int commentType;
  int timeReplyComment;
  String fullName;
  Discussion({
    required this.id,
    required this.parentId,
    required this.parentCardId,
    required this.userId,
    required this.createDate,
    required this.courseId,
    required this.topicId,
    required this.type,
    required this.lastUpdate,
    required this.userName,
    required this.content,
    required this.imageURL,
    required this.sourceUrl,
    required this.status,
    required this.like,
    required this.childDiscussionIds,
    required this.commentStatus,
    required this.userReplyComment,
    required this.commentType,
    required this.timeReplyComment,
    required this.fullName,
  });

  Discussion copyWith({
    int? id,
    int? parentId,
    int? parentCardId,
    String? userId,
    int? createDate,
    int? courseId,
    int? topicId,
    int? type,
    int? lastUpdate,
    String? userName,
    String? content,
    String? imageURL,
    String? sourceUrl,
    int? status,
    List<String>? like,
    List<int>? childDiscussionIds,
    int? commentStatus,
    String? userReplyComment,
    int? commentType,
    int? timeReplyComment,
    String? fullName,
  }) {
    return Discussion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      parentCardId: parentCardId ?? this.parentCardId,
      userId: userId ?? this.userId,
      createDate: createDate ?? this.createDate,
      courseId: courseId ?? this.courseId,
      topicId: topicId ?? this.topicId,
      type: type ?? this.type,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      imageURL: imageURL ?? this.imageURL,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      status: status ?? this.status,
      like: like ?? this.like,
      childDiscussionIds: childDiscussionIds ?? this.childDiscussionIds,
      commentStatus: commentStatus ?? this.commentStatus,
      userReplyComment: userReplyComment ?? this.userReplyComment,
      commentType: commentType ?? this.commentType,
      timeReplyComment: timeReplyComment ?? this.timeReplyComment,
      fullName: fullName ?? this.fullName,
    );
  }

  static Discussion initDicussion({
    required int pId,
    required int cId,
    required int tId,
    required String uId,
    required String uName,
    required String ct,
  }) {
    return Discussion(
      id: -1,
      parentId: pId,
      parentCardId: -1,
      userId: uId,
      createDate: -1,
      courseId: cId,
      topicId: tId,
      type: -1,
      lastUpdate: -1,
      userName: uName,
      content: ct,
      imageURL: "",
      sourceUrl: "",
      status: 0,
      like: [],
      childDiscussionIds: [],
      commentStatus: 0,
      userReplyComment: "",
      commentType: 0,
      timeReplyComment: -1,
      fullName: "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'parentId': parentId,
      'parentCardId': parentCardId,
      'userId': userId,
      'createDate': createDate,
      'courseId': courseId,
      'topicId': topicId,
      'type': type,
      'lastUpdate': lastUpdate,
      'userName': userName,
      'content': content,
      'imageURL': imageURL,
      'sourceUrl': sourceUrl,
      'status': status,
      'like': like,
      'childDiscussionIds': childDiscussionIds,
      'commentStatus': commentStatus,
      'userReplyComment': userReplyComment,
      'commentType': commentType,
      'timeReplyComment': timeReplyComment,
      'fullName': fullName,
    };
  }

  factory Discussion.fromMap(Map<String, dynamic> map) {
    return Discussion(
      id: map['id']?.toInt() ?? 0,
      parentId: map['parentId']?.toInt() ?? 0,
      parentCardId: map['parentCardId']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      createDate: map['createDate']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      topicId: map['topicId']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      userName: map['userName'] ?? '',
      content: map['content'] ?? '',
      imageURL: map['imageURL'] ?? '',
      sourceUrl: map['sourceUrl'] ?? '',
      status: map['status']?.toInt() ?? 0,
      like: List<String>.from(map['like']),
      childDiscussionIds: List<int>.from(map['childDiscussionIds']),
      commentStatus: map['commentStatus']?.toInt() ?? 0,
      userReplyComment: map['userReplyComment'] ?? '',
      commentType: map['commentType']?.toInt() ?? 0,
      timeReplyComment: map['timeReplyComment']?.toInt() ?? 0,
      fullName: map['fullName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Discussion.fromJson(String source) => Discussion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Discussion(id: $id, parentId: $parentId, parentCardId: $parentCardId, userId: $userId, createDate: $createDate, courseId: $courseId, topicId: $topicId, type: $type, lastUpdate: $lastUpdate, userName: $userName, content: $content, imageURL: $imageURL, sourceUrl: $sourceUrl, status: $status, like: $like, childDiscussionIds: $childDiscussionIds, commentStatus: $commentStatus, userReplyComment: $userReplyComment, commentType: $commentType, timeReplyComment: $timeReplyComment, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discussion &&
        other.id == id &&
        other.parentId == parentId &&
        other.parentCardId == parentCardId &&
        other.userId == userId &&
        other.createDate == createDate &&
        other.courseId == courseId &&
        other.topicId == topicId &&
        other.type == type &&
        other.lastUpdate == lastUpdate &&
        other.userName == userName &&
        other.content == content &&
        other.imageURL == imageURL &&
        other.sourceUrl == sourceUrl &&
        other.status == status &&
        listEquals(other.like, like) &&
        listEquals(other.childDiscussionIds, childDiscussionIds) &&
        other.commentStatus == commentStatus &&
        other.userReplyComment == userReplyComment &&
        other.commentType == commentType &&
        other.timeReplyComment == timeReplyComment &&
        other.fullName == fullName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        parentCardId.hashCode ^
        userId.hashCode ^
        createDate.hashCode ^
        courseId.hashCode ^
        topicId.hashCode ^
        type.hashCode ^
        lastUpdate.hashCode ^
        userName.hashCode ^
        content.hashCode ^
        imageURL.hashCode ^
        sourceUrl.hashCode ^
        status.hashCode ^
        like.hashCode ^
        childDiscussionIds.hashCode ^
        commentStatus.hashCode ^
        userReplyComment.hashCode ^
        commentType.hashCode ^
        timeReplyComment.hashCode ^
        fullName.hashCode;
  }
}
