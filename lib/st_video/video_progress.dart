import 'package:flutter/material.dart';
import 'package:saturn/st_slider/st_slider.dart';

class STVideoProgress extends StatelessWidget {
  const STVideoProgress({
    Key key,
    this.width,
    this.height,
    this.activeColor = const Color(0xFF095BF9),
    this.inactiveColor = const Color(0xFFDCE8FF),
    this.value = 0,
    this.onChanged,
    this.activeHeight,
  }) : super(key: key);

  final double width; // 整个的宽度
  final double height; //供外部对齐
  final double activeHeight; // 中间选中的高度
  final Color activeColor;
  final Color inactiveColor;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: STSlider(
        showTip: false,
        mainSize: width,
        crossSize: activeHeight,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
