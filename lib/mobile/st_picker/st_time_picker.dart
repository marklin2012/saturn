import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_select/select_texts.dart';

class STTimePicker extends StatelessWidget {
  const STTimePicker({
    Key key,
    @required this.child,
    this.onTimerDurationChanged,
    this.initDuration,
  })  : assert(child != null),
        super(key: key);

  final Duration initDuration; // 初始化时间
  final ValueChanged<Duration> onTimerDurationChanged; // 选中后的时间回调
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return STSelectTexts(
      title: '选择时间',
      initUnits: const ['小时', '分钟', '秒'],
      initValue: _getInitValue(),
      listValues: _getListValues(),
      onChanged: (value) {
        _durationTransfromValue(value);
      },
      child: child,
    );
  }

  void _durationTransfromValue(List<String> value) {
    int _hours = 0, _minutes = 0, _seconds = 0;
    if (value.isNotEmpty && int.tryParse(value[0]) != null) {
      _hours = int.parse(value[0]);
    }
    if (value.length > 1 && int.tryParse(value[1]) != null) {
      _minutes = int.parse(value[1]);
    }
    if (value.length > 2 && int.tryParse(value[2]) != null) {
      _seconds = int.parse(value[2]);
    }
    if (onTimerDurationChanged != null) {
      onTimerDurationChanged(
        Duration(hours: _hours, minutes: _minutes, seconds: _seconds),
      );
    }
  }

  List<String> _getInitValue() {
    final tempDur = initDuration ?? const Duration();
    final _tempSec = tempDur.inSeconds;
    final _hours = (_tempSec / 3600).floor();
    final _minutes = ((_tempSec % 3600) / 60).floor();
    final _seconds = _tempSec % 60;
    return ['$_hours', '$_minutes', '$_seconds'];
  }

  List<List<String>> _getListValues() {
    return [
      List.generate(24, (index) => '$index').toList(),
      List.generate(60, (index) => '$index').toList(),
      List.generate(60, (index) => '$index').toList(),
    ];
  }
}
