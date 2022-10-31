import 'dart:convert';

const String tableTopicProgress = 'topicProgress';
const String _columnId = 'id';
const String _columnParentId = "parentId";
const String _columnTopicId = 'topicId';
const String _columnUserId = 'userId';
const String _columnCourseId = 'courseId';
const String _columnLanguageId = 'languageId';
const String _columnLastUpdate = 'lastUpdate';
const String _columnProgress = 'progress';
const String _columnStatus = "status";
const String _columnStudyStatus = "studyStatus";
const String _columnTestScore = "testScore";
const String _columnViewNum = "viewNum";
const String _columnPassed = "passed";
const String _columnUserName = "userName";
const String _columnCategoryName = "categoryName";
const String _columnLastChildCardNum = "lastChildCardNum";
const String _columnTopicDatabase = "topicDatabase";
const String _columnIsSync = 'isSync';

const String createTopicProgressTable = '''
        create table IF NOT EXISTS $tableTopicProgress (
          $_columnId text primary key ,
          $_columnParentId integer,
          $_columnTopicId integer,
          $_columnUserId text,
          $_columnCourseId integer,
          $_columnLanguageId integer,
          $_columnLastUpdate integer,
          $_columnProgress integer,
          $_columnStatus integer,
          $_columnStudyStatus integer,
          $_columnTestScore integer,
          $_columnViewNum integer,
          $_columnPassed integer,
          $_columnUserName text,
          $_columnCategoryName text,
          $_columnLastChildCardNum integer,
          $_columnTopicDatabase integer,
          $_columnIsSync integer
           )
        ''';

class TopicProgress {
  String id;
  int parentId;
  int topicId;
  String userId;
  int courseId;
  int languageId;
  int lastUpdate;
  int progress;
  int status;
  int studyStatus;
  double testScore;
  int viewNum;
  int passed;
  String userName;
  String categoryName;
  int lastChildCardNum;
  int topicDatabase;
  TopicProgress({
    required this.id,
    required this.parentId,
    required this.topicId,
    required this.userId,
    required this.courseId,
    required this.languageId,
    required this.lastUpdate,
    required this.progress,
    required this.status,
    required this.studyStatus,
    required this.testScore,
    required this.viewNum,
    required this.passed,
    required this.userName,
    required this.categoryName,
    required this.lastChildCardNum,
    required this.topicDatabase,
  });

  TopicProgress copyWith({
    String? id,
    int? parentId,
    int? topicId,
    String? userId,
    int? courseId,
    int? languageId,
    int? lastUpdate,
    int? progress,
    int? status,
    int? studyStatus,
    double? testScore,
    int? viewNum,
    int? passed,
    String? userName,
    String? categoryName,
    int? lastChildCardNum,
    int? topicDatabase,
  }) {
    return TopicProgress(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      topicId: topicId ?? this.topicId,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      languageId: languageId ?? this.languageId,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      studyStatus: studyStatus ?? this.studyStatus,
      testScore: testScore ?? this.testScore,
      viewNum: viewNum ?? this.viewNum,
      passed: passed ?? this.passed,
      userName: userName ?? this.userName,
      categoryName: categoryName ?? this.categoryName,
      lastChildCardNum: lastChildCardNum ?? this.lastChildCardNum,
      topicDatabase: topicDatabase ?? this.topicDatabase,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'topicId': topicId,
      'userId': userId,
      'courseId': courseId,
      'languageId': languageId,
      'lastUpdate': lastUpdate,
      'progress': progress,
      'status': status,
      'studyStatus': studyStatus,
      'testScore': testScore,
      'viewNum': viewNum,
      'passed': passed,
      'userName': userName,
      'categoryName': categoryName,
      'lastChildCardNum': lastChildCardNum,
      'topicDatabase': topicDatabase,
    };
  }

  factory TopicProgress.fromMap(Map<String, dynamic> map) {
    return TopicProgress(
      id: map['id'] ?? '',
      parentId: map['parentId']?.toInt() ?? 0,
      topicId: map['topicId']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      courseId: map['courseId']?.toInt() ?? 0,
      languageId: map['languageId']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      progress: map['progress']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      studyStatus: map['studyStatus']?.toInt() ?? 0,
      testScore: map['testScore']?.toDouble() ?? 0.0,
      viewNum: map['viewNum']?.toInt() ?? 0,
      passed: map['passed']?.toInt() ?? 0,
      userName: map['userName'] ?? '',
      categoryName: map['categoryName'] ?? '',
      lastChildCardNum: map['lastChildCardNum']?.toInt() ?? 0,
      topicDatabase: map['topicDatabase']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicProgress.fromJson(String source) => TopicProgress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopicProgress(id: $id, parentId: $parentId, topicId: $topicId, userId: $userId, courseId: $courseId, languageId: $languageId, lastUpdate: $lastUpdate, progress: $progress, status: $status, studyStatus: $studyStatus, testScore: $testScore, viewNum: $viewNum, passed: $passed, userName: $userName, categoryName: $categoryName, lastChildCardNum: $lastChildCardNum, topicDatabase: $topicDatabase)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TopicProgress &&
        other.id == id &&
        other.parentId == parentId &&
        other.topicId == topicId &&
        other.userId == userId &&
        other.courseId == courseId &&
        other.languageId == languageId &&
        other.lastUpdate == lastUpdate &&
        other.progress == progress &&
        other.status == status &&
        other.studyStatus == studyStatus &&
        other.testScore == testScore &&
        other.viewNum == viewNum &&
        other.passed == passed &&
        other.userName == userName &&
        other.categoryName == categoryName &&
        other.lastChildCardNum == lastChildCardNum &&
        other.topicDatabase == topicDatabase;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        topicId.hashCode ^
        userId.hashCode ^
        courseId.hashCode ^
        languageId.hashCode ^
        lastUpdate.hashCode ^
        progress.hashCode ^
        status.hashCode ^
        studyStatus.hashCode ^
        testScore.hashCode ^
        viewNum.hashCode ^
        passed.hashCode ^
        userName.hashCode ^
        categoryName.hashCode ^
        lastChildCardNum.hashCode ^
        topicDatabase.hashCode;
  }
}
