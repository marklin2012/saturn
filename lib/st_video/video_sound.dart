import 'package:flutter/material.dart';
import 'package:saturn/st_slider/st_slider.dart';
import 'package:saturn/st_video/video_util.dart';

const _defaultSliderSize = 80.0;
const _defaultSizeboxSize = 8.0;
const _defaultIconSize = 16.0;

class STVideoSound extends StatelessWidget {
  const STVideoSound({
    Key key,
    this.axis = Axis.horizontal,
    this.size = 104,
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
      _height = _defaultIconSize;
      _width = size;
      _child = Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: _defaultSizeboxSize),
            alignment: Alignment.center,
            child: getVolumeIcon(value, axis, iconColor, _defaultIconSize),
          ),
          _getSlider(),
        ],
      );
    } else {
      _width = _defaultIconSize;
      _height = size;
      _child = Column(
        children: [
          _getSlider(),
          Container(
            padding: const EdgeInsets.only(top: _defaultSizeboxSize),
            alignment: Alignment.center,
            child: getVolumeIcon(value, axis, iconColor, _defaultIconSize),
          ),
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
      dotSize: 12,
      activeSize: 4,
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
