import 'package:flutter/material.dart';

import 'common.dart';
import 'percent_indicator/percent_indicator.dart';
import 'st_step_progress.dart';

class STProgress extends StatefulWidget {
  final STProgressShape shape;
  final double width;
  final double height;
  final double radius;
  final double progress;
  final Color color;
  final Widget trailingWidget;
  final Widget centerWidget;
  final int stepCount;

  const STProgress({
    Key key,
    this.shape,
    this.width,
    this.height,
    this.radius,
    this.progress,
    this.color,
    this.trailingWidget,
    this.centerWidget,
    this.stepCount,
  }) : super(key: key);

  @override
  _STProgressState createState() => _STProgressState();
}

class _STProgressState extends State<STProgress> {
  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (widget.shape) {
      case STProgressShape.line:
      case STProgressShape.lineProgress:
        {
          content = LinearPercentIndicator(
            width: widget.width,
            lineHeight: widget.height,
            percent: widget.progress,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: STProgressConstant.defaultBackgroundColor,
            progressColor: widget.color,
            trailing: widget.trailingWidget,
            widgetIndicator: widget.shape == STProgressShape.lineProgress
                ? Text(
                    '${widget.progress * 100}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.height - 4,
                    ),
                  )
                : null,
          );
        }
        break;
      case STProgressShape.stepRect:
      case STProgressShape.stepCircle:
        {
          content = STStepProgress(
            width: widget.width,
            height: widget.height,
            count: widget.stepCount,
            progress: widget.progress,
            progressColor: widget.color,
            isCircle: widget.shape == STProgressShape.stepCircle ? true : false,
          );
        }
        break;
      case STProgressShape.circle:
      case STProgressShape.circleGap:
        {
          content = CircularPercentIndicator(
              radius: widget.radius,
              lineWidth: widget.height,
              animation: true,
              percent: widget.progress,
              center: widget.centerWidget,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: widget.color,
              arcType: widget.shape == STProgressShape.circleGap
                  ? ArcType.Gap
                  : ArcType.NORMAL);
        }
        break;
      default:
    }
    return content;
  }
}
