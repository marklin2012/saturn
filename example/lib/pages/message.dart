import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image imageWidget = Image.asset("assets/images/basketball_check.png",
        width: 24.0, height: 24.0, fit: BoxFit.contain);
    Icon iconWidget = Icon(Icons.error_outline);
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: Text('Message'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              STMessage(
                message: "这是文本信息",
                icon: imageWidget,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              STMessage(
                title: "标题标题",
                message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                icon: imageWidget,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.error,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.info,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.warning,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              STMessage(
                message: "这是文本信息",
                type: STMessageType.success,
                showShadow: true,
                autoClose: false,
                disappearMilliseconds: 3000,
                location: STMessageLocation.top,
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("单行文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                    context: context,
                  );
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("单行文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      message: "这是文本信息",
                      icon: imageWidget,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
