import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text("文字"),
            color: Colors.blue,
            onPressed: () {
              STLoading.show(context: context, text: "正在加载中...");
            },
          ),
        ],
      ),
    );
  }
}
