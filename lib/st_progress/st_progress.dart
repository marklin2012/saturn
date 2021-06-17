import 'package:flutter/material.dart';

import 'common.dart';
import 'percent_indicator/percent_indicator.dart';
import 'st_step_progress.dart';

class STProgress extends StatefulWidget {
  final STProgressType type;
  final STProgressStatus status;
  final double size;
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
    this.size = 150.0,
    this.height,
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

    double curHeight = widget.height;
    Widget content;
    switch (widget.type) {
      case STProgressType.primary:
      case STProgressType.percent:
        {
          if (curHeight == null) {
            if (widget.type == STProgressType.primary) {
              curHeight = 8.0;
            } else {
              curHeight = 24.0;
            }
          }
          Color curProgressColor = widget.color;
          Widget curTrailingWidget = widget.trailingWidget;

          if (widget.type == STProgressType.primary) {
            if (widget.status != STProgressStatus.primary) {
              curProgressColor = colorFromProgressStatus(widget.status);
              curTrailingWidget =
                  iconFromProgressStatus(widget.status, curHeight);
            } else {
              curTrailingWidget ??= Text(
                '${(curProgress * 100).toInt()}%',
                style: TextStyle(fontSize: curHeight),
              );
            }
          }

          content = LinearPercentIndicator(
            width: widget.size,
            lineHeight: curHeight,
            percent: curProgress,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: STProgressConstant.defaultBackgroundColor,
            progressColor: curProgressColor,
            trailing: curTrailingWidget,
            widgetIndicator: widget.type == STProgressType.percent
                ? Text(
                    '${(curProgress * 100).toInt()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: curHeight - 4,
                    ),
                  )
                : null,
          );
        }
        break;
      case STProgressType.stepRect:
      case STProgressType.stepDot:
        {
          if (curHeight == null) {
            if (widget.type == STProgressType.stepRect) {
              curHeight = 24.0;
            } else {
              curHeight = 12.0;
            }
          }
          content = STStepProgress(
            width: widget.size,
            height: curHeight,
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
          curHeight ??= 8.0;
          Widget curCenterWidget = widget.centerWidget;
          if (curCenterWidget == null && widget.type == STProgressType.circle) {
            curCenterWidget = Text(
              '${(curProgress * 100).toInt()}%',
              style: TextStyle(fontSize: curHeight * 2.0),
            );
          }
          content = CircularPercentIndicator(
              diameter: widget.size,
              lineWidth: curHeight,
              animation: true,
              percent: curProgress,
              center: curCenterWidget,
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
