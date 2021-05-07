import 'package:flutter/material.dart';

import 'common.dart';
import 'percent_indicator/percent_indicator.dart';
import 'st_step_progress.dart';

class STProgress extends StatefulWidget {
  final STProgressType type;
  final STProgressStatus status;
  final double width;
  final double height;
  final double radius;
  final double lineWidth;
  final double progress;
  final Color color;
  final Widget trailingWidget;
  final Widget centerWidget;
  final int stepCount;

  const STProgress({
    Key key,
    this.progress = 0,
    this.type = STProgressType.primary,
    this.status = STProgressStatus.primary,
    this.width,
    this.height,
    this.radius = 75,
    this.lineWidth,
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
    double curProgress;
    if (widget.progress > 1) {
      curProgress = 1;
    } else if (widget.progress < 0) {
      curProgress = 0;
    } else {
      curProgress = widget.progress;
    }

    Widget content;
    switch (widget.type) {
      case STProgressType.primary:
      case STProgressType.percent:
        {
          content = LinearPercentIndicator(
            width: widget.width,
            lineHeight: widget.height,
            percent: curProgress,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: STProgressConstant.defaultBackgroundColor,
            progressColor: widget.color,
            trailing: widget.trailingWidget,
            widgetIndicator: widget.type == STProgressType.percent
                ? Text(
                    '${curProgress * 100}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.height - 4,
                    ),
                  )
                : null,
          );
        }
        break;
      case STProgressType.stepRect:
      case STProgressType.stepDot:
        {
          content = STStepProgress(
            width: widget.width,
            height: widget.height,
            count: widget.stepCount,
            progress: curProgress,
            progressColor: widget.color,
            isCircle: widget.type == STProgressType.stepDot,
          );
        }
        break;
      default:
        {
          content = CircularPercentIndicator(
              diameter: widget.radius * 2,
              lineWidth: widget.lineWidth,
              animation: true,
              percent: curProgress,
              center: widget.centerWidget,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: widget.color,
              arcType: widget.type == STProgressType.dashboard
                  ? ArcType.GAP
                  : ArcType.NORMAL);
        }
        break;
    }
    return content;
  }
}
