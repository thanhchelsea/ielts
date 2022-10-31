import 'dart:convert';

import 'package:flutter/foundation.dart';

class Document {
  int id;
  String userId;
  int parentId;
  int courseId;
  int createDate;
  int download;
  int status;
  int type;
  String url;
  int category;
  List<String> listUrls;
  String title;
  String descreption;
  String content;
  int size;
  String avatar;
  int price;
  Document({
    required this.id,
    required this.userId,
    required this.parentId,
    required this.courseId,
    required this.createDate,
    required this.download,
    required this.status,
    required this.type,
    required this.url,
    required this.category,
    required this.listUrls,
    required this.title,
    required this.descreption,
    required this.content,
    required this.size,
    required this.avatar,
    required this.price,
  });

  Document copyWith({
    int? id,
    String? userId,
    int? parentId,
    int? courseId,
    int? createDate,
    int? download,
    int? status,
    int? type,
    String? url,
    int? category,
    List<String>? listUrls,
    String? title,
    String? descreption,
    String? content,
    int? size,
    String? avatar,
    int? price,
  }) {
    return Document(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      parentId: parentId ?? this.parentId,
      courseId: courseId ?? this.courseId,
      createDate: createDate ?? this.createDate,
      download: download ?? this.download,
      status: status ?? this.status,
      type: type ?? this.type,
      url: url ?? this.url,
      category: category ?? this.category,
      listUrls: listUrls ?? this.listUrls,
      title: title ?? this.title,
      descreption: descreption ?? this.descreption,
      content: content ?? this.content,
      size: size ?? this.size,
      avatar: avatar ?? this.avatar,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'parentId': parentId,
      'courseId': courseId,
      'createDate': createDate,
      'download': download,
      'status': status,
      'type': type,
      'url': url,
      'category': category,
      'listUrls': listUrls,
      'title': title,
      'descreption': descreption,
      'content': content,
      'size': size,
      'avatar': avatar,
      'price': price,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      parentId: map['parentId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      createDate: map['createDate']?.toInt() ?? 0,
      download: map['download']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      url: map['url'] ?? '',
      category: map['category']?.toInt() ?? 0,
      listUrls: List<String>.from(map['listUrls']),
      title: map['title'] ?? '',
      descreption: map['descreption'] ?? '',
      content: map['content'] ?? '',
      size: map['size']?.toInt() ?? 0,
      avatar: map['avatar'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Document(id: $id, userId: $userId, parentId: $parentId, courseId: $courseId, createDate: $createDate, download: $download, status: $status, type: $type, url: $url, category: $category, listUrls: $listUrls, title: $title, descreption: $descreption, content: $content, size: $size, avatar: $avatar, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Document &&
        other.id == id &&
        other.userId == userId &&
        other.parentId == parentId &&
        other.courseId == courseId &&
        other.createDate == createDate &&
        other.download == download &&
        other.status == status &&
        other.type == type &&
        other.url == url &&
        other.category == category &&
        listEquals(other.listUrls, listUrls) &&
        other.title == title &&
        other.descreption == descreption &&
        other.content == content &&
        other.size == size &&
        other.avatar == avatar &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        parentId.hashCode ^
        courseId.hashCode ^
        createDate.hashCode ^
        download.hashCode ^
        status.hashCode ^
        type.hashCode ^
        url.hashCode ^
        category.hashCode ^
        listUrls.hashCode ^
        title.hashCode ^
        descreption.hashCode ^
        content.hashCode ^
        size.hashCode ^
        avatar.hashCode ^
        price.hashCode;
  }
}
