import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                FlatButton(
                  child: Text("基本", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("含图标", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      showIcon: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("含关闭操作", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      closable: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child:
                      Text("含辅助性文字描述", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      context: context,
                      message: "提示标题",
                      description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                    child:
                        Text("含自定义操作", style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                    onPressed: () {
                      STAlert.show(
                        type: STAlertType.info,
                        autoClose: true,
                        context: context,
                        showIcon: true,
                        message: "提示标题",
                        description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
                      );
                    }),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("成功样式", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.success,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("信息样式", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("警告样式", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.warning,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("错误样式", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    STAlert.show(
                      type: STAlertType.error,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
