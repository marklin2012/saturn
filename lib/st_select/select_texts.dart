import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_show_dialog.dart';

class STSelectTexts extends StatefulWidget {
  const STSelectTexts({
    Key key,
    this.child,
    this.title,
    this.initValue,
    this.listValues,
    this.onChanged,
    this.onUpdated,
    this.initUnits,
  }) : super(key: key);

  final Widget child; // 供外部触发的组件
  final String title; // 标题
  final List<String> initValue; // 初始默认值
  final List<List<String>> listValues; // 数据集合
  final Function(List<String> value) onChanged; // 点击确定后的回调
  final Function(List<String> value) onUpdated; // 选择了就回调已选择的
  final List<String> initUnits; // 初始化单位可为null

  @override
  _STSelectTextsState createState() => _STSelectTextsState();
}

class _STSelectTextsState extends State<STSelectTexts> {
  static const _selectTextsHeight = 302.0;
  static const _selectTitleHeight = 48.0;
  static const _pickerItemExtent = 44.0;
  static const _textStyle = TextStyle(color: Color(0xFF555555), fontSize: 16);
  static const _unitTextStyle =
      TextStyle(color: Color(0xFF000000), fontSize: 16);
  static const _magnification = 1.1;

  List<String> _selectedValues;
  double _width;
  int _columnNumber = 1;
  List<String> _columnOneList;
  List<String> _columnTwoList;
  List<String> _columnThrList;

  void _buildupLists() {
    for (int i = 0; i < widget.listValues.length; i++) {
      if (i == 0) {
        _columnOneList = widget.listValues[i];
        _columnNumber = 1;
      } else if (i == 1) {
        _columnTwoList = widget.listValues[i];
        _columnNumber = 2;
      } else if (i == 2) {
        _columnThrList = widget.listValues[i];
        _columnNumber = 3;
        break; //只取前3,其余的忽略
      }
    }
    _selectedValues = widget.initValue ?? ['', '', ''];
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _buildupLists();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return ShowSelectDialog(
              menu: _getShowMenu(context),
              offset: Offset(0, _height - _selectTextsHeight),
              height: _selectTextsHeight,
            );
          },
        );
      },
      child: widget.child,
    );
  }

  Widget _getShowMenu(BuildContext context) {
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
            height: _selectTextsHeight - _selectTitleHeight,
            width: _width / _columnNumber - _unitWidth,
            child: CupertinoPicker(
              itemExtent: _pickerItemExtent,
              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                capLeftEdge: false,
                capRightEdge: false,
              ),
              scrollController: FixedExtentScrollController(
                initialItem: _initItem,
              ),
              useMagnifier: true,
              magnification: _magnification,
              onSelectedItemChanged: (int index) {
                _selectedValues[number] = _titles[index];
                if (widget.onUpdated != null) {
                  widget.onUpdated(_selectedValues);
                }
              },
              children: List.generate(_titles.length, (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: _pickerItemExtent,
                  alignment: _initUnit != null
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: Text(
                    _titles[index],
                    style: _textStyle,
                  ),
                );
              }).toList(),
            ),
          ),
          if (_initUnit != null)
            Container(
              width: _unitWidth,
              height: _pickerItemExtent * _magnification,
              alignment: Alignment.centerLeft,
              color: CupertinoColors.tertiarySystemFill,
              child: Text(
                _initUnit,
                style: _unitTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _getTitleChild(BuildContext context) {
    return SizedBox(
      height: _selectTitleHeight,
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
}
