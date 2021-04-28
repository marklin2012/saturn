import 'package:flutter/material.dart';

import 'common.dart';
import 'percent_indicator/percent_indicator.dart';

class STProgress extends StatefulWidget {
  final STProgressType type;
  final double width;
  final double lineWidth;
  final double radius;
  final double progress;
  final Color color;
  final Widget trailingWidget;
  final Widget centerWidget;
  final bool showInnerProgress;
  final bool isInstrument;

  const STProgress(
      {Key key,
      this.type,
      this.width,
      this.lineWidth,
      this.radius,
      this.progress,
      this.color,
      this.trailingWidget,
      this.centerWidget,
      this.showInnerProgress = false,
      this.isInstrument = false})
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
            lineHeight: widget.lineWidth,
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
                      fontSize: widget.lineWidth - 4,
                    ),
                  )
                : null,
          );
        }
        break;
      case STProgressType.step:
        {}
        break;
      case STProgressType.circular:
        {
          content = CircularPercentIndicator(
              radius: widget.radius,
              lineWidth: widget.lineWidth,
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
