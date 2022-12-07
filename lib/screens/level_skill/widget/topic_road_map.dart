import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dash_part.dart';
import 'topic_item.dart';

import 'dart:math' as Math;
import 'package:path_drawing/path_drawing.dart';

enum DirectionLine { left_to_right, right_to_left }

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
  int rowTopic = 0, lastIndexUnlock = 0;
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
          lastIndexUnlock: lastIndexUnlock,
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
    lastIndexUnlock = 0;
    int lastChildLock = 0;
    for (int index = 0; index < topics.length; index++) {
      Topic topic = topics[index];
      var isLock = true;
      if ((topic.topicProgress?.progress ?? 0) == 0) {
        //check lock topic here
        lastIndexUnlock = index;
      }
      if (temp % 2 == 0) {
        childs.add(_makeTopicItem(topic, index, topic.id == lastChildLock, isLock));
        if (childs.length == 3) {
          List<Widget> cs = [];
          cs.addAll(childs);
          widget = _makeTopicsRow(cs);
          temp++;
          childs = [];
          widgets.add(widget);
        } else if (index > 0 && childs.length == 2 && index % 3 == 1 && index == topics.length - 1) {
          childs.insert(
              2,
              const SizedBox(
                width: 102.4,
                height: 102.4,
              ));
        }
      } else {
        childs.insert(0, _makeTopicItem(topic, index, topic.id == lastChildLock, isLock));
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
              const SizedBox(
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
        mainAxisAlignment: childs.length == 1
            ? widget.topics.length % 6 == 1
                ? MainAxisAlignment.start
                : MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: childs,
      ),
    );
  }

  _makeTopicItem(Topic topic, int index, bool showAnim, bool isLock) {
    return TopicItemNew(
      color: Colors.red,
      showAnim: showAnim,
      size: topicItemSize,
      topic: topic,
      isLock: isLock,
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
  final int lastIndexUnlock;
  final Color color;
  int rowPadding;
  int topicsLength;
  late Paint _paint;

  Drawline(
      {required this.row,
      required this.lastIndexUnlock,
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
    int reminderDivision = _topicLenghs % 3;
    var path = Path();
    var _newY = y + index * rowPadding;
    path.moveTo(x, _newY);
    var _lineLong = (size.width - (16.w + topicItemSize / 2) * 2);
    var _betweenItemLong = _lineLong / 2;
    if (_topicLenghs > 0 && !_lastRow) {
      path.lineTo(x + _lineLong, _newY);
    } else {
      DirectionLine _directionLine = (index % 2 == 0) ? DirectionLine.left_to_right : DirectionLine.right_to_left;
      double _startPoint = 0;
      double _endPoint = 0;
      switch (reminderDivision) {
        case 0:
          _startPoint = x;
          _endPoint = _startPoint + _lineLong;
          path.lineTo(_endPoint, _newY);
          break;
        case 1:
          // if (_directionLine == DirectionLine.right_to_left) {
          //   _startPoint = x + _betweenItemLong;
          //   _endPoint = _startPoint + _betweenItemLong;
          // } else {
          //   _startPoint = x;
          //   _endPoint = _startPoint + _betweenItemLong;
          // }
          // path.moveTo(_startPoint, _newY);
          // path.lineTo(_endPoint, _newY);

          break;
        case 2:
          var _spacingEvenly = topicItemSize / 2;
          if (_directionLine == DirectionLine.right_to_left) {
            _startPoint = x + _lineLong / 2;
            _endPoint = _startPoint + _lineLong / 2 + _spacingEvenly;
          } else {
            _startPoint = x;
            _endPoint = _startPoint + _lineLong - _spacingEvenly * 2;
          }
          path.moveTo(_startPoint, _newY);
          path.lineTo(_endPoint, _newY);
          break;
        default:
      }
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
    int add = 1;
    double index = 0;
    if (part >= topicsLength) {
      // case unlock last topic
      index = 2.5;
    } else if (part % 3 == 1) {
      part == topicsLength - 1 ? index = 1.5 : index = 2;
    } else if (part % 3 == 2) {
      int a = part ~/ 3;
      index = a % 2 == 0 ? 1.0 : 0.5;
    } else {
      index = 0;
    }
    int row = (part ~/ 3) + add; // ve den hang thu row

    var _position = MyPossition(row: row, index: index);
    return _position;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double lineLength = size.width - (padding + topicItemSize / 2) * 2;
    int maxUnderLine =
        (lineLength / (5 + 10)).round(); // 5 + 10 = CircularIntervalList<double>(<double>[5, 10]), dấu gạch nối
    MyPossition possition = _findPossition(lastIndexUnlock + 1);
    for (int indexRow = 0; indexRow < row; indexRow++) {
      int limitLine = 0, limitCircle = 0;
      if (indexRow + 1 < possition.row) {
        limitLine = maxUnderLine * 2;
        limitCircle = maxUnderLine * 2;
      }
      if (indexRow + 1 == possition.row) {
        if (possition.index == 0.5) {
          limitLine = -2 * (maxUnderLine / 2).round();
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
      drawLine(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * indexRow, size, limitLine,
          rowPadding, indexRow, topicsLength, (indexRow + 1 == row));
      if (indexRow < row - 1) {
        if (indexRow + 1 >= possition.row - 1 && possition.index == 0.0) {
          // var part of possition %3=0 (unlock at topic%3 == 0)
          limitCircle = 0;
          limitLine = 0;
        }
        // TODO - ĐÍT CONG
        // drawHaftCircle(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * indexRow, size,
        //     indexRow % 2 == 0 ? 'right' : 'left', limitCircle);
        // TODO - ĐÍT VUÔNG
        drawVerticalLine(canvas, padding + topicItemSize / 2, topicItemSize / 2 + topicItemSize * indexRow, size,
            indexRow % 2 == 0 ? 'right' : 'left', limitCircle, rowPadding, indexRow);
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
