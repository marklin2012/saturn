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
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
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
            backgroundColor: Colors.red,
            child: _child,
          ),
          SizedBox(height: 10),
          STCard(
            type: STCardType.basic,
            shadowed: true,
            title: '卡片名称',
            opration: TextButton(onPressed: () {}, child: Text('操作按钮')),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('列表内容1'),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('列表内容2'),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('列表内容3'),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('列表内容4'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          STCard(
            type: STCardType.icon,
            opration: TextButton(onPressed: () {}, child: Text('操作按钮')),
          ),
        ],
      ),
    );
  }
}
