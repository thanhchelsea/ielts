import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String id;
  String account;
  String fullName;
  String name;
  String avatarUrl;
  String facebookId;
  String sessionId;
  List<int> joinCourseIds;
  int status;
  User({
    required this.id,
    required this.account,
    required this.fullName,
    required this.name,
    required this.avatarUrl,
    required this.facebookId,
    required this.sessionId,
    required this.joinCourseIds,
    required this.status,
  });

  User copyWith({
    String? id,
    String? account,
    String? fullName,
    String? name,
    String? avatarUrl,
    String? facebookId,
    String? sessionId,
    List<int>? joinCourseIds,
    int? status,
  }) {
    return User(
      id: id ?? this.id,
      account: account ?? this.account,
      fullName: fullName ?? this.fullName,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      facebookId: facebookId ?? this.facebookId,
      sessionId: sessionId ?? this.sessionId,
      joinCourseIds: joinCourseIds ?? this.joinCourseIds,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account': account,
      'fullName': fullName,
      'name': name,
      'avatarUrl': avatarUrl,
      'facebookId': facebookId,
      'sessionId': sessionId,
      'joinCourseIds': joinCourseIds,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      account: map['account'] ?? '',
      fullName: map['fullName'] ?? '',
      name: map['name'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      facebookId: map['facebookId'] ?? '',
      sessionId: map['sessionId'] ?? '',
      joinCourseIds: List<int>.from(map['joinCourseIds']),
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, account: $account, fullName: $fullName, name: $name, avatarUrl: $avatarUrl, facebookId: $facebookId, sessionId: $sessionId, joinCourseIds: $joinCourseIds, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.account == account &&
        other.fullName == fullName &&
        other.name == name &&
        other.avatarUrl == avatarUrl &&
        other.facebookId == facebookId &&
        other.sessionId == sessionId &&
        listEquals(other.joinCourseIds, joinCourseIds) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        account.hashCode ^
        fullName.hashCode ^
        name.hashCode ^
        avatarUrl.hashCode ^
        facebookId.hashCode ^
        sessionId.hashCode ^
        joinCourseIds.hashCode ^
        status.hashCode;
  }
}
