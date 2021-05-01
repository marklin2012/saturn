import 'package:flutter/material.dart';
import 'package:saturn/st_slider/st_slider.dart';
import 'package:saturn/st_video/video_common.dart';

const _defaultSliderSize = 80.0;
const _defaultSizeboxSize = 12.0;
const _defaultIconWidth = 18.0;

class STVideoSound extends StatelessWidget {
  const STVideoSound({
    Key key,
    this.axis = Axis.horizontal,
    this.size = 110,
    this.activeColor = const Color(0xFF095BF9),
    this.inactiveColor = const Color(0xFFDCE8FF),
    this.iconColor = const Color(0xFF000000),
    this.value = 0,
    this.onChanged,
  }) : super(key: key);

  final Axis axis; //方向
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Color iconColor;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    double _height;
    double _width;
    Widget _child;
    if (axis == Axis.horizontal) {
      _height = _defaultIconWidth;
      _width = size;
      _child = Row(
        children: [
          VideoCommon().getSoundIcon(value, axis, iconColor),
          const SizedBox(width: _defaultSizeboxSize),
          _getSlider(),
        ],
      );
    } else {
      _width = _defaultIconWidth;
      _height = size;
      _child = Column(
        children: [
          _getSlider(),
          const SizedBox(height: _defaultSizeboxSize),
          VideoCommon().getSoundIcon(value, axis, iconColor),
        ],
      );
    }
    return Container(
      height: _height,
      width: _width,
      alignment: Alignment.center,
      child: _child,
    );
  }

  Widget _getSlider() {
    Color _activeColor = activeColor;
    Color _inactiveColor = inactiveColor;
    if (axis == Axis.vertical) {
      _activeColor = inactiveColor;
      _inactiveColor = activeColor;
    }
    return STSlider(
      axis: axis,
      mainSize: _defaultSliderSize,
      value: value,
      showTip: false,
      activeColor: _activeColor,
      inactiveColor: _inactiveColor,
      onChanged: (double value) {
        if (onChanged != null) {
          onChanged(value);
        }
      },
    );
  }
}
