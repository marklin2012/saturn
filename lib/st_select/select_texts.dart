import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_show_dialog.dart';

class STSelectTextsConst {
  static const _selectTextsHeight = 302.0;
  static const _selectTitleHeight = 48.0;
  static const _pickerItemExtent = 44.0;
  static const _textStyle = TextStyle(color: Color(0xFF555555), fontSize: 16);
  static const _unitTextStyle =
      TextStyle(color: Color(0xFF000000), fontSize: 16);
  static const _magnification = 1.1;
}

class STSelectTexts extends StatelessWidget {
  const STSelectTexts({
    Key key,
    this.child,
    this.title,
    this.initValue,
    this.listValues,
    this.onChanged,
    this.initUnits,
    this.calculateDays = false,
  }) : super(key: key);

  final Widget child; // 供外部触发的组件
  final String title; // 标题
  final List<String> initValue; // 初始默认值
  final List<List<String>> listValues; // 数据集合
  final Function(List<String> value) onChanged; // 点击确定后的回调
  final List<String> initUnits;
  final bool calculateDays;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return ShowSelectDialog(
              menu: STSelectMenu(
                title: title,
                initValue: initValue,
                listValues: listValues,
                onChanged: onChanged,
                initUnits: initUnits,
                calculateDays: calculateDays,
              ),
              offset:
                  Offset(0, _height - STSelectTextsConst._selectTextsHeight),
              height: STSelectTextsConst._selectTextsHeight,
            );
          },
        );
      },
      child: child,
    );
  }
}

class STSelectMenu extends StatefulWidget {
  const STSelectMenu({
    Key key,
    this.title,
    this.initValue,
    this.listValues,
    this.onChanged,
    this.initUnits,
    this.calculateDays,
  }) : super(key: key);

  final String title; // 标题
  final List<String> initValue; // 初始默认值
  final List<List<String>> listValues; // 数据集合
  final Function(List<String> value) onChanged; // 点击确定后的回调
  final List<String> initUnits;
  final bool calculateDays; // 是否需要计算天数

  @override
  _STSelectMenuState createState() => _STSelectMenuState();
}

class _STSelectMenuState extends State<STSelectMenu> {
  List<String> _selectedValues;
  double _width;
  int _columnNumber = 1;
  List<String> _columnOneList;
  List<String> _columnTwoList;
  List<String> _columnThrList;

  void _buildupLists() {
    _selectedValues ??= widget.initValue ?? ['', '', ''];
    for (int i = 0; i < widget.listValues.length; i++) {
      _columnNumber = i + 1;
      if (i == 0) {
        _columnOneList = widget.listValues[i];
      } else if (i == 1) {
        _columnTwoList = widget.listValues[i];
      } else if (i == 2) {
        _columnThrList ??= widget.listValues[i];
        break; //只取前3,其余的忽略
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildupLists();
    _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          _getTitleChild(context),
          Row(
            children:
                List.generate(_columnNumber, (index) => _getPickerView(index))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _getPickerView(int number) {
    var _titles = <String>[];
    String _initialTitle;
    String _initUnit;
    if (number == 0) {
      _titles = _columnOneList;
    } else if (number == 1) {
      _titles = _columnTwoList;
    } else if (number == 2) {
      _titles = _columnThrList;
    }
    if (widget.initValue != null && widget.initValue.length > number) {
      _initialTitle = widget.initValue[number];
    }
    if (widget.initUnits != null && widget.initUnits.length > number) {
      _initUnit = widget.initUnits[number];
    }
    if (_titles.isEmpty) return null;
    int _initItem = 0;
    for (int i = 0; i < _titles.length; i++) {
      if (_initialTitle == _titles[i]) {
        _initItem = i;
        break;
      }
    }
    final _unitWidth = _initUnit != null ? 40.0 : 0.0;
    return Container(
      width: _width / _columnNumber,
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          SizedBox(
            height: STSelectTextsConst._selectTextsHeight -
                STSelectTextsConst._selectTitleHeight,
            width: _width / _columnNumber - _unitWidth,
            child: CupertinoPicker(
              itemExtent: STSelectTextsConst._pickerItemExtent,
              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                capLeftEdge: false,
                capRightEdge: false,
              ),
              scrollController: FixedExtentScrollController(
                initialItem: _initItem,
              ),
              useMagnifier: true,
              magnification: STSelectTextsConst._magnification,
              onSelectedItemChanged: (int index) {
                _selectedValues[number] = _titles[index];
                if (number != 2) {
                  _caculateDaysFromYearAndMonth();
                }
              },
              children: List.generate(_titles.length, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: STSelectTextsConst._pickerItemExtent,
                  alignment: _initUnit != null
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: Text(
                    _titles[index],
                    style: STSelectTextsConst._textStyle,
                  ),
                );
              }).toList(),
            ),
          ),
          if (_initUnit != null)
            Container(
              width: _unitWidth,
              height: STSelectTextsConst._pickerItemExtent *
                  STSelectTextsConst._magnification,
              alignment: Alignment.centerLeft,
              color: CupertinoColors.tertiarySystemFill,
              child: Text(
                _initUnit,
                style: STSelectTextsConst._unitTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _getTitleChild(BuildContext context) {
    return SizedBox(
      height: STSelectTextsConst._selectTitleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '取消',
              style: TextStyle(color: Color(0xFF888888), fontSize: 17.0),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(color: Color(0xFF000000), fontSize: 18),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onChanged(_selectedValues);
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFF000000), fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }

  void _caculateDaysFromYearAndMonth() {
    if (!widget.calculateDays) {
      return;
    }
    final _days = _updateListValues(_selectedValues);
    _columnThrList = List.generate(_days, (index) => '${index + 1}').toList();
    setState(() {});
  }

  int _updateListValues(List<String> value) {
    final _year = int.parse(value[0]);
    final _month = int.parse(value[1]);
    final _days = _lastDayInMonth(_year, _month).day;
    return _days;
  }

  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);
}
