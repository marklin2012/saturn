import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

enum STCarouselIndicatorType {
  rect,
  circle,
  progress,
}

class STCarouselIndicator extends StatelessWidget {
  const STCarouselIndicator({
    Key? key,
    this.totalPage,
    this.currentPage = 0,
    this.type = STCarouselIndicatorType.circle,
    this.axis = Axis.horizontal,
    this.highLightColor = STColor.secRankBlue,
    this.color = STColor.thrRankGrey,
  }) : super(key: key);

  final int? totalPage;

  final int currentPage;

  final STCarouselIndicatorType type;

  final Axis axis;

  final Color highLightColor;

  final Color color;

  @override
  Widget build(BuildContext context) {
    if (totalPage == null || totalPage == 0) return Container();
    final List<Widget> _widgets = [];
    if (type == STCarouselIndicatorType.rect ||
        type == STCarouselIndicatorType.circle) {
      final _padding = axis == Axis.horizontal
          ? const EdgeInsets.only(right: 4.0)
          : const EdgeInsets.only(bottom: 4.0);
      final _height = type == STCarouselIndicatorType.circle ? 8.0 : 4.0;
      final _width = type == STCarouselIndicatorType.circle ? 8.0 : 32.0;
      for (int i = 0; i < totalPage!; i++) {
        Widget _widget;
        final _isHighLight = currentPage == i;
        if (i == totalPage! - 1) {
          _widget = Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _isHighLight ? highLightColor : color,
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        } else {
          _widget = Padding(
            padding: _padding,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _isHighLight ? highLightColor : color,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
        _widgets.add(_widget);
      }
    } else {
      final _progress = (currentPage.toDouble() + 1.0) / totalPage!.toDouble();
      _widgets.add(
        STSlider(
          value: _progress,
          axis: axis,
          mainSize: 140.0,
          activeSize: 4.0,
          activeColor: highLightColor,
          inactiveColor: color,
          dotColor: highLightColor,
          dotSize: 4.0,
        ),
      );
    }

    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: _widgets,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: _widgets,
      );
    }
  }
}
