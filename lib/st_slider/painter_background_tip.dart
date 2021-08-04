import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saturn/utils/bounding.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 8.0);
const _defaultHeight = 40.0;

class SliderTipPaint extends StatelessWidget {
  final Color fillColor;
  final Widget child;
  final double arrowSize;
  final String tipStr;
  final TextStyle tipTextStyle;

  const SliderTipPaint(
      {Key key,
      this.fillColor,
      this.child,
      this.tipStr,
      this.tipTextStyle = const TextStyle(color: Colors.white, fontSize: 16.0),
      this.arrowSize = 4.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = _defaultHeight;
    if (tipStr != null) {
      _width = boundingTextSize(context, tipStr, tipTextStyle).width +
          _defaultPadding.left +
          _defaultPadding.right;
    }
    return CustomPaint(
      painter: BGTipPainter(
        fillColor: fillColor,
        arrowSize: arrowSize,
        size: Size(_width, _defaultHeight),
      ),
      child: Container(
        width: _width,
        height: _defaultHeight,
        alignment: Alignment.center,
        // padding: _defaultPadding,
        child: child,
      ),
    );
  }
}

class BGTipPainter extends CustomPainter {
  final Color fillColor;
  final Size size;
  final double arrowSize;

  const BGTipPainter(
      {this.arrowSize = 4.0,
      this.size = const Size(_defaultHeight, _defaultHeight),
      this.fillColor});

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
        0, 0, size.width, size.height - arrowSize, Radius.circular(arrowSize)));
    _path.moveTo(size.width / 2 - arrowSize / 2 * 3, size.height - arrowSize);
    _path.lineTo(size.width / 2, size.height);
    _path.lineTo(size.width / 2 + arrowSize / 2 * 3, size.height - arrowSize);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(BGTipPainter oldDelegate) {
    return oldDelegate.size != size ||
        oldDelegate.arrowSize != arrowSize ||
        oldDelegate.fillColor != fillColor;
  }
}
