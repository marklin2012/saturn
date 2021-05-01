import 'package:flutter/material.dart';
import 'package:saturn/st_icons/st_icons.dart';

const _defaultIconWidth = 18.0;

class VideoCommon {
  Widget getSoundIcon(double value, Axis axis, Color iconColor) {
    IconData _data;
    if (value == 0) {
      _data = axis == Axis.vertical
          ? STIcons.commonly_videosound
          : STIcons.commonly_videomute;
    } else if (value == 1) {
      _data = axis == Axis.vertical
          ? STIcons.commonly_videomute
          : STIcons.commonly_videosound;
    } else if (value < 0.5) {
      _data = axis == Axis.vertical
          ? STIcons.commonly_videosound_half
          : STIcons.commonly_videosound_small;
    } else {
      _data = axis == Axis.vertical
          ? STIcons.commonly_videosound_small
          : STIcons.commonly_videosound_half;
    }
    return Container(
      alignment: Alignment.center,
      height: _defaultIconWidth,
      child: Icon(_data, size: _defaultIconWidth, color: iconColor),
    );
  }
}
