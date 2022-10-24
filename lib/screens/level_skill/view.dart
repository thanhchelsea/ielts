import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ielts/base/index.dart';
import 'package:ielts/index.dart';
import 'package:ielts/screens/level_skill/controller.dart';
import 'package:ielts/widget/custom_app_bar.dart';

class LevelSkillUI extends BaseView<LevelSkillController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: "Speaking",
    );
  }

  int lengthList = 10;
  late List<String> listNumber;

  @override
  Widget body(BuildContext context) {
    return Text("ggg");
    lengthList = 9;
    int getNumber() {
      //so luong row
      int maxLenght = listNumber.length;
      double x1 = (maxLenght) / 5;
      double x2 = (maxLenght - 1) / 5;
      int valueFinal = x1.ceil() + x2.ceil();
      return valueFinal;
    }

    listNumber = List.generate(lengthList, (index) => index.toString());
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05 + 30,
            ),
            //Line Paint
            Container(
              color: Colors.white38,
              height: (size.height * 0.14) * (getNumber() - 1),
              width: size.width,
              child: CustomPaint(
                size: Size(size.width, size.height),
                painter: DashedPathPainter(
                  originalPath: pathCustom(size, getNumber(), lengthList),
                  dashGapLength: 15,
                  strokeWidth: 5,
                  dashLength: 15,
                  pathColor: Colors.black,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -size.height * 0.05,
                      right: 0,
                      left: 0,
                      child: Column(
                        //so luong row
                        children: List.generate(
                          getNumber(),
                          (indexColumn) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: size.height * 0.02,
                                right: size.height * 0.02,
                                bottom: size.height * 0.04,
                              ),
                              // child: indexColumn < 11
                              //     ? Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //         children: List.generate(
                              //           3,
                              //           (indexRow) {
                              //             int numberStepTwo = indexColumn ~/ 2;
                              //             int numberStepThree = (3 * indexColumn + indexRow);
                              //             bool checkLength = numberStepThree - numberStepTwo < listNumber.length;
                              //             bool checkQuestion = checkLength
                              //                 ? listNumber[numberStepThree - numberStepTwo].toString() == "?"
                              //                 : false;
                              //             return checkLength
                              //                 ? (checkQuestion
                              //                     ? TextContainerLozenge(
                              //                         text: listNumber[numberStepThree - numberStepTwo].toString())
                              //                     : TextShapeCircle(
                              //                         text: listNumber[numberStepThree - numberStepTwo].toString(),
                              //                       ))
                              //                 : Container();
                              //           },
                              //         ),
                              //       )
                              //     : Stack(
                              //         alignment: Alignment.center,
                              //         children: List.generate(
                              //           2,
                              //           (indexRow) {
                              //             int numberStepTwo = indexColumn ~/ 2;
                              //             int numberStepThree = (3 * indexColumn + indexRow);
                              //             bool checkLength = numberStepThree - numberStepTwo < listNumber.length;
                              //             bool checkQuestion = checkLength
                              //                 ? listNumber[numberStepThree - numberStepTwo].toString() == "?"
                              //                 : false;
                              //             return checkLength
                              //                 ? Align(
                              //                     alignment: Alignment(indexRow == 0 ? 0.55 : -0.55, 0),
                              //                     child: (checkQuestion
                              //                         ? TextContainerLozenge(
                              //                             text: listNumber[numberStepThree - numberStepTwo].toString())
                              //                         : TextShapeCircle(
                              //                             text: listNumber[numberStepThree - numberStepTwo].toString(),
                              //                           )))
                              //                 : Container();
                              //           },
                              //         ),
                              //       ),

                              // child: Stack(
                              //   alignment: Alignment.center,
                              //   children: returnRowLength(indexColumn),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: returnRowLength(indexColumn),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> returnRowLength(int indexColumn) {
    List<Widget> level = [];
    int index = indexColumn * 3;

    for (int i = index; i < index + 3; i++) {
      // int numberStepTwo = indexColumn ~/ 2;
      // int numberStepThree = (3 * indexColumn + i);
      // bool checkLength = numberStepThree - numberStepTwo < listNumber.length;
      // print("${numberStepThree - numberStepTwo} xxxx $numberStepThree - $numberStepTwo < ${listNumber.length}");
      if (i < listNumber.length) {
        level.add(
          Align(
            alignment: Alignment(i == 1 ? 0.55 : -0.55, 0),
            child: TextShapeCircle(
              text: listNumber[i].toString(),
            ),
          ),
        );
      } else
        level.add(Container());
    }
    print("xxxx ${level}");
    if (indexColumn % 2 != 0) return level.reversed.toList();
    return level;
  }

  Path pathCustom(Size size, int lengthRow, int lengthList) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.2, 0);
    path0.lineTo(size.width * 0.2, 0);
    path0.lineTo(size.width * 0.8, 0);
    //line 1

    for (int i = 0; i < (lengthRow % 2 == 0 ? (lengthRow / 2) : (lengthRow ~/ 2)); i++) {
      path0.moveTo(size.width * 0.8, size.height * 0.28 * i);
      path0.quadraticBezierTo(size.width * 0.8, size.height * 0.28 * i, size.width * 0.8, size.height * 0.28 * i);
      path0.cubicTo(size.width, size.height * 0.28 * i, size.width, size.height * 0.14 * (i + i + 1), size.width * 0.8,
          size.height * 0.14 * (i + i + 1));
      path0.quadraticBezierTo(
          size.width * 0.8, size.height * 0.14 * (i + i + 1), size.width * 0.8, size.height * 0.14 * (i + i + 1));

      //fix line following lengthList
      if (lengthRow % 2 == 0) {
        if (i == (lengthRow % 2 == 0 ? (lengthRow / 2) : (lengthRow ~/ 2)) - 1) {
          int valueMaxLine = 5 * (lengthRow ~/ 2);
          if (valueMaxLine == lengthList) {
            path0.quadraticBezierTo(
                size.width * 0.8, size.height * 0.14 * (i + i + 1), size.width * 0.2, size.height * 0.14 * (i + i + 1));
          } else {
            path0.quadraticBezierTo(size.width * 0.8, size.height * 0.14 * (i + i + 1), size.width * 0.65,
                size.height * 0.14 * (i + i + 1));
          }
        } else {
          path0.quadraticBezierTo(
              size.width * 0.8, size.height * 0.14 * (i + i + 1), size.width * 0.2, size.height * 0.14 * (i + i + 1));
        }
      } else {
        path0.quadraticBezierTo(
            size.width * 0.8, size.height * 0.14 * (i + i + 1), size.width * 0.2, size.height * 0.14 * (i + i + 1));
      }
    }
    for (int i = 0; i < (lengthRow % 2 == 0 ? (lengthRow / 2 - 1) : (lengthRow / 2).ceil() - 1); i++) {
      path0.moveTo(size.width * 0.2, size.height * 0.14 * (i + i + 1));
      path0.quadraticBezierTo(
          size.width * 0.2, size.height * 0.14 * (i + i + 1), size.width * 0.2, size.height * 0.14 * (i + i + 1));
      path0.cubicTo(0, size.height * 0.14 * (i + i + 1), 0, size.height * 0.28 * (i + 1), size.width * 0.2,
          size.height * 0.28 * (i + 1));
      path0.quadraticBezierTo(
          size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.3, size.height * 0.28 * (i + 1));

      //fix line following lengthList
      if (lengthRow % 2 == 1) {
        if (i == (lengthRow % 2 == 0 ? (lengthRow / 2 - 1) : (lengthRow / 2).ceil() - 1) - 1) {
          int valueMaxLine = 5 * (lengthRow ~/ 2);
          if (valueMaxLine + 1 == lengthList) {
            path0.quadraticBezierTo(
                size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.2, size.height * 0.28 * (i + 1));
          } else if (valueMaxLine + 2 == lengthList) {
            path0.quadraticBezierTo(
                size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.5, size.height * 0.28 * (i + 1));
          } else if (valueMaxLine + 3 == lengthList) {
            path0.quadraticBezierTo(
                size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.8, size.height * 0.28 * (i + 1));
          }
        } else {
          path0.quadraticBezierTo(
              size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.8, size.height * 0.28 * (i + 1));
        }
      } else {
        path0.quadraticBezierTo(
            size.width * 0.2, size.height * 0.28 * (i + 1), size.width * 0.8, size.height * 0.28 * (i + 1));
      }
    }

    return path0;
  }
}

class DashedPathPainter extends CustomPainter {
  final Path originalPath;
  final Color pathColor;
  final double strokeWidth;
  final double dashGapLength;
  final double dashLength;
  late DashedPathProperties _dashedPathProperties;

  DashedPathPainter({
    required this.originalPath,
    required this.pathColor,
    this.strokeWidth = 3.0,
    this.dashGapLength = 5.0,
    this.dashLength = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _dashedPathProperties = DashedPathProperties(
      path: Path(),
      dashLength: dashLength,
      dashGapLength: dashGapLength,
    );
    final dashedPath = _getDashedPath(originalPath, dashLength, dashGapLength);
    canvas.drawPath(
      dashedPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = pathColor
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(DashedPathPainter oldDelegate) =>
      oldDelegate.originalPath != originalPath ||
      oldDelegate.pathColor != pathColor ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.dashGapLength != dashGapLength ||
      oldDelegate.dashLength != dashLength;

  Path _getDashedPath(
    Path originalPath,
    double dashLength,
    double dashGapLength,
  ) {
    final metricsIterator = originalPath.computeMetrics().iterator;
    while (metricsIterator.moveNext()) {
      final metric = metricsIterator.current;
      _dashedPathProperties.extractedPathLength = 0.0;
      while (_dashedPathProperties.extractedPathLength < metric.length) {
        if (_dashedPathProperties.addDashNext) {
          _dashedPathProperties.addDash(metric, dashLength);
        } else {
          _dashedPathProperties.addDashGap(metric, dashGapLength);
        }
      }
    }
    return _dashedPathProperties.path;
  }
}

class DashedPathProperties {
  double extractedPathLength;
  Path path;

  final double _dashLength;
  double _remainingDashLength;
  double _remainingDashGapLength;
  bool _previousWasDash;

  DashedPathProperties({
    required this.path,
    required double dashLength,
    required double dashGapLength,
  })  : assert(dashLength > 0.0, 'dashLength must be > 0.0'),
        assert(dashGapLength > 0.0, 'dashGapLength must be > 0.0'),
        _dashLength = dashLength,
        _remainingDashLength = dashLength,
        _remainingDashGapLength = dashGapLength,
        _previousWasDash = false,
        extractedPathLength = 0.0;

  bool get addDashNext {
    if (!_previousWasDash || _remainingDashLength != _dashLength) {
      return true;
    }
    return false;
  }

  void addDash(PathMetric metric, double dashLength) {
    // Calculate lengths (actual + available)
    final end = _calculateLength(metric, _remainingDashLength);
    final availableEnd = _calculateLength(metric, dashLength);
    // Add path
    final pathSegment = metric.extractPath(extractedPathLength, end);
    path.addPath(pathSegment, Offset.zero);
    // Update
    final delta = _remainingDashLength - (end - extractedPathLength);
    _remainingDashLength = _updateRemainingLength(
      delta: delta,
      end: end,
      availableEnd: availableEnd,
      initialLength: dashLength,
    );
    extractedPathLength = end;
    _previousWasDash = true;
  }

  void addDashGap(PathMetric metric, double dashGapLength) {
    // Calculate lengths (actual + available)
    final end = _calculateLength(metric, _remainingDashGapLength);
    final availableEnd = _calculateLength(metric, dashGapLength);
    // Move path's end point
    Tangent tangent = metric.getTangentForOffset(end)!;
    path.moveTo(tangent.position.dx, tangent.position.dy);
    // Update
    final delta = end - extractedPathLength;
    _remainingDashGapLength = _updateRemainingLength(
      delta: delta,
      end: end,
      availableEnd: availableEnd,
      initialLength: dashGapLength,
    );
    extractedPathLength = end;
    _previousWasDash = false;
  }

  double _calculateLength(PathMetric metric, double addedLength) {
    return min(extractedPathLength + addedLength, metric.length);
  }

  double _updateRemainingLength({
    required double delta,
    required double end,
    required double availableEnd,
    required double initialLength,
  }) {
    return (delta > 0 && availableEnd == end) ? delta : initialLength;
  }
}

//widget
class TextContainerLozenge extends StatelessWidget {
  const TextContainerLozenge({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(45 / 360),
      child: Container(
        width: size.height * 0.08,
        height: size.height * 0.08,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-45 / 360),
          child: Text(text,
              style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class TextShapeCircle extends StatelessWidget {
  const TextShapeCircle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.height * 0.1,
      height: size.height * 0.1,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.colorPrimaryApp, shape: BoxShape.circle),
      child:
          Text(text, style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontWeight: FontWeight.bold)),
    );
  }
}
