import 'dart:convert';

class VideoScenario {
  int id;
  int autoPlay;
  String videoId; //url;
  int topicId;
  int courseId;
  int status;
  int type;
  int startTime;
  int endTime;
  int lastUpdate;
  String videoUrl;
  String timeQuestionData;
  String timeExerciseData;
  int setingVideoLive;
  int statusVideo;
  int minusFree;
  String title;
  String description;
  String thumbnail;
  bool liveStream;
  int duration;
  VideoScenario({
    required this.id,
    required this.autoPlay,
    required this.videoId,
    required this.topicId,
    required this.courseId,
    required this.status,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.lastUpdate,
    required this.videoUrl,
    required this.timeQuestionData,
    required this.timeExerciseData,
    required this.setingVideoLive,
    required this.statusVideo,
    required this.minusFree,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.liveStream,
    required this.duration,
  });

  String? getUrlSubTitle() {
    String? url;
    List<dynamic> data = jsonDecode(timeQuestionData);
    Map<String, dynamic> map = Map<String, dynamic>.from(data[0] as Map<String, dynamic>); // jsonDecode(data[0]);
    Map<String, dynamic> mapDatas =
        Map<String, dynamic>.from(jsonDecode(map['datas']) as Map<String, dynamic>); // jsonDecode(data[0]);
    url = mapDatas.values.first;
    print("subtile video: $url");

    return url;
  }

  VideoScenario copyWith({
    int? id,
    int? autoPlay,
    String? videoId,
    int? topicId,
    int? courseId,
    int? status,
    int? type,
    int? startTime,
    int? endTime,
    int? lastUpdate,
    String? videoUrl,
    String? timeQuestionData,
    String? timeExerciseData,
    int? setingVideoLive,
    int? statusVideo,
    int? minusFree,
    String? title,
    String? description,
    String? thumbnail,
    bool? liveStream,
    int? duration,
  }) {
    return VideoScenario(
      id: id ?? this.id,
      autoPlay: autoPlay ?? this.autoPlay,
      videoId: videoId ?? this.videoId,
      topicId: topicId ?? this.topicId,
      courseId: courseId ?? this.courseId,
      status: status ?? this.status,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      videoUrl: videoUrl ?? this.videoUrl,
      timeQuestionData: timeQuestionData ?? this.timeQuestionData,
      timeExerciseData: timeExerciseData ?? this.timeExerciseData,
      setingVideoLive: setingVideoLive ?? this.setingVideoLive,
      statusVideo: statusVideo ?? this.statusVideo,
      minusFree: minusFree ?? this.minusFree,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      liveStream: liveStream ?? this.liveStream,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'autoPlay': autoPlay,
      'videoId': videoId,
      'topicId': topicId,
      'courseId': courseId,
      'status': status,
      'type': type,
      'startTime': startTime,
      'endTime': endTime,
      'lastUpdate': lastUpdate,
      'videoUrl': videoUrl,
      'timeQuestionData': timeQuestionData,
      'timeExerciseData': timeExerciseData,
      'setingVideoLive': setingVideoLive,
      'statusVideo': statusVideo,
      'minusFree': minusFree,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'liveStream': liveStream,
      'duration': duration,
    };
  }

  factory VideoScenario.fromMap(Map<String, dynamic> map) {
    return VideoScenario(
      id: map['id']?.toInt() ?? 0,
      autoPlay: map['autoPlay']?.toInt() ?? 0,
      videoId: map['videoId'] ?? '',
      topicId: map['topicId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      startTime: map['startTime']?.toInt() ?? 0,
      endTime: map['endTime']?.toInt() ?? 0,
      lastUpdate: map['lastUpdate']?.toInt() ?? 0,
      videoUrl: map['videoUrl'] ?? '',
      timeQuestionData: map['timeQuestionData'] ?? '',
      timeExerciseData: map['timeExerciseData'] ?? '',
      setingVideoLive: map['setingVideoLive']?.toInt() ?? 0,
      statusVideo: map['statusVideo']?.toInt() ?? 0,
      minusFree: map['minusFree']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      liveStream: map['liveStream'] ?? false,
      duration: map['duration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoScenario.fromJson(String source) => VideoScenario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideoScenario(id: $id, autoPlay: $autoPlay, videoId: $videoId, topicId: $topicId, courseId: $courseId, status: $status, type: $type, startTime: $startTime, endTime: $endTime, lastUpdate: $lastUpdate, videoUrl: $videoUrl, timeQuestionData: $timeQuestionData, timeExerciseData: $timeExerciseData, setingVideoLive: $setingVideoLive, statusVideo: $statusVideo, minusFree: $minusFree, title: $title, description: $description, thumbnail: $thumbnail, liveStream: $liveStream, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoScenario &&
        other.id == id &&
        other.autoPlay == autoPlay &&
        other.videoId == videoId &&
        other.topicId == topicId &&
        other.courseId == courseId &&
        other.status == status &&
        other.type == type &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.lastUpdate == lastUpdate &&
        other.videoUrl == videoUrl &&
        other.timeQuestionData == timeQuestionData &&
        other.timeExerciseData == timeExerciseData &&
        other.setingVideoLive == setingVideoLive &&
        other.statusVideo == statusVideo &&
        other.minusFree == minusFree &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.liveStream == liveStream &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        autoPlay.hashCode ^
        videoId.hashCode ^
        topicId.hashCode ^
        courseId.hashCode ^
        status.hashCode ^
        type.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        lastUpdate.hashCode ^
        videoUrl.hashCode ^
        timeQuestionData.hashCode ^
        timeExerciseData.hashCode ^
        setingVideoLive.hashCode ^
        statusVideo.hashCode ^
        minusFree.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        liveStream.hashCode ^
        duration.hashCode;
  }
}
