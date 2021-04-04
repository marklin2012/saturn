import 'package:flutter/material.dart';
import 'package:saturn/st_checkbox/checkbox_single.dart';

class BoxItem {
  final String title;
  final bool disabled;

  BoxItem({this.title, this.disabled = false});
}

enum BoxDirection {
  horizontal,
  vertical,
}

class STCheckboxGroup extends StatefulWidget {
  final List<BoxItem> items;
  final List<String> selecteds;
  final ValueChanged<List<String>> onChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BoxDirection direction;

  const STCheckboxGroup({
    Key key,
    this.onChanged,
    this.margin = const EdgeInsets.symmetric(horizontal: 10),
    this.padding = const EdgeInsets.all(5.0),
    this.items,
    this.direction = BoxDirection.horizontal,
    this.selecteds,
  }) : super(key: key);

  @override
  _STCheckboxGroupState createState() => _STCheckboxGroupState();
}

class _STCheckboxGroupState extends State<STCheckboxGroup> {
  List<STCheckBox> _list;
  List<String> _values;
  List<String> _selecteds;
  List<BoxItem> _items;

  void initOriginBox() {
    _values = <String>[];
    _items = <BoxItem>[];
    // 过滤一遍title，保证无重复
    for (final item in widget.items) {
      if (!_values.contains(item.title)) {
        _values.add(item.title);
        _items.add(item);
      }
    }
    // 过滤一遍selected，保证无重复
    _selecteds = <String>[];
    for (final item in widget.selecteds) {
      if (!_selecteds.contains(item)) {
        _selecteds.add(item);
      }
    }
    // 根据selected判断是否选中来创建STCheckBox
    _list = <STCheckBox>[];
    for (final item in _items) {
      var _checked = false;
      for (final selected in _selecteds) {
        if (selected == item.title) {
          _checked = true;
        }
      }
      final _box = STCheckBox(
        value: _checked,
        disabled: item.disabled,
        text: item.title,
        onChanged: (bool value) {
          if (!_selecteds.contains(item.title)) {
            _selecteds.add(item.title);
          } else if (_selecteds.contains(item.title)) {
            _selecteds.remove(item.title);
          }
          widget.onChanged(_selecteds);
        },
      );
      _list.add(_box);
    }
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
    if (widget.direction == BoxDirection.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _list,
      );
    } else {
      return Column(children: _list);
    }
  }
}
