import 'package:flutter/material.dart';

import 'common.dart';
import 'percent_indicator/percent_indicator.dart';
import 'st_step_progress.dart';

class STProgress extends StatefulWidget {
  final STProgressType type;
  final STProgressStatus status;
  final double width;
  final double height;
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
    this.width = 150.0,
    this.height = 8.0,
    this.color = STProgressConstant.defaultBackgroundColor,
    this.trailingWidget,
    this.centerWidget,
    this.stepCount = 10,
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
          Color curProgressColor = widget.color;
          Widget curTrailingWidget = widget.trailingWidget;
          if (widget.type == STProgressType.primary &&
              widget.status != STProgressStatus.primary) {
            curProgressColor = colorFromProgressStatus(widget.status);
            curTrailingWidget =
                iconFromProgressStatus(widget.status, widget.height);
          }
          content = LinearPercentIndicator(
            width: widget.width,
            lineHeight: widget.height,
            percent: curProgress,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: STProgressConstant.defaultBackgroundColor,
            progressColor: curProgressColor,
            trailing: curTrailingWidget,
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
      case STProgressType.circle:
      case STProgressType.dashboard:
        {
          content = CircularPercentIndicator(
              diameter: widget.width,
              lineWidth: widget.height,
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
      default:
        content = Container();
        break;
    }
    return content;
  }

  Color colorFromProgressStatus(STProgressStatus status) {
    switch (status) {
      case STProgressStatus.done:
        return STProgressConstant.colorDone;
      case STProgressStatus.warning:
        return STProgressConstant.colorWarnning;
      case STProgressStatus.error:
        return STProgressConstant.colorError;
      default:
        return Colors.transparent;
    }
  }

  Widget iconFromProgressStatus(STProgressStatus status, double iconWidth) {
    IconData iconData;
    final Color iconColor = colorFromProgressStatus(status);
    switch (status) {
      case STProgressStatus.error:
        iconData = Icons.cancel;
        break;
      case STProgressStatus.warning:
        iconData = Icons.info;
        break;
      case STProgressStatus.done:
        iconData = Icons.check_circle;
        break;
      default:
        iconData = Icons.info;
    }
    return Icon(
      iconData,
      size: iconWidth,
      color: iconColor,
    );
  }
}
