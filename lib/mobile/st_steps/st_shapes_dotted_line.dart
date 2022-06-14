import 'package:flutter/material.dart';

class STShapesDottedLine extends StatelessWidget {
  const STShapesDottedLine({
    Key? key,
    this.color,
    this.margin,
    this.padding,
    this.height = 2.0,
    this.width = 20.0,
    this.direction = Axis.horizontal,
    this.dotted = 4.0,
  }) : super(key: key);

  final Color? color;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final double height;

  final double width;

  final Axis direction;

  final double dotted;

  bool get isHorizontal => direction == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    int _total;
    if (isHorizontal) {
      _total = (width / dotted / 2).floor();
    } else {
      _total = (height / dotted / 2).floor();
    }

    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _total,
          (index) => SizedBox(
            width: isHorizontal ? dotted : 2,
            height: isHorizontal ? 2 : dotted,
            child: DecoratedBox(decoration: BoxDecoration(color: color)),
          ),
        ),
      ),
    );
  }
}
