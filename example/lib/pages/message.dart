import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image imageWidget = Image.asset("assets/images/basketball_check.png",
        width: 24.0, height: 24.0, fit: BoxFit.contain);
    Icon iconWidget = Icon(Icons.error_outline);
    return Scaffold(
        appBar: AppBar(
          title: Text('Message'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              STMessage(
                message: "这是文本信息",
                icon: imageWidget,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              STMessage(
                title: "标题标题",
                message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                icon: imageWidget,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.error,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.info,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.warning,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.success,
                showShadow: false,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              FlatButton(
                child: Text("单行文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                    context: context,
                  );
                },
              ),
              FlatButton(
                child: Text("单行文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      message: "这是文本信息",
                      icon: imageWidget,
                      showShadow: false,
                      autoClose: true);
                },
              ),
              FlatButton(
                child: Text("多行文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      message: "好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                      icon: iconWidget);
                  Future.delayed(Duration(seconds: 2), () {
                    STMessage.show(
                      context: context,
                      title: "标题标题",
                      message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                    );
                  });
                },
              ),
              FlatButton(
                child: Text("标题文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      title: "标题标题",
                      message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                      location: STMessageLocation.center,
                      showShadow: false);
                },
              ),
              FlatButton(
                child: Text("传入widget"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(context: context, content: Text("好的"));
                },
              ),
            ],
          ),
        ));
  }
}
