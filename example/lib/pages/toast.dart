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
                  message: "这是一个message这是一个message这是一个message这是一个message",
                  autoClose: true);
            },
          ),
          FlatButton(
            child: Text("左文字图片位置下"),
            color: Colors.blue,
            onPressed: () {
              STToast.show(
                  context: context,
                  icon: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
                  message: "这是一个message这是一个message这是一个message这是一个message",
                  locationType: STToastLocationType.bottom,
                  closable: true);
              ;
            },
          ),
          FlatButton(
            child: Text("图片"),
            color: Colors.blue,
            onPressed: () {
              STToast.showLoading(
                  context: context,
                  icon: Icon(Icons.error_outline, color: Colors.white),
                  locationType: STToastLocationType.center);
            },
          ),
          FlatButton(
            child: Text("上文字图片"),
            color: Colors.blue,
            onPressed: () {
              STToast.show(
                  context: context,
                  icon: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
                  message: "这是一个message这是一个message这是一个message这是一个message",
                  isIconUpText: true);
            },
          ),
        ],
      ),
    );
  }
}
