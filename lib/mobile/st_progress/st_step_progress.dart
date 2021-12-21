import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'common.dart';

class STStepProgreessClipper extends CustomClipper<Rect> {
  final double? width;
  final double? height;

  STStepProgreessClipper({this.width, this.height});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(width!, height!, 0, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class STStepProgress extends StatefulWidget {
  final double? width;
  final double? height;
  final int? count;
  final double? progress;
  final Color? progressColor;
  final bool isCircle;
  final Widget? trailingWidget;

  const STStepProgress(
      {this.width,
      this.height,
      this.count,
      this.progress,
      this.progressColor,
      this.isCircle = false,
      this.trailingWidget});

  @override
  _STStepProgressState createState() => _STStepProgressState();
}

class _STStepProgressState extends State<STStepProgress> {
  @override
  Widget build(BuildContext context) {
    double itemTotalWidth =
        widget.width! - (widget.count! - 1) * STProgressConstant.defaultSpace;
    double itemWidth = itemTotalWidth / widget.count!;
    if (widget.height! < itemWidth) {
      itemWidth = widget.height!;
    }
    itemTotalWidth = itemWidth * widget.count! +
        (widget.count! - 1) * STProgressConstant.defaultSpace;
    final double progressWidthNoSpace =
        widget.progress! * itemWidth * widget.count!;
    final int progressCount =
        (progressWidthNoSpace / itemWidth * 1.0).truncate();
    final double progressWidth =
        progressCount * STProgressConstant.defaultSpace + progressWidthNoSpace;

    return Stack(
      children: [
        CustomPaint(
            size: Size(widget.width!, widget.height!),
            painter: STStepProgressPainter(
              itemWidth: itemWidth,
              height: widget.height,
              count: widget.count,
              color: STProgressConstant.defaultBackgroundColor,
              isCircle: widget.isCircle,
            )),
        ClipRect(
          clipper: STStepProgreessClipper(
              width: progressWidth, height: widget.height),
          child: CustomPaint(
            painter: STStepProgressPainter(
              itemWidth: itemWidth,
              height: widget.height,
              count: widget.count,
              color: widget.progressColor,
              isCircle: widget.isCircle,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: itemTotalWidth + 5),
            child: widget.trailingWidget)
      ],
    );
  }
}

/// StepProgressPainter
class STStepProgressPainter extends CustomPainter {
  final int? count;
  final double? itemWidth;
  final double? height;
  final Color? color;
  final bool? isCircle;

  const STStepProgressPainter(
      {this.count, this.itemWidth, this.height, this.color, this.isCircle});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 0;
    if (isCircle!) {
      radius = itemWidth! / 2.0;
    }

    double beginX = 0;
    final Paint progressPaint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter
      ..isAntiAlias = true;

    const Radius cornerRadius = Radius.circular(2.0);

    for (int i = 0; i < count!; i++) {
      if (isCircle!) {
        canvas.drawCircle(
            Offset(beginX + radius, height! / 2.0), radius, progressPaint);
        beginX += itemWidth! + STProgressConstant.defaultSpace;
      } else {
        final double endX = beginX + itemWidth!;
        final Offset beginPoint = Offset(beginX, 0);
        final Offset endPoint = Offset(endX, height!);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromPoints(beginPoint, endPoint), cornerRadius),
            progressPaint);
        beginX = endX + STProgressConstant.defaultSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
