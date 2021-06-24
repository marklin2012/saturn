import 'package:flutter/material.dart';
import 'package:saturn/st_picker/st_calendar_picker.dart';
import 'package:saturn/st_picker/st_date_picker.dart';
import 'package:saturn/st_picker/st_time_picker.dart';

enum STPickerType {
  calendar, //选择日历日期
  date, // 选择日期
  time, // 选择时间
}

class STPicker extends StatefulWidget {
  const STPicker({
    Key key,
    this.type = STPickerType.calendar,
    this.onRangeDateTimeChanged,
    this.initDateTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear,
    this.maximunYear,
    this.onDateTimeChanged,
    this.child,
    this.onTimerDurationChanged,
    this.initDuration,
    this.isRange = false,
    this.offsetVertical,
    this.marign,
  }) : super(key: key);
  // 公共参数
  final STPickerType type; // 不同的类型
  final DateTime initDateTime; // 初始日期
  final DateTime minimumDate; // 最小可选择的日期
  final DateTime maximumDate; // 最大可选择日期
  // calendarPicker 参数
  final bool isRange; //是否可以选择范围值
  final double offsetVertical; //垂直方向偏移量
  final EdgeInsets marign; //与外部的间隙
  final ValueChanged<List<DateTime>> onRangeDateTimeChanged; //返回选中的日期list
  // date、time模式下触发组件
  final Widget child;
  // datePicker 参数
  final int minimumYear; // 最小显示的年份
  final int maximunYear; // 最大显示的年份
  final ValueChanged<DateTime> onDateTimeChanged; // 选中的日期回调
  // timePicker 参数
  final Duration initDuration; // 初始时间
  final ValueChanged<Duration> onTimerDurationChanged; // 选中的时间回调

  const STPicker.date(
      {Key key,
      @required this.child,
      this.type = STPickerType.date,
      this.minimumYear = 1979,
      this.maximunYear = 2021,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.onDateTimeChanged,
      // 以下可忽略
      this.onTimerDurationChanged,
      this.initDuration,
      this.isRange,
      this.offsetVertical,
      this.marign,
      this.onRangeDateTimeChanged})
      : super(key: key);

  const STPicker.time(
      {Key key,
      this.type = STPickerType.time,
      @required this.child,
      this.onTimerDurationChanged,
      this.initDuration,
      // 以下可忽略
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.isRange,
      this.offsetVertical,
      this.marign,
      this.onRangeDateTimeChanged})
      : super(key: key);

  @override
  _STPickerState createState() => _STPickerState();
}

class _STPickerState extends State<STPicker> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case STPickerType.date:
        return STDatePicker(
          key: widget.key,
          initDateTime: widget.initDateTime,
          minimumDate: widget.minimumDate,
          maximumDate: widget.maximumDate,
          minimumYear: widget.minimumYear,
          maximunYear: widget.maximunYear,
          onDateTimeChanged: widget.onDateTimeChanged,
          child: widget.child,
        );
      case STPickerType.time:
        return STTimePicker(
          key: widget.key,
          initDuration: widget.initDuration,
          onTimerDurationChanged: widget.onTimerDurationChanged,
          child: widget.child,
        );
      default:
        return STCalendarPicker(
          isRange: widget.isRange,
          marign: widget.marign,
          offsetVertical: widget.offsetVertical,
          onChanged: widget.onRangeDateTimeChanged,
          initialDate: widget.initDateTime,
          firstDate: widget.minimumDate,
          lastDate: widget.maximumDate,
        );
    }
  }
}
