import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class CascaderPage extends StatefulWidget {
  @override
  _CascaderPageState createState() => _CascaderPageState();
}

class _CascaderPageState extends State<CascaderPage> {
  final _items = [
    STCascaderItem(value: '电视', key: 'TV', items: [
      STCascaderItem(value: '闭路', key: 'BL', items: [
        STCascaderItem(value: 'CCTV'),
        STCascaderItem(value: '湖南卫视'),
        STCascaderItem(value: '江苏卫视'),
        STCascaderItem(value: '广东卫视'),
      ]),
      STCascaderItem(value: '网络', key: 'WF'),
    ]),
    STCascaderItem(value: '体育', key: 'Sports', items: [
      STCascaderItem(value: '篮球', key: 'basketball', items: [
        STCascaderItem(value: '姚明'),
        STCascaderItem(value: '王治郅'),
        STCascaderItem(value: '刘伟'),
        STCascaderItem(value: '孙悦'),
        STCascaderItem(value: '王仕鹏')
      ]),
      STCascaderItem(value: '足球', key: 'football', items: [
        STCascaderItem(value: 'C罗'),
        STCascaderItem(value: '梅西'),
      ]),
    ]),
    STCascaderItem(value: '明星', key: 'Star'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cascader'),
      ),
      body: Center(
        child: STCascader(
          items: _items,
          onChanged: (List<String> keys) {
            debugPrint('$keys');
          },
        ),
      ),
    );
  }
}
