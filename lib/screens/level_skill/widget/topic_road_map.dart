import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dash_part.dart';
import 'topic_item.dart';

import 'dart:math' as Math;
import 'package:path_drawing/path_drawing.dart';

class TopicRoadMap extends StatefulWidget {
  TopicRoadMap({
    Key? key,
    required this.topics,
    required this.tapToic,
  }) : super(key: key);
  List<Topic> topics;
  Function tapToic;
  @override
  State<TopicRoadMap> createState() => _TopicRoadMapState();
}

Size ratio = Size(428, 926);
double headerRatio = 235 / ratio.height;
double paddingRowEvenRatio = 50 / ratio.width;
double topicItemSizeRatio = 64 / ratio.width;
double topicItemSize = 92.4.w;
double paddingScrren = 24.w;
int rowTopicSpacing = 30;

class _TopicRoadMapState extends State<TopicRoadMap> {
  int rowTopic = 0, currentPart = 0;
  Size size = Get.size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      child: _makeListTopic(widget.topics),
      painter: Drawline(
          row: rowTopic,
          currentPart: currentPart,
          color: AppColors.colorCardPrimary,
          rowPadding: rowTopicSpacing,
          topicsLength: widget.topics.length),
    );
  }

  _makeListTopic(List<Topic> topics) {
    List<Widget> widgets = [];
    int temp = 0;
    Widget widget;
    List<Widget> childs = [];
    currentPart = 0;
    int lastChildLock = 0;
    for (int index = 0; index < topics.length; index++) {
      Topic topic = topics[index];
      if ((topic.topicProgress?.progress ?? 0) == 0) {
        currentPart = index;
      }
      if (temp % 2 == 0) {
        childs.add(_makeTopicItem(topic, index, topic.id == lastChildLock));
        if (childs.length == 3) {
          List<Widget> cs = [];
          cs.addAll(childs);
          widget = _makeTopicsRow(cs);
          temp++;
          childs = [];
          widgets.add(widget);
        }
      } else {
        childs.insert(0, _makeTopicItem(topic, index, topic.id == lastChildLock));
        if (childs.length == 3) {
          List<Widget> cs = [];
          cs.addAll(childs);
          widget = _makeTopicsRow(cs);
          // widget = Padding(
          //   padding: EdgeInsets.only(left: size.width * paddingRowEvenRatio, right: size.width * paddingRowEvenRatio),
          //   child: _makeTopicsRow(cs),
          // );
          temp++;
          childs = [];
          widgets.add(widget);
        } else if (index > 0 && childs.length == 2 && index % 3 == 1 && index == topics.length - 1) {
          childs.insert(
              0,
              Container(
                width: 102.4,
                height: 102.4,
              ));
        }
      }
    }
    if (childs.isNotEmpty) {
      widget = _makeTopicsRow(childs);
      widgets.add(widget);
    }
    rowTopic = widgets.length;
    return Padding(
      // padding: EdgeInsets.only(top: 0, left: padding, bottom: 100, right: padding),
      padding: EdgeInsets.only(top: 0, left: padding, bottom: 0, right: padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: widgets,
      ),
    );
  }

  _makeTopicsRow(List<Widget> childs) {
    return Container(
      padding: EdgeInsets.only(bottom: rowTopicSpacing.toDouble()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: childs.length < 3 ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: childs,
      ),
    );
  }

  _makeTopicItem(Topic topic, int index, bool showAnim) {
    return TopicItemNew(
      color: Colors.red,
      showAnim: showAnim,
      size: topicItemSize,
      topic: topic,
      topicIndex: index + 1,
      tapToStudy: (Topic topic) {
        widget.tapToic(topic);
        // print("tap");
      },
    );
  }
}

class Drawline extends CustomPainter {
  final int row;
  final int currentPart;
  final Color color;
  int rowPadding;
  int topicsLength;
  late Paint _paint;

  Drawline(
      {required this.row,
      required this.currentPart,
      required this.color,
      this.rowPadding = 30,
      this.topicsLength = 0}) {
    _paint = new Paint();
    _paint.color = color;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 4;
  }

  drawLine(Canvas canvas, double x, double y, Size size, int limit, int rowPadding, int index, int topicsLength,
      bool _lastRow) {
    var _topicLenghs = topicsLength;
    bool _drawLimitToCenter = (_topicLenghs > 0 && _topicLenghs % 3 == 2);
    var path = Path();
    var _newY = y + index * rowPadding;
    path.moveTo(x, _newY);
    if (_drawLimitToCenter && _lastRow) {
      path.moveTo(x + (size.width - 2 * padding) / 3, _newY);
      path.lineTo(x + (size.width - (padding + topicItemSize / 2) * 2), _newY);
    } else {
      path.lineTo(x + (size.width - (padding + topicItemSize / 2) * 2), _newY);
    }
    canvas.drawPath(
      dashPathWidthLimit(path, dashArray: CircularIntervalList<double>(<double>[5, 10]), limit: limit),
      _paint,
    );
    path.close();
  }

  drawHaftCircle(Canvas canvas, double x, double y, Size size, String rotate, int limit) {
    var path = Path();
    if (rotate == 'left') {
      path.moveTo(x, y);
      path.cubicTo(
          x - topicItemSize * 2 / Math.pi, y, x - topicItemSize * 2 / Math.pi, y + topicItemSize, x, y + topicItemSize);
    } else {
      x = x + size.width - (padding + topicItemSize / 2) * 2;
      path.moveTo(x, y);
      path.cubicTo(
          topicItemSize * 2 / Math.pi + x, y, topicItemSize * 2 / Math.pi + x, topicItemSize + y, x, y + topicItemSize);
    }
    canvas.drawPath(
      dashPathWidthLimit(
        path,
        dashArray: CircularIntervalList<double>(<double>[5, 10]),
        limit: limit,
      ),
      _paint,
    );
    path.close();
  }

  drawVerticalLine(Canvas canvas, double x, double y, Size size, String rotate, int limit, int rowPadding, int index) {
    // + 2 -2 la de cho góc vuông trông liền mạch
    var path = Path();
    y = y + index * rowPadding;
    if (rotate == 'left') {
      path.moveTo(x, y - 2);
      path.lineTo(x, y + topicItemSize + 2 + rowPadding);
    } else {
      x = x + size.width - (padding + topicItemSize / 2) * 2;
      path.moveTo(x, y - 2);
      path.lineTo(x, y + topicItemSize + 2 + rowPadding);
    }
    canvas.drawPath(
      dashPathWidthLimit(path, dashArray: CircularIntervalList<double>(<double>[5, 10]), limit: limit),
      _paint,
    );
    path.close();
  }

  MyPossition _findPossition(int part) {
    int add = 0;
    double index = 0;
    if (part % 5 == 4) {
      add = 2;
      index = 1.5;
    } else if (part % 5 == 1 || part % 5 == 2 || part % 5 == 3) {
      add = 1;
      index = (part % 5 - 1).roundToDouble();
    } else {
      add = 0;
      index = 0.5;
    }
    int row = (part ~/ 5) * 2 + add;
    var _position = MyPossition(row: row, index: index);
    return _position;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double lineLength = size.width - (padding + topicItemSize / 2) * 2;
    int maxUnderLine =
        (lineLength / (5 + 10)).round(); // 5 + 10 = CircularIntervalList<double>(<double>[5, 10]), dấu gạch nối
    MyPossition possition = _findPossition(currentPart + 1);
    for (int index = 0; index < row; index++) {
      int limitLine = 0, limitCircle = 0;
      if (index + 1 < possition.row) {
        limitLine = maxUnderLine * 2;
        limitCircle = maxUnderLine * 2;
      }
      if (index + 1 == possition.row) {
        if (possition.index == 0.5) {
          limitLine = -1 * (maxUnderLine / 2).round();
          limitCircle = 0;
        }
        if (possition.index == 1.5) {
          limitLine = -1 * (maxUnderLine + (maxUnderLine / 3).round());
          limitCircle = 0;
        }
        if (possition.index == 1.0) {
          limitLine = maxUnderLine;
          limitCircle = 0;
        }
        if (possition.index == 2.0) {
          limitLine = maxUnderLine * 2 - 100;
          limitCircle = 0;
        }
      }
      drawLine(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * index, size, limitLine,
          rowPadding, index, topicsLength, (index + 1 == row));
      if (index < row - 1) {
        // TODO - ĐÍT CONG
        // drawHaftCircle(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * index, size,
        //     index % 2 == 0 ? 'right' : 'left', limitCircle);
        // TODO - ĐÍT VUÔNG
        drawVerticalLine(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * index, size,
            index % 2 == 0 ? 'right' : 'left', limitCircle, rowPadding, index);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyPossition {
  final int row;
  final double index;
  MyPossition({required this.row, required this.index});

  @override
  String toString() {
    return "row = $row - index = $index";
  }
}
