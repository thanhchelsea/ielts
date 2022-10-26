import 'dart:ui';
import 'package:path_drawing/path_drawing.dart';

Path dashPathWidthLimit(
  Path source, {
  required CircularIntervalList<double> dashArray,
  DashOffset? dashOffset,
  int? limit,
}) {
  // assert(dashArray != null);

  limit = limit ?? 0;
  dashOffset = dashOffset ?? const DashOffset.absolute(0.0);
  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    bool draw = true;
    int index = 0;
    while (distance < metric.length) {
      final double len = dashArray.next;
      if (draw || limit > 0 && index < limit || limit < 0 && limit > -1 * index) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
      index++;
    }
  }

  return dest;
}

enum _DashOffsetType { Absolute, Percentage }

/// Specifies the starting position of a dash array on a path, either as a
/// percentage or absolute value.
///
/// The internal value will be guaranteed to not be null.
class DashOffset {
  /// Create a DashOffset that will be measured as a percentage of the length
  /// of the segment being dashed.
  ///
  /// `percentage` will be clamped between 0.0 and 1.0; null will be converted
  /// to 0.0.
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.Percentage;

  /// Create a DashOffset that will be measured in terms of absolute pixels
  /// along the length of a [Path] segment.
  ///
  /// `start` will be coerced to 0.0 if null.
  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.Absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.Absolute ? _rawVal : length * _rawVal;
  }
}
