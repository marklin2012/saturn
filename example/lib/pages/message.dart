import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MessagePage extends StatelessWidget {
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
            child: Text("单行文字图片"),
            color: Colors.blue,
            onPressed: () {
              STMessageSharedInstance().show(
                  context: context,
                  message: "这是文本信息",
                  icon: "assets/images/basketball_check.png",
                  showShadow: false,
                  autoClose: true);
            },
          ),
          FlatButton(
            child: Text("多行文字图片"),
            color: Colors.blue,
            onPressed: () {
              STMessageSharedInstance().show(
                  context: context,
                  message: "好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                  icon: "assets/images/basketball_check.png");
              Future.delayed(Duration(seconds: 2), () {
                STMessageSharedInstance().show(
                    context: context,
                    title: "标题标题",
                    message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                    icon: "assets/images/basketball_check.png");
              });
            },
          ),
          FlatButton(
            child: Text("标题文字图片"),
            color: Colors.blue,
            onPressed: () {
              STMessageSharedInstance().show(
                  context: context,
                  title: "标题标题",
                  message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                  icon: "assets/images/basketball_check.png");
            },
          ),
          // FlatButton(
          //   child: Text("标题文字说明图片"),
          //   color: Colors.blue,
          //   onPressed: () {
          //     STMessage.show(
          //       context: context,
          //       title: "标题标题",
          //       message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
