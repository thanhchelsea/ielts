import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../index.dart';
import '../../../models/topic.dart';

class TopicItemNew extends StatefulWidget {
  final bool showAnim;
  final double size;
  final Color color;
  final int topicIndex;
  final Topic topic;
  final Function tapToStudy;
  final bool isLock;

  TopicItemNew(
      {required this.showAnim,
      required this.size,
      required this.color,
      required this.tapToStudy,
      required this.topic,
      this.isLock = false,
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
  double padding12 = 12.h;
  double padding_4 = 4.h;
  double padding10 = 10.h;
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
                _makeTopicIndex(),
                _makeTopicTitle(),
              ],
            );
          },
        ),
      );
    }
    // return Container(
    //   color: Colors.green,
    //   width: size,
    //   height: size,
    //   child: Text(topic.name),
    // );
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
              _makeTopicIndex(),
              Positioned(
                top: 10,
                right: -16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: padding12, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${topic.name}",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: AppColors.colorActive,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _makeTopicIndex() {
    if (topic.topicProgress?.progress == 100) {
      return Center(child: null);
    }
    // if (topic.progress.lock == true) {
    return Container();
    // return Center(
    //     child: Text(
    //   "${topic.getPercentComplete()}%",
    //   style: TextStyle(color: Colors.white, fontFamily: "Rubik", fontWeight: FontWeight.w500, fontSize: 16),
    // ));
  }

  Widget _makeTopicTitle() {
    return Text("${topic.name}dd",
        style: TextStyle(color: Color(0xFF0C1127), fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Nutino"));
  }

  Widget _buildContainer(double radius, bool opacity) {
    Color colorOutside = Color(0xffD3E7FF);
    Color colorText = AppColors.colorWhite;

    List<Color> colors = [
      Color(0xff3F7BDD),
      Color(0xff88B9FF),
    ];
    if (topic.topicProgress?.progress == 0) {
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
          color: widget.isLock ? Colors.white : colorOutside,
        ),
        padding: EdgeInsets.symmetric(
          vertical: padding10,
          horizontal: padding10,
        ),
        child: ClipPolygon(
          sides: 6,
          borderRadius: 12.0,
          child: Container(
            decoration: !widget.isLock
                ? BoxDecoration(
                    gradient: RadialGradient(
                      colors: colors,
                    ),
                  )
                : const BoxDecoration(color: Color(0xFFEDF0F8)),
            child: Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: padding_4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    topic.type == Configs.TOPIC_TYPE_LESSON ? AppImages.video : AppImages.praticeTopic,
                    width: 25.w,
                    color: widget.isLock ? const Color(0xffAEB1BC) : null,
                  ),
                  SizedBox(height: padding_4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      topic.type == Configs.TOPIC_TYPE_LESSON ? "Video" : "Practice",
                      maxLines: 1,
                      style: StyleApp.titleSmall(
                          color: widget.isLock ? const Color(0xffAEB1BC) : colorText,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600),
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
