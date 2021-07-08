import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_show_dialog.dart';

class STSelectTextsConst {
  static const _selectTextsHeight = 302.0;
  static const _selectTitleHeight = 48.0;
  static const _pickerItemExtent = 44.0;
  static const _textStyle = TextStyle(
      color: Color(0xFF555555), fontSize: 16, fontWeight: FontWeight.w400);
  static const _unitTextStyle = TextStyle(
      color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w500);
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
    this.looping = true,
  }) : super(key: key);

  final Widget child; // 供外部触发的组件
  final String title; // 标题
  final List<String> initValue; // 初始默认值
  final List<List<String>> listValues; // 数据集合
  final Function(List<String> value) onChanged; // 点击确定后的回调
  final List<String> initUnits;
  final bool looping; //是否循环

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
                looping: looping,
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
    this.looping,
  }) : super(key: key);

  final String title; // 标题
  final List<String> initValue; // 初始默认值
  final List<List<String>> listValues; // 数据集合
  final Function(List<String> value) onChanged; // 点击确定后的回调
  final List<String> initUnits;
  final bool looping;

  @override
  _STSelectMenuState createState() => _STSelectMenuState();
}

class _STSelectMenuState extends State<STSelectMenu> {
  List<String> _selectedValues = [];
  double _width;
  int _columnNumber = 1;
  List<String> _columnOneList;
  List<String> _columnTwoList;
  List<String> _columnThrList;
  List<String> _initValue = [];
  List<List<String>> _listValues = [];

  @override
  void dispose() {
    super.dispose();
  }

  void _buildupLists() {
    // Dart List直接赋值的话是浅拷贝，会导致传入的值都会发生改变
    _initValue = List.from(widget.initValue);
    if (_selectedValues.isEmpty) {
      _selectedValues = List.from(widget.initValue);
    }
    if (_listValues.isEmpty) {
      _listValues = List.from(widget.listValues);
    }
    for (int i = 0; i < _listValues.length; i++) {
      _columnNumber = i + 1;
      if (i == 0) {
        _columnOneList = _listValues[i];
      } else if (i == 1) {
        _columnTwoList = _listValues[i];
      } else if (i == 2) {
        _columnThrList = _listValues[i];
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
    if (_initValue != null && _initValue.length > number) {
      _initialTitle = _initValue[number];
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
              looping: widget.looping,
              onSelectedItemChanged: (int index) {
                _selectedValues[number] = _titles[index];
              },
              children: List.generate(_titles.length, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              height: STSelectTextsConst._pickerItemExtent,
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
            style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.bold),
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
}
