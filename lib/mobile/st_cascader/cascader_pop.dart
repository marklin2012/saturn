import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_cascader/cascader_item.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';

const _defaultSelectColor = Color(0xFFEFF3F9);
const _defaultColor = Color(0xFF000000);
const _defaultTextStyle = TextStyle(color: _defaultColor, fontSize: 14);
const _defaultIcon =
    Icon(STIcons.direction_rightoutlined, size: 16, color: _defaultColor);
const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _leftBorderDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0)),
);
const _rightBorderDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.horizontal(right: Radius.circular(8.0)),
);

class STCascaderPopItem {
  final String value;
  final String key;
  final bool next;

  const STCascaderPopItem({this.value, this.key, this.next});
}

class STCascaderPop extends StatefulWidget {
  const STCascaderPop(
      {Key key, this.items, @required this.onChangedValue, this.onChangedKey})
      : super(key: key);

  final List<STCascaderItem> items;
  final ValueChanged<List<String>> onChangedValue;
  final ValueChanged<List<String>> onChangedKey;

  @override
  _STCascaderPopState createState() => _STCascaderPopState();
}

class _STCascaderPopState extends State<STCascaderPop> {
  final List<int> _selectedIndexs = []..length = 3;
  final _maxColumn = 3;
  double _columnWidth;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width -
        _defaultMargin.left -
        _defaultMargin.right;
    _columnWidth = _width / _maxColumn;
    return Container(
      margin: _defaultMargin,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0x19000000),
          )
        ],
      ),
      child: Row(
        children: [
          _getListWidget(0),
          if (_selectedIndexs[0] != null) _getListWidget(1),
          if (_selectedIndexs[1] != null) _getListWidget(2),
        ],
      ),
    );
  }

  Widget _getListWidget(int column) {
    List<STCascaderPopItem> _items;
    var _decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
    if (column == 0) {
      _items = _getColumnValues(widget.items);
      if (_selectedIndexs[0] != null) {
        final _selectedIndex = _selectedIndexs[0];
        final _subItem = _items[_selectedIndex];
        if (_subItem.next) {
          _decoration = _leftBorderDecoration;
        }
      }
    } else if (column == 1) {
      final _temp = widget.items[_selectedIndexs[0]].items;
      _items = _getColumnValues(_temp);
      if (_selectedIndexs[1] != null) {
        final _selectedIndex = _selectedIndexs[1];
        final _subItem = _items[_selectedIndex];
        if (_subItem.next) {
          _decoration = const BoxDecoration(
            color: Colors.white,
          );
        } else {
          _decoration = _rightBorderDecoration;
        }
      } else {
        _decoration = _rightBorderDecoration;
      }
    } else if (column == 2) {
      final _temp =
          widget.items[_selectedIndexs[0]].items[_selectedIndexs[1]].items;
      _items = _getColumnValues(_temp);
      _decoration = _rightBorderDecoration;
    }
    if (_items == null || _items.isEmpty) return Container();
    return Container(
      decoration: _decoration,
      width: _columnWidth,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        itemCount: _items.length,
        itemExtent: 44.0,
        itemBuilder: (context, index) {
          final _bgColor = index == _selectedIndexs[column]
              ? _defaultSelectColor
              : Colors.white;
          return GestureDetector(
            onTap: () {
              if (column == 0) {
                _selectedIndexs[1] = null;
                _selectedIndexs[2] = null;
              } else if (column == 1) {
                _selectedIndexs[2] = null;
              }
              _selectedIndexs[column] = index;
              _onChanged();
              setState(() {});
            },
            child: Container(
              color: _bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_items[index].value, style: _defaultTextStyle),
                  if (_items[index].next) _defaultIcon,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<STCascaderPopItem> _getColumnValues(List<STCascaderItem> values) {
    if (values == null || values.isEmpty) return <STCascaderPopItem>[];
    return List.generate(values.length, (index) {
      final _value = values[index].value;
      final _next = values[index].items != null;
      final _key = values[index].key;
      return STCascaderPopItem(value: _value, key: _key, next: _next);
    }).toList();
  }

  void _onChanged() {
    final _values = <String>[];
    final _keys = <String>[];
    var i = 0;
    var _temp = widget.items;
    while (i < _selectedIndexs.length) {
      if (_selectedIndexs[i] == null) {
        break;
      }
      final _index = _selectedIndexs[i];
      _values.add(_temp[_index].value);
      _keys.add(_temp[_index].key);
      if (_temp[_index].items == null) {
        break;
      }
      _temp = _temp[_index].items;
      i++;
    }
    if (widget.onChangedKey != null) {
      widget.onChangedKey(_keys);
    }
    widget.onChangedValue(_values);
  }
}
