import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';

import '../../../index.dart';

class CurveWave extends Curve {
  const CurveWave();
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}

class MicroComponent extends StatefulWidget {
  MicroComponent({
    // this.size = 40.0,
    this.color = Colors.red,
    required this.onTap,
    required this.recording,
    this.onLongPressedEnd,
  });
  // final double size;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback? onLongPressedEnd;
  bool recording;
  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<MicroComponent> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return GestureDetector(
      // highlightColor: Colors.transparent,
      // splashColor: Colors.transparent,
      onTap: () {
        widget.onTap();
      },
      onLongPressEnd: (details) {
        if (widget.onLongPressedEnd != null) widget.onLongPressedEnd!.call();
      },
      // onLongPressEnd: () {
      //   widget.onPressedEnd();
      // },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: widget.recording
              ? ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: const CurveWave(),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(padding10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [Color(0xffFF8E4F), Color(0xffFF3636)],
                      ),
                    ),
                    child: const Icon(
                      Icons.pause,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(padding10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFE4DE),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(padding14),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [Color(0xffFF8E4F), Color(0xffFF3636)],
                      ),
                    ),
                    child: const Icon(
                      AppIcons.mic,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.recording)
      _controller.stop();
    else
      _controller.repeat();

    return Center(
      child: Column(
        children: [
          CustomPaint(
            painter: widget.recording
                ? CirclePainter(
                    _controller,
                    color: widget.color,
                  )
                : null,
            child: Container(
              width: 70.w,
              height: 70.w,
              // color: Colors.red,
              child: _button(),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
