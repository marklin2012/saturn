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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Text("基本"),
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
              child: Text("含图标"),
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
              child: Text("含关闭操作"),
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
              child: Text("含辅助性文字描述"),
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
                child: Text("含自定义操作"),
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
              child: Text("成功样式"),
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
              child: Text("信息样式"),
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
              child: Text("警告样式"),
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
              child: Text("错误样式"),
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
            STAlert(
                type: STAlertType.success,
                showIcon: false,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.success,
                showIcon: false,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.success,
                showIcon: true,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.success,
                showIcon: true,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            ///            SizedBox(height: 20),
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.success,
              showIcon: false,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),
            ///////////////////////////
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.success,
              showIcon: true,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.success,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),

            ///
            ///
            ///
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.info,
                showIcon: false,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.info,
                showIcon: false,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.info,
                showIcon: true,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.info,
                showIcon: true,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            ///            SizedBox(height: 20),
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.info,
              showIcon: false,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),
            ///////////////////////////
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.info,
              showIcon: true,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.info,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),

            ///
            ///
            ///
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.error,
                showIcon: false,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.error,
                showIcon: false,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.error,
                showIcon: true,
                autoClose: false,
                closable: false,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
                type: STAlertType.error,
                showIcon: true,
                autoClose: false,
                closable: true,
                disappearMilliseconds: 2000,
                message: "提示文字"),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示文字",
              closeText: "关闭",
            ),
            //////////////////////////
            ///            SizedBox(height: 20),
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.error,
              showIcon: false,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: false,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),
            ///////////////////////////
            SizedBox(height: 20),

            STAlert(
              type: STAlertType.error,
              showIcon: true,
              autoClose: false,
              closable: false,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
            ),
            SizedBox(height: 20),
            STAlert(
              type: STAlertType.error,
              showIcon: true,
              autoClose: false,
              closable: true,
              disappearMilliseconds: 2000,
              message: "提示标题",
              description: "提示文字提示文字提示文字提示文字提示文字提示文字提示文字提示文字",
              closeText: "关闭",
            ),
          ],
        ),
      ),
    );
  }
}
