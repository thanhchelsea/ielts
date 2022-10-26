import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ielts/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/topic.dart';

class TopicItemNew extends StatefulWidget {
  final bool showAnim;
  final double size;
  final Color color;
  final int topicIndex;
  final Topic topic;
  final Function tapToStudy;

  TopicItemNew(
      {required this.showAnim,
      required this.size,
      required this.color,
      required this.tapToStudy,
      required this.topic,
      required this.topicIndex})
      : super();

  @override
  State<StatefulWidget> createState() => TopicItemNewState(
      size: this.size, color: this.color, topicIndex: this.topicIndex, topic: this.topic, tapToStudy: this.tapToStudy);
}

class TopicItemNewState extends State<TopicItemNew> with SingleTickerProviderStateMixin {
  final double size;
  final Color color;
  final int topicIndex;
  final Topic topic;
  final Function tapToStudy;
  double scale = 1.6;
  late AnimationController _animation;

  TopicItemNewState(
      {required this.size,
      required this.color,
      required this.tapToStudy,
      required this.topicIndex,
      required this.topic})
      : super();

  @override
  void initState() {
    super.initState();
    _animation = new AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 2),
      value: 0,
    )..repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapToStudy(topic);
      },
      child: _makeWidget(),
    );
  }

  _makeWidget() {
    // if (topic.progress.lock == false && widget.showAnim) {
    if (true && widget.showAnim) {
      return Container(
        // color: Colors.green,
        width: size,
        height: size,
        child: AnimatedBuilder(
          animation: CurvedAnimation(parent: _animation, curve: Curves.fastOutSlowIn),
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildContainer((size / scale) * 1.1 * _animation.value, true),
                _buildContainer((size / scale) * 1.4 * _animation.value, true),
                _buildContainer((size / scale) * 1.6 * _animation.value, true),
                _buildContainer((size / scale), false),
                _makeTopicTitle(),
              ],
            );
          },
        ),
      );
    }
    return Container(
      // color: Colors.green,
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildContainer(size / scale, false),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10.h,
                right: -16.w,
                child: _makeTopicTitle(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _makeTopicTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding12, vertical: 7.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: Offset(0, 4),
          spreadRadius: 0,
          color: AppColors.shadowColor,
        )
      ]),
      child: Text(
        "${topic.name}",
        style: StyleApp.titleSmall(
          fontSize: 9.sp,
          color: AppColors.colorActive,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildContainer(double radius, bool opacity) {
    Color colorOutside = Color(0xffD3E7FF);
    Color colorText = AppColors.colorWhite;

    List<Color> colors = [
      Color(0xff3F7BDD),
      Color(0xff88B9FF),
    ];
    if (topic.topicProgress?.progress == 100) {
      colorText = AppColors.colorInActive;
      colorOutside = Colors.white;
      colors = [
        Color(0xffEDF0F8),
        Color(0xffEDF0F8),
      ];
    }
    return ClipPolygon(
      sides: 6,
      borderRadius: 12.0,
      child: Container(
        decoration: BoxDecoration(
          color: colorOutside,
        ),
        padding: EdgeInsets.symmetric(
          vertical: padding10,
          horizontal: padding10,
        ),
        child: ClipPolygon(
          sides: 6,
          borderRadius: 12.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: colors,
              ),
            ),
            child: Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: padding_4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    topic.type == Configs.TOPIC_TYPE_LESSON ? AppImages.video : AppImages.praticeTopic,
                    width: 25.w,
                  ),
                  SizedBox(height: padding_4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      topic.type == Configs.TOPIC_TYPE_LESSON ? "Video" : "Practice",
                      maxLines: 1,
                      style: StyleApp.titleSmall(color: colorText, fontSize: 9.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
