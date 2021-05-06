import 'package:flutter/material.dart';
import 'package:saturn/st_icons/st_icons.dart';

class VideoCommon {
  Widget getSoundIcon(
      double value, Axis axis, Color iconColor, double iconSize) {
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
    return Icon(_data, size: iconSize, color: iconColor);
  }
}
