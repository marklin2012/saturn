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
              STLoading.show(
                  context: context,
                  iconUpperText: true,
                  text: "正在加载中...",
                  icon: "assets/images/icon_selected_20x20.png",
                  gifIcon: "assets/images/1.gif");
            },
          ),
        ],
      ),
    );
  }
}
