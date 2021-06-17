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
    this.color,
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

    STProgressStatus curStatus = widget.status;
    //如果没有传入颜色和控件，且progress>=1，显示默认done状态
    if (curProgress == 1 &&
        widget.color == null &&
        widget.trailingWidget == null &&
        widget.centerWidget == null) {
      curStatus = STProgressStatus.done;
    }

    Color curProgressColor = widget.color;

    if (curStatus != STProgressStatus.primary) {
      curProgressColor = colorFromProgressStatus(curStatus);
    }
    {
      curProgressColor ??= colorFromProgressStatus(curStatus);
    }
    double curHeight = widget.height;
    Widget content;
    Widget curTrailingWidget = widget.trailingWidget;

    switch (widget.type) {
      case STProgressType.primary:
      case STProgressType.percent:
        {
          Widget curIndicatorWidget;
          bool curIsTextIndicator = true;
          if (widget.type == STProgressType.primary) {
            curHeight ??= 8.0;
            if (curStatus != STProgressStatus.primary) {
              curTrailingWidget =
                  iconFromProgressStatus(curStatus, curHeight, false);
            } else {
              curTrailingWidget ??= Text(
                '${(curProgress * 100).toInt()}%',
                style: TextStyle(fontSize: curHeight),
              );
            }
          } else {
            curHeight ??= 24.0;
            if (curStatus != STProgressStatus.primary) {
              curIndicatorWidget =
                  iconFromProgressStatus(curStatus, curHeight, true);
              curIsTextIndicator = false;
            } else {
              curIndicatorWidget ??= Text(
                '${(curProgress * 100).toInt()}%',
                style: TextStyle(color: Colors.white, fontSize: curHeight - 4),
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
            widgetIndicator: curIndicatorWidget,
            isTextIndicator: curIsTextIndicator,
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
          if (curStatus != STProgressStatus.primary) {
            curTrailingWidget =
                iconFromProgressStatus(curStatus, curHeight, false);
          } else {
            curTrailingWidget ??= Text(
              '${(curProgress * 100).toInt()}%',
              style: TextStyle(fontSize: curHeight),
            );
          }
          content = STStepProgress(
            width: widget.size,
            height: curHeight,
            count: widget.stepCount,
            progress: curProgress,
            progressColor: curProgressColor,
            isCircle: widget.type == STProgressType.stepDot,
            trailingWidget: curTrailingWidget,
          );
        }
        break;
      case STProgressType.circle:
      case STProgressType.dashboard:
        {
          curHeight ??= 8.0;
          Widget curCenterWidget = widget.centerWidget;

          if (widget.type == STProgressType.circle) {
            if (curStatus != STProgressStatus.primary) {
              curCenterWidget =
                  iconFromProgressStatus(curStatus, widget.size / 4, false);
            } else {
              curCenterWidget ??= Text(
                '${(curProgress * 100).toInt()}%',
                style: TextStyle(fontSize: curHeight * 2.0),
              );
            }
          } else {
            String centerText = "";
            switch (curStatus) {
              case STProgressStatus.done:
                {
                  centerText = "Done";
                }
                break;
              case STProgressStatus.warning:
                {
                  centerText = "Warning";
                }
                break;
              case STProgressStatus.error:
                {
                  centerText = "Error";
                }
                break;
              default:
                centerText = "";
            }
            if (curStatus != STProgressStatus.primary) {
              curCenterWidget = Text(
                centerText,
                style: TextStyle(
                    fontSize: curHeight * 2.0, color: curProgressColor),
              );
            }
          }

          content = CircularPercentIndicator(
              diameter: widget.size,
              lineWidth: curHeight,
              animation: true,
              percent: curProgress,
              center: curCenterWidget,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: curProgressColor,
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
      case STProgressStatus.primary:
        return STProgressConstant.colorPrimary;
      default:
        return Colors.transparent;
    }
  }

  Widget iconFromProgressStatus(
      STProgressStatus status, double iconWidth, bool isOutline) {
    IconData iconData;
    final Color iconColor =
        isOutline ? Colors.white : colorFromProgressStatus(status);
    switch (status) {
      case STProgressStatus.error:
        iconData = isOutline ? Icons.cancel_sharp : Icons.cancel;
        break;
      case STProgressStatus.warning:
        iconData = isOutline ? Icons.info_outline : Icons.info;
        break;
      case STProgressStatus.done:
        iconData = isOutline ? Icons.check_circle_outline : Icons.check_circle;
        break;
      default:
        iconData = isOutline ? Icons.info_outline : Icons.info;
    }
    return Icon(
      iconData,
      size: iconWidth,
      color: iconColor,
    );
  }
}
