import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/st_button.dart';
import 'package:saturn/mobile/st_slider/st_slider.dart';
import 'package:saturn/mobile/st_video/video_util.dart';

const _defaultSliderSize = 80.0;
const _defaultIconSize = 16.0;

class STVideoSound extends StatelessWidget {
  const STVideoSound({
    Key key,
    this.axis = Axis.horizontal,
    this.size = 102,
    this.activeColor = const Color(0xFF095BF9),
    this.inactiveColor = const Color(0xFFDCE8FF),
    this.iconColor = const Color(0xFF000000),
    this.value = 0,
    this.onChanged,
    this.showVolumed,
  }) : super(key: key);

  final Axis axis; //方向
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Color iconColor;
  final double value;
  final ValueChanged<double> onChanged;
  final Function showVolumed;

  @override
  Widget build(BuildContext context) {
    Widget _child;
    double _height;
    double _width;
    if (axis == Axis.horizontal) {
      _height = _defaultIconSize;
      _width = size;
      _child = Row(
        children: [
          STButton.icon(
            icon: getVolumeIcon(value, axis, iconColor, _defaultIconSize),
            backgroundColor: Colors.transparent,
            size: STButtonSize.small,
            padding: const EdgeInsets.only(right: 6.0),
            onTap: () {
              if (showVolumed != null) {
                showVolumed();
              }
            },
          ),
          _getSlider(),
        ],
      );
    } else {
      _height = size;
      _width = _defaultIconSize;
      _child = Column(
        children: [
          _getSlider(),
          STButton.icon(
            icon: getVolumeIcon(value, axis, iconColor, _defaultIconSize),
            backgroundColor: Colors.transparent,
            size: STButtonSize.small,
            padding: const EdgeInsets.only(top: 6.0),
            onTap: () {
              if (showVolumed != null) {
                showVolumed();
              }
            },
          )
        ],
      );
    }
    return SizedBox(
      height: _height,
      width: _width,
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
