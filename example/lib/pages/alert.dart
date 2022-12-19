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
                STButton(
                  text: "基本",
                  onTap: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                STButton(
                  text: "含图标",
                  onTap: () {
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
                STButton(
                  text: "含关闭操作",
                  onTap: () {
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
                STButton(
                  text: "含辅助性文字描述",
                  onTap: () {
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
                STButton(
                    text: "含自定义操作",
                    onTap: () {
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
                STButton(
                  text: "成功样式",
                  onTap: () {
                    STAlert.show(
                      type: STAlertType.success,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                STButton(
                  text: "信息样式",
                  onTap: () {
                    STAlert.show(
                      type: STAlertType.info,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                STButton(
                  text: "警告样式",
                  onTap: () {
                    STAlert.show(
                      type: STAlertType.warning,
                      autoClose: true,
                      context: context,
                      message: "提示文字",
                    );
                  },
                ),
                SizedBox(height: 20),
                STButton(
                  text: "错误样式",
                  onTap: () {
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
