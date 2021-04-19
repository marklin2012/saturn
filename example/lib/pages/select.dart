import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  STSelectMixItem _initMix = STSelectMixItem(title: '混合型');
  List<String> _initTexts = ['第一列1', '第二列1', '第三列1'];
  List<String> _initTexts1 = ['第一列1', '第二列1'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: Column(children: [
        SizedBox(height: 50),
        STSelect(
          types: STSelectTypes.mix,
          initMixValue: _initMix,
          mixListValues: [
            STSelectMixItem(title: '混合型'),
            STSelectMixItem(title: '一类型'),
            STSelectMixItem(title: '二类型', icon: Icons.star),
            STSelectMixItem(title: '三类型', icon: Icons.book, disabled: true),
            STSelectMixItem(title: '四类型', disabled: true),
            STSelectMixItem(title: '五类型'),
            STSelectMixItem(title: '六类型'),
          ],
          onChangedMixValue: (STSelectMixItem value) {
            _initMix = value;
            setState(() {});
          },
        ),
        SizedBox(height: 50),
        STSelect(
          types: STSelectTypes.texts,
          title: 'texts选择器',
          initTextsValue: _initTexts,
          textsListValues: [
            ['第一列1', '第一列2', '第一列3', '第一列4', '第一列5', '第一列6'],
            ['第二列1', '第二列2', '第二列3', '第二列4', '第二列5', '第二列6'],
            ['第三列1', '第三列2', '第三列3', '第三列4', '第三列5', '第三列6']
          ],
          onChangedTextsValue: (List<String> value) {
            _initTexts = value;
            setState(() {});
          },
          child: Text(_listToString(_initTexts)),
        ),
        SizedBox(height: 50),
        STSelect(
          types: STSelectTypes.texts,
          title: 'texts选择器1',
          initTextsValue: _initTexts1,
          textsListValues: [
            ['第一列1', '第一列2', '第一列3', '第一列4', '第一列5', '第一列6'],
            ['第二列1', '第二列2', '第二列3', '第二列4', '第二列5', '第二列6'],
          ],
          onChangedTextsValue: (List<String> value) {
            _initTexts1 = value;
            setState(() {});
          },
          child: Text(_listToString(_initTexts1)),
        ),
      ]),
    );
  }

  String _listToString(List<String> list) {
    if (list == null) {
      return null;
    }
    String result;
    list.forEach((string) =>
        {if (result == null) result = string else result = '$result，$string'});
    return result.toString();
  }
}
