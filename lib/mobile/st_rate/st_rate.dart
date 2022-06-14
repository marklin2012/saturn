import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class STRate extends StatelessWidget {
  const STRate({
    Key? key,
    this.rate = 0,
    this.total = 5,
    this.iconData = STIcons.label_star,
    this.bottomIconData = STIcons.label_star_outline,
    this.margin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.padding = EdgeInsets.zero,
    this.iconSize = 24.0,
    this.disabled = false,
    this.onRateTap,
  }) : super(key: key);

  final double rate;

  final int total;

  final IconData iconData;

  final IconData bottomIconData;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final double iconSize;

  final bool disabled;

  final Function(int)? onRateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildStars(),
      ),
    );
  }

  List<Widget> _buildStars() {
    final _list = <Widget>[];
    for (int i = 0; i < total; i++) {
      double _current = rate - i;
      if (_current >= 1) {
        _current = 1.0;
      } else if (_current < 0) {
        _current = 0;
      }
      final _tempW = GestureDetector(
        onTap: () {
          if (disabled) return;
          if (onRateTap == null) return;
          onRateTap!(i + 1);
        },
        child: Stack(
          children: [
            Icon(
              bottomIconData,
              size: iconSize,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: _current,
                child: Icon(
                  iconData,
                  size: iconSize,
                  color: STColor.thrRankBlue,
                ),
              ),
            ),
          ],
        ),
      );
      _list.add(_tempW);
    }

    return _list;
  }
}
