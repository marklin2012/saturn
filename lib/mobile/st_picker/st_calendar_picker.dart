import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';
import 'package:saturn/mobile/st_picker/st_cursor.dart';
import 'package:saturn/mobile/st_select/select_show_dialog.dart';
import 'package:saturn/utils/include.dart';

enum STCalendarPickerType { start, end }

const _stCalendarInputHeight = 48.0;
const _defaultPlaceHolder = '请选择日期';
const _defaultStartHolder = '开始日期';
const _defaultEndHolder = '结束日期';

const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _defaultLeftPadding = EdgeInsets.only(left: 14.0);
const _defaultRightPadding = EdgeInsets.only(right: 14.0);
const _defaultVerticalOffset = 8.0;
const _defaultCalenderHeight = 322.0;

const _defaultTextStyle = TextStyle(color: Color(0xFFBBBBBB), fontSize: 16.0);
const _selectedTextStyle = TextStyle(color: Color(0xFF000000), fontSize: 16.0);

const _defaultBackgroundColor = Color(0xFFFAFCFF);
const _defaultBorderColor = Color(0xFFC4C5C7);
const _borderHighlightedColor = Color(0xFF095BF9);

class STCalendarPicker extends StatefulWidget {
  const STCalendarPicker({
    Key? key,
    this.isRange = false,
    this.offsetVertical,
    this.marign,
    this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  final bool isRange; //是否可以选择范围值
  final double? offsetVertical; //垂直方向偏移量
  final ValueChanged<List<DateTime>>? onChanged; //选择后的日期回调
  final EdgeInsets? marign; //与外部的间隙
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  _STCalendarPickerState createState() => _STCalendarPickerState();
}

class _STCalendarPickerState extends State<STCalendarPicker> {
  final GlobalKey _touchCalKey =
      GlobalKey(debugLabel: '_touchCalKey'); //触发日历的Key
  late Offset _touchCalPoints;
  late double _offsetVertical;
  EdgeInsets? _margin;
  String? _startHintText;
  String? _endHintText;
  bool _isHighlighted = false; // 是否高亮
  bool _isShowStart = true; // range的时候弹出的picker是开始或者结束
  final List<DateTime> _selectedDateTimes = []..length = 2;

  final DateTime _defaultFirstDateTime = DateTime(2012, 4, 22);
  final DateTime _defaultLastDateTime = DateTime(2032, 4, 22);

  @override
  void initState() {
    super.initState();
    _margin = widget.marign ?? _defaultMargin;
    _offsetVertical = widget.offsetVertical ?? _defaultVerticalOffset;
    _startHintText = _defaultPlaceHolder;

    if (widget.isRange) {
      _startHintText = _defaultStartHolder;
      _endHintText = _defaultEndHolder;
    }

    WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      final RenderBox renderBox =
          _touchCalKey.currentContext!.findRenderObject() as RenderBox;
      _touchCalPoints = renderBox.localToGlobal(Offset.zero);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isHighlighted = true;
        setState(() {});
        _show(_isStartOrEndDatePicker());
      },
      child: Container(
        key: _touchCalKey,
        margin: _margin,
        height: _stCalendarInputHeight,
        decoration: BoxDecoration(
          color: _defaultBackgroundColor,
          border: Border.all(
              color: _isHighlighted
                  ? _borderHighlightedColor
                  : _defaultBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: _defaultLeftPadding,
              child: Row(
                children: [
                  if (_isHighlighted &&
                      _isShowStart &&
                      _isSelectedDateTime(STCalendarPickerType.start) == false)
                    const STCursor(),
                  Text(_startHintText!,
                      style: _isSelectedDateTime(STCalendarPickerType.start)
                          ? _selectedTextStyle
                          : _defaultTextStyle),
                  if (_isHighlighted &&
                      _isShowStart &&
                      _isSelectedDateTime(STCalendarPickerType.start) == true)
                    const STCursor(),
                ],
              ),
            ),
            if (widget.isRange)
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: _defaultMargin.right,
                        left: 2 * _defaultMargin.left),
                    child: const Icon(
                      STIcons.direction_swapright,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      if (_isHighlighted &&
                          _isShowStart == false &&
                          _isSelectedDateTime(STCalendarPickerType.end) ==
                              false)
                        const STCursor(),
                      Text(_endHintText!,
                          style: _isSelectedDateTime(STCalendarPickerType.end)
                              ? _selectedTextStyle
                              : _defaultTextStyle),
                      if (_isHighlighted &&
                          _isShowStart == false &&
                          _isSelectedDateTime(STCalendarPickerType.end) == true)
                        const STCursor(),
                    ],
                  ),
                ],
              ),
            const Padding(
              padding: _defaultRightPadding,
              child: Icon(STIcons.data_calendar_outline,
                  size: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _show(STCalendarPickerType type) {
    var _firstDate = widget.firstDate ?? _defaultFirstDateTime;
    var _initialDate = widget.initialDate ?? DateTime.now();
    if (widget.isRange &&
        type == STCalendarPickerType.end &&
        _selectedDateTimes.first != null) {
      _firstDate = _selectedDateTimes.first;
    }
    // initialDate必须大于firstDate,这里做个特殊处理
    if (_firstDate.isAfter(_initialDate)) {
      _initialDate = _firstDate;
    }
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ShowSelectDialog(
          offset: Offset(
              _touchCalPoints.dx + _margin!.left,
              _touchCalPoints.dy +
                  _offsetVertical +
                  (getIsWeb() ? _stCalendarInputHeight : 0)),
          height: _defaultCalenderHeight,
          menu: Container(
            color: Colors.white,
            child: CalendarDatePicker(
              initialDate: _initialDate,
              firstDate: _firstDate,
              lastDate: widget.lastDate ?? _defaultLastDateTime,
              onDateChanged: (value) {
                _dateChangedOpration(value, type);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ).then((value) {
      _isHighlighted = false;
      if (widget.isRange) _isShowStart = !_isShowStart;
      setState(() {});
    });
  }

  void _dateChangedOpration(DateTime value, STCalendarPickerType type) {
    if (type == STCalendarPickerType.start) {
      _startHintText = value.toString().substring(0, 10);
      _selectedDateTimes[0] = value;
    } else {
      _endHintText = value.toString().substring(0, 10);
      _selectedDateTimes[1] = value;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedDateTimes);
    }
    setState(() {});
  }

  bool _isSelectedDateTime(STCalendarPickerType type) {
    if (type == STCalendarPickerType.start &&
        (_startHintText == _defaultPlaceHolder ||
            _startHintText == _defaultStartHolder)) {
      return false;
    } else if (type == STCalendarPickerType.end &&
        _endHintText == _defaultEndHolder) {
      return false;
    } else {
      return true;
    }
  }

  // picker对应start或者end
  STCalendarPickerType _isStartOrEndDatePicker() {
    if (widget.isRange && _isShowStart == false) {
      return STCalendarPickerType.end;
    }
    return STCalendarPickerType.start;
  }
}
