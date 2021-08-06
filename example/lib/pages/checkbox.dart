import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  var _checkValue = false;

  var _boxItems = [
    STBoxItem(title: '语文'),
    STBoxItem(title: '数学'),
    STBoxItem(title: '英语'),
  ];

  var _selected = ['语文'];

  var _isAll = false;

  var _boxAllItems = [
    STBoxItem(title: '物理'),
    STBoxItem(title: '化学'),
    STBoxItem(title: '生物'),
  ];

  var _selectedAll = ['物理'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16.0),
        children: [
          SizedBox(height: 20),
          _buildBase(),
          SizedBox(height: 20),
          _buildDisable(),
          SizedBox(height: 20),
          _buildCombination(),
          SizedBox(height: 20),
          _buildAll(),
        ],
      ),
    );
  }

  Widget _buildBase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('基本用法'),
        STCheckBox(
          value: _checkValue,
          text: "文字信息",
          onChanged: (value) {
            setState(() {
              _checkValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDisable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('禁用状态'),
        STCheckBox(
          value: false,
          disabled: true,
          text: "文字信息",
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildCombination() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('组合用法'),
        STCheckboxGroup(
          items: _boxItems,
          selecteds: _selected,
          axis: Axis.vertical,
          onChanged: (List<String> values) {
            setState(() {
              _selected = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('全选用法'),
        STCheckBox(
          value: _isAll,
          text: "全选",
          onChanged: (value) {
            setState(() {
              _isAll = value;
              if (_isAll) {
                var temp = <String>[];
                for (var item in _boxAllItems) {
                  temp.add(item.title);
                }
                _selectedAll = List.from(temp);
              } else {
                _selectedAll = <String>[];
              }
            });
          },
        ),
        STCheckboxGroup(
          items: _boxAllItems,
          selecteds: _selectedAll,
          axis: Axis.vertical,
          onChanged: (List<String> values) {
            setState(() {
              _selectedAll = values;
              if (_selectedAll.length != _boxAllItems.length) {
                _isAll = false;
              } else {
                _isAll = true;
              }
            });
          },
        ),
      ],
    );
  }
}
