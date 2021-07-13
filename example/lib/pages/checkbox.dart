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
    STBoxItem(title: '禁用', disabled: true),
  ];
  var _selected = ['语文'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text('系统的CheckBox'),
            Checkbox(
              value: _checkValue,
              onChanged: (value) {
                setState(() {
                  _checkValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('系统的checkboxListTile'),
            CheckboxListTile(
              title: Text('文字'),
              controlAffinity: ListTileControlAffinity.leading,
              value: _checkValue,
              onChanged: (value) {
                setState(() {
                  _checkValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('自定义的CheckBox'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                STCheckBox(
                  value: _checkValue,
                  onChanged: (value) {
                    setState(() {
                      _checkValue = value;
                    });
                  },
                ),
                STCheckBox(
                  value: _checkValue,
                  disabled: true,
                  onChanged: (value) {
                    setState(() {
                      _checkValue = value;
                    });
                  },
                ),
                STCheckBox(
                  value: _checkValue,
                  text: '文字',
                  onChanged: (value) {
                    setState(() {
                      _checkValue = value;
                    });
                  },
                ),
                STCheckBox(
                  value: _checkValue,
                  disabled: true,
                  text: '禁用',
                  onChanged: (value) {
                    setState(() {
                      _checkValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('自定义的CheckBoxGroup'),
            STCheckboxGroup(
              items: _boxItems,
              selecteds: _selected,
              onChanged: (List<String> values) {
                setState(() {
                  _selected = values;
                });
              },
            ),
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
        ),
      ),
    );
  }
}
