import 'package:flutter/material.dart';
import 'package:saturn/st_checkbox/checkbox.dart';

class STBoxItem {
  final String key;
  final String title;
  final bool disabled;

  const STBoxItem({key, this.title, disabled})
      : key = key ?? title,
        disabled = disabled ?? false;
}

class STBoxBlock {
  bool isAllOn;
  List<String> selectedValues;

  STBoxBlock({this.isAllOn, this.selectedValues});
}

class STCheckboxGroup extends StatefulWidget {
  final List<STBoxItem> items;
  final List<String> selecteds;
  final ValueChanged<STBoxBlock> onChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Axis axis;
  final bool isAllOn;

  const STCheckboxGroup({
    Key key,
    this.onChanged,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(4.0),
    this.items,
    this.axis = Axis.horizontal,
    this.selecteds,
    this.isAllOn = false,
  }) : super(key: key);

  @override
  _STCheckboxGroupState createState() => _STCheckboxGroupState();
}

class _STCheckboxGroupState extends State<STCheckboxGroup> {
  List<STCheckBox> _list;
  List<String> _values;
  List<String> _selecteds;
  List<STBoxItem> _items;

  bool _isAllOn;
  STBoxBlock _boxBlock;

  void initOriginBox() {
    _values = <String>[];
    _items = <STBoxItem>[];
    _isAllOn = widget.isAllOn;
    // 过滤一遍key，保证无重复
    for (final item in widget.items) {
      if (!_values.contains(item.key)) {
        _values.add(item.key);
        _items.add(item);
      }
    }
    // 过滤一遍selected，保证无重复
    _selecteds = <String>[];
    if (_isAllOn) {
      for (final item in _items) {
        _selecteds.add(item.key);
      }
    } else {
      for (final select in widget.selecteds) {
        if (!_selecteds.contains(select)) {
          _selecteds.add(select);
        }
      }
    }

    // 根据selected判断是否选中来创建STCheckBox
    _list = <STCheckBox>[];
    for (final item in _items) {
      var _checked = false;
      for (final selected in _selecteds) {
        if (selected == item.key) {
          _checked = true;
        }
      }
      final _box = STCheckBox(
        value: _checked,
        disabled: item.disabled,
        text: item.title,
        onChanged: (bool value) {
          if (!_selecteds.contains(item.key)) {
            _selecteds.add(item.key);
          } else if (_selecteds.contains(item.key)) {
            _selecteds.remove(item.key);
          }
          if (_selecteds.length == _items.length) {
            _isAllOn = true;
          } else {
            _isAllOn = false;
          }
          _boxBlock.isAllOn = _isAllOn;
          _boxBlock.selectedValues = _selecteds;
          widget.onChanged(_boxBlock);
        },
      );
      _list.add(_box);
    }

    if (_selecteds.length == _items.length) {
      _isAllOn = true;
    }
    _boxBlock = STBoxBlock(
      isAllOn: _isAllOn,
      selectedValues: _selecteds,
    );
  }

  @override
  Widget build(BuildContext context) {
    initOriginBox();
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      child: _getSubWidget(),
    );
  }

  Widget _getSubWidget() {
    if (widget.axis == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _list,
      );
    } else {
      return Column(children: _list);
    }
  }
}
