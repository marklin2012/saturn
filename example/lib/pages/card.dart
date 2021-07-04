import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    final _child = Container(
      height: 192.0,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            height: 48.0,
            child: Text('列表内容$index'),
          );
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          STCard(
            type: STCardType.basic,
            title: '卡片名称',
            opration: STButton(
              type: STButtonType.text,
              text: '操作按钮',
            ),
            child: _child,
          ),
          SizedBox(height: 10),
          STCard(
            type: STCardType.basic,
            shadowed: true,
            title: '体育界大佬',
            opration: STButton(
              type: STButtonType.text,
              text: '操作按钮',
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('科比'),
                  SizedBox(height: 10),
                  Text('乔丹'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          STCard(
            type: STCardType.icon,
            opration: STButton(
              type: STButtonType.text,
              text: '操作按钮',
            ),
          ),
        ],
      ),
    );
  }
}
