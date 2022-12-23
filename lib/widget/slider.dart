import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../index.dart';

class SliderAudio extends StatelessWidget {
  final Duration progress;
  final Duration total;
  final double? width;
  final Function(dynamic)? onChanged;
  final bool showValue;
  final Widget? widgetAction;
  const SliderAudio({
    key,
    required this.progress,
    required this.total,
    this.width,
    this.onChanged,
    this.showValue = true,
    this.widgetAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        children: [
          widgetAction ?? Container(),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(overlayShape: SliderComponentShape.noThumb),
              child: Slider(
                value: 50,
                max: 100,
                inactiveColor: AppColors.colorInActive,
                onChanged: (v) {
                  if (onChanged != null) {
                    onChanged!(v);
                  }
                },
              ),
            ),
          ),
          // SizedBox(width: halfPadding),
          showValue
              ? Text(
                  "${progress.inSeconds} / ${total.inSeconds}",
                  style: StyleApp.titleExtraSmall(fontSize: 10.sp, color: AppColors.colorActive),
                )
              : Container()
        ],
      ),
    );
  }
}
