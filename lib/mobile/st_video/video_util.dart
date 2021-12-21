import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';

class STVideoConst {
  static const videoHeroTag = 'STVideoPlayer';
}

Widget getVolumeIcon(
    double? value, Axis axis, Color iconColor, double iconSize) {
  IconData _data;
  if (value == 0) {
    _data = axis == Axis.vertical
        ? STIcons.commonly_videosound
        : STIcons.commonly_videomute;
  } else if (value == 1) {
    _data = axis == Axis.vertical
        ? STIcons.commonly_videomute
        : STIcons.commonly_videosound;
  } else if (value! < 0.5) {
    _data = axis == Axis.vertical
        ? STIcons.commonly_videosound2
        : STIcons.commonly_videosound1;
  } else {
    _data = axis == Axis.vertical
        ? STIcons.commonly_videosound1
        : STIcons.commonly_videosound2;
  }
  return Icon(_data, size: iconSize, color: iconColor);
}

String getTimeString(Duration total, Duration current) {
  final _totalStr = getTimeFromDuration(total);
  final _currentStr = getTimeFromDuration(current);
  return '$_currentStr/$_totalStr';
}

double getProgressValue(Duration total, Duration current) {
  final _totalSeconds = total.inSeconds;
  final _currentSeconds = current.inSeconds;
  if (_currentSeconds == 0 || _totalSeconds == 0) {
    return 0;
  }
  final value = (_currentSeconds / _totalSeconds).toDouble();
  return value;
}

String getTimeFromDuration(Duration duration) {
  final _hours = duration.inHours;
  final _minutes = duration.inMinutes % 60;
  final _seconds = duration.inSeconds % 60;
  final _minutesStr = _minutes < 10 ? '0$_minutes' : '$_minutes';
  final _secondsStr = _seconds < 10 ? '0$_seconds' : '$_seconds';
  if (_hours != 0) {
    return '$_hours:$_minutesStr:$_secondsStr';
  } else {
    return '$_minutesStr:$_secondsStr';
  }
}
