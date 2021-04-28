import 'package:flutter/material.dart';

import 'st_step_progress.dart';
import 'common.dart';
import 'percent_indicator/percent_indicator.dart';

class STProgress extends StatefulWidget {
  final STProgressType type;
  final double width;
  final double height;
  final double radius;
  final double progress;
  final Color color;
  final Widget trailingWidget;
  final Widget centerWidget;
  final bool showInnerProgress;
  final bool isInstrument;
  final int stepCount;
  final bool isStepCircle;

  const STProgress(
      {Key key,
      this.type,
      this.width,
      this.height,
      this.radius,
      this.progress,
      this.color,
      this.trailingWidget,
      this.centerWidget,
      this.showInnerProgress = false,
      this.isInstrument = false,
      this.stepCount,
      this.isStepCircle})
      : super(key: key);

  @override
  _STProgressState createState() => _STProgressState();
}

class _STProgressState extends State<STProgress> {
  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (widget.type) {
      case STProgressType.line:
        {
          content = LinearPercentIndicator(
            width: widget.width,
            lineHeight: widget.height,
            percent: widget.progress,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: STProgressConstant.defaultBackgroundColor,
            progressColor: widget.color,
            trailing: widget.trailingWidget,
            widgetIndicator: widget.showInnerProgress
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
      case STProgressType.step:
        {
          content = STStepProgress(
            width: widget.width,
            height: widget.height,
            count: widget.stepCount,
            progress: widget.progress,
            progressColor: widget.color,
            isCircle: widget.isStepCircle,
          );
        }
        break;
      case STProgressType.circular:
        {
          content = CircularPercentIndicator(
              radius: widget.radius,
              lineWidth: widget.height,
              animation: true,
              percent: widget.progress,
              center: widget.centerWidget,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: widget.color,
              arcType:
                  widget.isInstrument ? ArcType.INSTRUMENT : ArcType.NORMAL);
        }
        break;
    }
    return content;
  }
}
