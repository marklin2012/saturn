import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ToastPage extends StatelessWidget {
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
              STToast.show(
                  context: context,
                  message: "这是一个message这是一个message这是一个message这是一个message");
            },
          ),
          FlatButton(
            child: Text("左文字图片位置下"),
            color: Colors.blue,
            onPressed: () {
              STToast.show(
                  context: context,
                  icon: "assets/images/basketball_check.png",
                  message: "这是一个message这是一个message这是一个message这是一个message",
                  locationType: STToastLocationType.bottom);
              ;
            },
          ),
          FlatButton(
            child: Text("图片位置上"),
            color: Colors.blue,
            onPressed: () {
              STToast.show(
                  context: context,
                  icon: "assets/images/basketball_check.png",
                  haveIconAnimation: true,
                  locationType: STToastLocationType.top);
            },
          ),
          FlatButton(
            child: Text("上文字图片"),
            color: Colors.blue,
            onPressed: () {
              STToast.show(
                  context: context,
                  icon: "assets/images/basketball_check.png",
                  message: "这是一个message这是一个message这是一个message这是一个message",
                  isIconUpText: true);
            },
          ),
        ],
      ),
    );
  }
}
