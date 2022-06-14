import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  STSelectMixItem _initMix = STSelectMixItem(title: '混合型', key: '0');
  List<String> _initText1 = ['第一列1'];
  List<String> _initText2 = ['第一列1', '第二列2'];
  List<String> _initText3 = ['第一列1', '第二列2', '第三列3'];
  List<String> _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _typeName('基本用法'),
            SizedBox(height: 15),
            STSelect(
              types: STSelectTypes.mix,
              initMixValue: _initMix,
              mixListValues: [
                STSelectMixItem(title: '混合型', key: '0'),
                STSelectMixItem(title: '混合型', key: '1'),
                STSelectMixItem(title: '混合型', key: '2'),
                STSelectMixItem(title: '混合型', key: '3'),
                STSelectMixItem(title: '混合型', key: '4', disabled: true),
                STSelectMixItem(title: '混合型', key: '5'),
              ],
              onChangedMixValue: (STSelectMixItem value) {
                _initMix = value;
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            _typeName('含勾选样式'),
            SizedBox(height: 15),
            STSelect(
              types: STSelectTypes.mix,
              isConCheck: true,
              initMixValue: _initMix,
              mixListValues: [
                STSelectMixItem(title: '混合型', key: '0'),
                STSelectMixItem(title: '混合型', key: '1'),
                STSelectMixItem(title: '混合型', key: '2'),
                STSelectMixItem(title: '混合型', key: '3'),
                STSelectMixItem(title: '混合型', key: '4', disabled: true),
                STSelectMixItem(title: '混合型', key: '5'),
              ],
              onChangedMixValue: (STSelectMixItem value) {
                _initMix = value;
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            _typeName('含图标样式'),
            SizedBox(height: 15),
            STSelect(
              types: STSelectTypes.mix,
              initMixValue: _initMix,
              mixListValues: [
                STSelectMixItem(title: '混合型', key: '0', icon: Icons.book),
                STSelectMixItem(
                    title: '混合型', key: '1', icon: Icons.star_border_outlined),
                STSelectMixItem(title: '混合型', key: '2', icon: Icons.menu),
                STSelectMixItem(title: '混合型', key: '3', icon: Icons.ac_unit),
                STSelectMixItem(
                    title: '混合型', key: '4', disabled: true, icon: Icons.cached),
                STSelectMixItem(title: '混合型', key: '5', icon: Icons.dangerous),
              ],
              onChangedMixValue: (STSelectMixItem value) {
                _initMix = value;
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            _typeName('自定义样式'),
            SizedBox(height: 15),
            Row(
              children: [
                STSelect(
                  types: STSelectTypes.texts,
                  title: '标题',
                  looping: true,
                  initTextsValue: _initText1,
                  textsListValues: [
                    ['第一列1', '第一列2', '第一列3', '第一列4', '第一列5', '第一列6'],
                  ],
                  onChangedTextsValue: (List<String> value) {
                    _initText1 = value;
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5.0),
                    child: Text(
                      '自定义一列',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_initText1 != null) SizedBox(width: 20),
                if (_initText1 != null) _typeName(_listToString(_initText1))
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                STSelect(
                  types: STSelectTypes.texts,
                  title: '标题',
                  looping: true,
                  initTextsValue: _initText2,
                  textsListValues: [
                    ['第一列1', '第一列2', '第一列3', '第一列4', '第一列5', '第一列6'],
                    ['第二列1', '第二列2', '第二列3', '第二列4', '第二列5', '第二列6'],
                  ],
                  onChangedTextsValue: (List<String> value) {
                    _initText2 = value;
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5.0),
                    child: Text(
                      '自定义二列',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_initText1 != null) SizedBox(width: 20),
                if (_initText2 != null) _typeName(_listToString(_initText2))
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                STSelect(
                  types: STSelectTypes.texts,
                  title: '标题',
                  looping: true,
                  initTextsValue: _initText3,
                  textsListValues: [
                    ['第一列1', '第一列2', '第一列3', '第一列4', '第一列5', '第一列6'],
                    ['第二列1', '第二列2', '第二列3', '第二列4', '第二列5', '第二列6'],
                    ['第三列1', '第三列2', '第三列3', '第三列4', '第三列5', '第三列6'],
                  ],
                  onChangedTextsValue: (List<String> value) {
                    _initText3 = value;
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5.0),
                    child: Text(
                      '自定义三列',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_initText1 != null) SizedBox(width: 20),
                if (_initText3 != null) _typeName(_listToString(_initText3))
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                STSelect(
                  types: STSelectTypes.address,
                  onChangedTextsValue: (value) {
                    _address = value;
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5.0),
                    child: Text(
                      '选择地址',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_address != null) SizedBox(width: 20),
                if (_address != null) _typeName(_listToString(_address))
              ],
            ),
          ],
        ),
      ),
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

  Widget _typeName(String name, {color = Colors.transparent}) {
    return Container(
      color: color,
      child: Text(name),
    );
  }
}
