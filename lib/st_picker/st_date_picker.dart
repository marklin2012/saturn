import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_texts.dart';

class STDatePicker extends StatelessWidget {
  const STDatePicker(
      {Key key,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.child})
      : super(key: key);

  final DateTime initDateTime; // 初始日期
  final DateTime minimumDate; // 最小可选择的日期
  final DateTime maximumDate; // 最大可选择日期
  final int minimumYear; // 最小显示的年份
  final int maximunYear; // 最大显示的年份
  final ValueChanged<DateTime> onDateTimeChanged; // 选中的日期回调
  final Widget child; //触发的组件

  @override
  Widget build(BuildContext context) {
    return STSelectTexts(
      title: '选择日期',
      initUnits: const ['年', '月', '日'],
      initValue: _getInitValue(),
      listValues: _getListValues(),
      onChanged: (value) {
        _durationTransfromValue(value);
      },
      calculateDays: true,
      child: child,
    );
  }

  void _durationTransfromValue(List<String> value) {
    if (value == null) return;
    int _year = 0;
    if (value.isNotEmpty && int.tryParse(value[0]) != null) {
      _year = int.parse(value[0]);
    }
    int _month = 0;
    if (value.length > 1 && int.tryParse(value[1]) != null) {
      _month = int.parse(value[1]);
    }
    int _day = 0;
    if (value.length > 2 && int.tryParse(value[2]) != null) {
      _day = int.parse(value[2]);
    }
    final _selectedDur = DateTime(_year, _month, _day);
    if (onDateTimeChanged != null) {
      onDateTimeChanged(_selectedDur);
    }
  }

  List<String> _getInitValue() {
    final _initDateTime = initDateTime ?? DateTime.now();
    final _year = _initDateTime.year;
    final _month = _initDateTime.month;
    final _day = _initDateTime.day;
    return ['$_year', '$_month', '$_day'];
  }

  List<List<String>> _getListValues() {
    final _minimunYear = minimumYear ?? DateTime.now().year - 10;
    final _maximunYear = maximunYear ?? DateTime.now().year + 9;
    final _initValue = _getInitValue();
    return [
      List.generate(
              _maximunYear - _minimunYear, (index) => '${index + _minimunYear}')
          .toList(),
      List.generate(12, (index) => '${index + 1}').toList(),
      List.generate(_updateListValues(_initValue), (index) => '${index + 1}')
          .toList(),
    ];
  }

  int _updateListValues(List<String> value) {
    final _year = int.parse(value[0]);
    final _month = int.parse(value[1]);
    final _days = _lastDayInMonth(_year, _month).day;
    return _days;
  }

  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);
}
