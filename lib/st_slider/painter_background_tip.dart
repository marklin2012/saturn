import 'dart:ui';

import 'package:flutter/material.dart';

class SliderTipPaint extends StatelessWidget {
  final Color fillColor;
  final Widget child;
  final double size;
  final double arrowSize;

  const SliderTipPaint(
      {Key key,
      this.fillColor,
      this.child,
      this.size = 36.0,
      this.arrowSize = 4.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: BGTipPainter(
        fillColor: fillColor,
        customSize: size,
        arrowSize: arrowSize,
      ),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class BGTipPainter extends CustomPainter {
  final Color fillColor;
  final double customSize;
  final double arrowSize;

  const BGTipPainter(
      {this.arrowSize = 4.0, this.customSize = 36.0, this.fillColor});

  Paint _initPaint() {
    return Paint()
      ..color = fillColor ?? const Color(0xFF095BF9)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = _initPaint();
    final _path = Path();

    _path.addRRect(RRect.fromLTRBR(
        0, 0, customSize, customSize - arrowSize, Radius.circular(arrowSize)));
    _path.moveTo(customSize / 2 - arrowSize * 2, customSize - arrowSize);
    _path.lineTo(customSize / 2, customSize);
    _path.lineTo(customSize / 2 + arrowSize * 2, customSize - arrowSize);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
