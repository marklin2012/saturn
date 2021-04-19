import 'package:flutter/material.dart';
import 'package:saturn/st_picker/st_date_picker.dart';
import 'package:saturn/st_picker/st_time_picker.dart';

enum STPickerModel {
  calendar, //选择单个日历日期
  calendarRange, // 选择日历范围内日期
  date, // 选择日期
  time, // 选择时间
}

class STPicker extends StatelessWidget {
  const STPicker(
      {Key key,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.model = STPickerModel.calendar,
      this.child,
      this.onTimerDurationChanged,
      this.initDuration})
      : super(key: key);

  final STPickerModel model; // 四种不同的类型
  final DateTime initDateTime; // 初始日期
  final DateTime minimumDate; // 最小可选择的日期
  final DateTime maximumDate; // 最大可选择日期
  final int minimumYear; // 最小显示的年份
  final int maximunYear; // 最大显示的年份
  final Widget child; // date、time模式下触发组件
  final ValueChanged<DateTime> onDateTimeChanged; // 选中的日期回调
  final ValueChanged<Duration> onTimerDurationChanged; // 选中的时间回调
  final Duration initDuration; // 初始时间

  const STPicker.date(
      {Key key,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.onTimerDurationChanged,
      this.model = STPickerModel.date,
      this.child,
      this.initDuration})
      : super(key: key);

  const STPicker.time(
      {Key key,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.onTimerDurationChanged,
      this.model = STPickerModel.time,
      this.child,
      this.initDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (model) {
      case STPickerModel.date:
        return STDatePicker(
          key: key,
          initDateTime: initDateTime,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          minimumYear: minimumYear,
          maximunYear: maximunYear,
          onDateTimeChanged: onDateTimeChanged,
          child: child,
        );
      case STPickerModel.calendar:
        break;
      case STPickerModel.calendarRange:
        break;
      case STPickerModel.time:
        return STTimePicker(
          key: key,
          initDuration: initDuration,
          onTimerDurationChanged: onTimerDurationChanged,
          child: child,
        );
    }
    return Container();
  }
}
