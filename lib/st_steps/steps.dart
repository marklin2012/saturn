import 'package:flutter/material.dart';
import 'package:saturn/st_steps/common.dart';

class Steps extends StatelessWidget {
  const Steps(
      {Key key,
      this.type,
      this.margin,
      this.steps,
      this.current,
      this.deatilHeight,
      this.detailWidth})
      : super(key: key);

  final STStepsType type;
  final EdgeInsets margin;
  final List<STStepItem> steps;
  final int current;
  final double deatilHeight; //type为detail,竖排需固定高度才能排版
  final double detailWidth; // type为detail,竖排需固定宽度才能满足外部的对齐方式

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case STStepsType.dot:
        return buildDot();
      case STStepsType.number:
      case STStepsType.icon:
      // return buildNumberAndIcon();
      case STStepsType.detail:
      // return buildDetail();
    }
    return Container();
  }

  Widget buildDot() {}
}
