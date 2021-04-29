import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saturn/st_progress/percent_indicator/circular_percent_indicator.dart';

import 'common.dart';

class STStepProgress extends StatefulWidget {
  final double width;
  final double height;
  final int count;
  final double progress;
  final Color progressColor;
  final bool isCircle;

  const STStepProgress(
      {this.width,
      this.height,
      this.count,
      this.progress,
      this.progressColor,
      this.isCircle = false});

  @override
  _STStepProgressState createState() => _STStepProgressState();
}

class _STStepProgressState extends State<STStepProgress> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.width, widget.height),
        painter: STStepProgressPainter(
          width: widget.width,
          height: widget.height,
          count: widget.count,
          progress: widget.progress,
          progressColor: widget.progressColor,
          isCircle: widget.isCircle,
        ));
  }
}

/// StepProgressPainter
class STStepProgressPainter extends CustomPainter {
  final double width;
  final double height;
  final int count;
  final double progress;
  final Color progressColor;
  final bool isCircle;

  const STStepProgressPainter(
      {this.width,
      this.height,
      this.count,
      this.progress,
      this.progressColor,
      this.isCircle});

  @override
  void paint(Canvas canvas, Size size) {
    final double itemTotalWidth =
        width - (count - 1) * STProgressConstant.defaultSpace;
    final double itemWidth = itemTotalWidth / count;
    final double progressWidth = progress * itemTotalWidth;
    final int progressCount = (progressWidth / itemWidth * 1.0).truncate();
    final double progressMoreWidth = progressWidth - progressCount * itemWidth;
    int noProgressCount = 0;
    double noProgressMoreWidth = 0;
    if (progressMoreWidth == 0) {
      noProgressCount = count - progressCount;
      noProgressMoreWidth = 0;
    } else {
      noProgressCount = count - progressCount - 1;
      noProgressMoreWidth = itemWidth - progressMoreWidth;
    }

    double radius = 0;
    if (isCircle) {
      radius = itemWidth / 2.0;
    }

    double beginX = 0;
    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter
      ..isAntiAlias = true;

    final Paint noProgressPaint = Paint()
      ..color = STProgressConstant.defaultBackgroundColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter
      ..isAntiAlias = true;

    const Radius cornerRadius = Radius.circular(2.0);

    for (int i = 0; i < progressCount; i++) {
      if (isCircle) {
        canvas.drawCircle(
            Offset(beginX + radius, height / 2.0), radius, progressPaint);
        beginX += itemWidth + STProgressConstant.defaultSpace;
      } else {
        final double endX = beginX + itemWidth;
        final Offset beginPoint = Offset(beginX, 0);
        final Offset endPoint = Offset(endX, height);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromPoints(beginPoint, endPoint), cornerRadius),
            progressPaint);
        beginX = endX + STProgressConstant.defaultSpace;
      }
    }
    if (progressMoreWidth != 0) {
      if (isCircle) {
        double progressMoreCos;
        progressMoreCos = (progressMoreWidth - radius).abs() / radius;
        final double progressMoreCosDegree = acos(progressMoreCos) * 180 / 3.14;
        double progressDegree;
        double startDegree;
        double noProgressDegree;

        if (progressMoreWidth > itemWidth / 2) {
          progressDegree = 360 - progressMoreCosDegree * 2;
          noProgressDegree = progressMoreCosDegree * 2;
          startDegree = progressMoreCosDegree;
        } else {
          noProgressDegree = 360 - progressMoreCosDegree * 2;
          progressDegree = progressMoreCosDegree * 2;
          startDegree = 180 - progressMoreCosDegree;
        }

        final Path progressPath = Path()
          ..arcTo(
              Rect.fromCircle(
                  center: Offset(beginX + radius, height / 2.0),
                  radius: radius),
              radians(startDegree),
              radians(progressDegree),
              false);
        canvas.drawPath(progressPath, progressPaint);
        final Path noProgressPath = Path()
          ..arcTo(
              Rect.fromCircle(
                  center: Offset(beginX + radius, height / 2.0),
                  radius: radius),
              radians(startDegree + progressDegree),
              radians(noProgressDegree),
              false);
        canvas.drawPath(noProgressPath, noProgressPaint);

        beginX = beginX + itemWidth + STProgressConstant.defaultSpace;
      } else {
        Offset beginPoint = Offset(beginX, 0);
        double endX = beginX + progressMoreWidth;
        Offset endPoint = Offset(endX, height);
        canvas.drawRRect(
            RRect.fromRectAndCorners(Rect.fromPoints(beginPoint, endPoint),
                topLeft: cornerRadius, bottomLeft: cornerRadius),
            progressPaint);
        beginX = endX;
        endX = beginX + noProgressMoreWidth;
        beginPoint = Offset(beginX, 0);
        endPoint = Offset(endX, height);
        canvas.drawRRect(
            RRect.fromRectAndCorners(Rect.fromPoints(beginPoint, endPoint),
                topRight: cornerRadius, bottomRight: cornerRadius),
            noProgressPaint);
        beginX = endX + STProgressConstant.defaultSpace;
      }
    }

    for (int i = 0; i < noProgressCount; i++) {
      if (isCircle) {
        canvas.drawCircle(
            Offset(beginX + radius, height / 2.0), radius, noProgressPaint);
        beginX += itemWidth + STProgressConstant.defaultSpace;
      } else {
        final double endX = beginX + itemWidth;
        final Offset beginPoint = Offset(beginX, 0);
        final Offset endPoint = Offset(endX, height);
        canvas.drawRRect(
            RRect.fromRectAndRadius(Rect.fromPoints(beginPoint, endPoint),
                const Radius.circular(2.0)),
            noProgressPaint);
        beginX = endX + STProgressConstant.defaultSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
