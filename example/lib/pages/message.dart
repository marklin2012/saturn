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
              FlatButton(
                child: Text("基础用法"),
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
                child: Text("含辅助性文字描述"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      title: "标题标题",
                      message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                      icon: imageWidget,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("显示状态"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      message: "这是文本信息",
                      type: STMessageType.success,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("可自定义"),
                color: Colors.blue,
                onPressed: () {
                  STMessage.show(
                      context: context,
                      content: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                iconWidget,
                                Text(
                                  "这是说明信息",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: STMessageConstant.titleFontSize,
                                      decoration: TextDecoration.none),
                                ),
                                iconWidget,
                              ],
                            ),
                            Text("标题标题",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: STMessageConstant.titleFontSize,
                                    decoration: TextDecoration.none)),
                            Text("这是文本信息",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: STMessageConstant.titleFontSize,
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ));
                },
              ),
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
            ],
          ),
        ));
  }
}
