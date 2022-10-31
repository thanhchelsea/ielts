import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/topic.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/config.dart';

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
                      color: AppColors.blue,
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
    if (topic.progress?.progress == 100) {
      return Center(child: null);
    }
    // if (topic.progress.lock == true) {
    if (true) {
      return Center(child: SvgPicture.asset(AppImages.praticeTopic, color: Color(0xFFBDB7B7), width: 14));
    }
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
    // if (topic.progress.lock == true) {
    //   return Container(
    //     width: radius,
    //     height: radius,
    //     decoration: BoxDecoration(
    //         shape: BoxShape.circle, color: Colors.white, border: Border.all(width: 1, color: Color(0xFFDEDEDE))),
    //   );
    // }
    return ClipPolygon(
      sides: 6,
      borderRadius: 12.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffD3E7FF),
        ),
        padding: EdgeInsets.symmetric(vertical: padding10, horizontal: padding10),
        child: ClipPolygon(
          sides: 6,
          borderRadius: 12.0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xff3F7BDD),
                  Color(0xff88B9FF),
                ],
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding_4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    topic.type == Configs.TOPIC_TYPE_LESSON ? AppImages.video : AppImages.praticeTopic,
                    width: 25.h,
                  ),
                  SizedBox(height: padding_4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      topic.type == Configs.TOPIC_TYPE_LESSON ? "Video" : "Practice",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.w600),
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

class AppImages {
  static String logoInApp = "assets/images/logo_in_app.svg";
  static String menu = "assets/images/menu.svg";
  static String wave = "assets/images/wave.svg";
  static String computer = "assets/images/computer.svg";
  static String conversation = "assets/images/conversation.svg";
  static String writing = "assets/images/writing.svg";
  static String practice = "assets/images/practice.png";
  static String history = "assets/images/history.png";
  static String boxChat = "assets/images/box_chat.png";
  static String arrow = "assets/images/arrow.png";
  static String splash = "assets/images/splash.svg";
  static String loading = "assets/images/loading.gif";
  static String video = "assets/images/video.svg";
  static String praticeTopic = "assets/images/practice_topic.svg";
}
