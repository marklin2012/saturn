import 'package:flutter/material.dart';
import 'package:saturn/st_select/st_select.dart';

class STDatePicker extends StatefulWidget {
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
  _STDatePickerState createState() => _STDatePickerState();
}

class _STDatePickerState extends State<STDatePicker> {
  List<String> _initValue;
  List<List<String>> _listValues;
  int _minimunYear;
  int _maximunYear;

  @override
  void initState() {
    super.initState();
    _initOriginValues();
  }

  @override
  Widget build(BuildContext context) {
    return STSelect(
      types: STSelectTypes.texts,
      title: '选择日期',
      initUnits: const ['年', '月', '日'],
      initTextsValue: _initValue,
      textsListValues: _listValues,
      onChangedTextsValue: (value) {
        _durationTransfromValue(value);
      },
      onUpdagedTextsValue: (value) {
        _updateListValues(value);
      },
      child: widget.child,
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
    if (widget.onDateTimeChanged != null) {
      widget.onDateTimeChanged(_selectedDur);
    }
  }

  void _initOriginValues() {
    _getInitValue();
    _initListValues();
  }

  void _getInitValue() {
    _minimunYear = widget.minimumYear ?? DateTime.now().year - 10;
    _maximunYear = widget.maximunYear ?? DateTime.now().year + 9;
    int _year = 0;
    int _month = 0;
    int _day = 0;
    if (widget.initDateTime != null) {
      _year = widget.initDateTime.year;
      _month = widget.initDateTime.month;
      _day = widget.initDateTime.day;
    }
    _initValue = ['$_year', '$_month', '$_day'];
  }

  void _initListValues() {
    _listValues = [
      List.generate(
              _maximunYear - _minimunYear, (index) => '${index + _minimunYear}')
          .toList(),
      List.generate(12, (index) => '${index + 1}').toList(),
      List.generate(31, (index) => '${index + 1}').toList(),
    ];
  }

  void _updateListValues(List<String> value) {
    final _year = int.parse(value[0]);
    final _month = int.parse(value[1]);
    final _days = _lastDayInMonth(_year, _month).day;
    _listValues[2] = List.generate(_days, (index) => '${index + 1}').toList();
  }

  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);
}
