import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            STAlert(
                type: STAlertType.success,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 200,
                disappearMilliseconds: 2000,
                message: "Success Tips"),
            STAlert(
                type: STAlertType.info,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 200,
                disappearMilliseconds: 2000,
                message: "Information Notes"),
            STAlert(
                type: STAlertType.warning,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 200,
                disappearMilliseconds: 2000,
                message: "Warning"),
            STAlert(
                type: STAlertType.error,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 200,
                disappearMilliseconds: 2000,
                message: "Error"),
            STAlert(
              type: STAlertType.success,
              showIcon: true,
              autoClose: false,
              closable: false,
              width: 300,
              disappearMilliseconds: 2000,
              message: "Success Tips",
              description: "Detailed description and advice about",
            ),
            STAlert(
                type: STAlertType.info,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 300,
                disappearMilliseconds: 2000,
                message: "Information Notes",
                description: "Additional description adn information about"),
            STAlert(
                type: STAlertType.warning,
                showIcon: true,
                autoClose: false,
                closable: false,
                width: 300,
                disappearMilliseconds: 2000,
                message: "Warning",
                description: "This is a warning notice about copywriting"),
            STAlert(
              type: STAlertType.error,
              showIcon: true,
              autoClose: false,
              closable: false,
              width: 300,
              disappearMilliseconds: 2000,
              message: "Error",
              description: "This is a error notice about ",
            ),
            STAlert(
                type: STAlertType.warning,
                showIcon: false,
                autoClose: false,
                closable: false,
                width: 300,
                disappearMilliseconds: 2000,
                message: "Warning",
                description: "This is a warning notice about copywriting"),
            STAlert(
              type: STAlertType.error,
              showIcon: false,
              autoClose: false,
              closable: false,
              width: 300,
              disappearMilliseconds: 2000,
              message: "Error",
              description: "This is a error notice about ",
            ),
            STAlert(
                type: STAlertType.info,
                showIcon: false,
                autoClose: false,
                closable: false,
                width: 200,
                disappearMilliseconds: 2000,
                message: "Info Text"),
            STAlert(
              type: STAlertType.info,
              showIcon: false,
              autoClose: false,
              closable: true,
              width: 300,
              disappearMilliseconds: 2000,
              message: "This is an info alert",
              closeText: "back",
            ),
            STAlert(
              type: STAlertType.success,
              showIcon: false,
              autoClose: false,
              closable: true,
              width: 300,
              disappearMilliseconds: 2000,
              message: "This is an success alert",
            ),
            FlatButton(
              child: Text("文字"),
              color: Colors.blue,
              onPressed: () {
                STAlert.show(
                  context: context,
                  message: "你说是就是",
                );
              },
            ),
            FlatButton(
              child: Text("文字"),
              color: Colors.blue,
              onPressed: () {
                STAlert.show(
                    context: context,
                    type: STAlertType.success,
                    message: "你说是就是",
                    autoClose: true,
                    showIcon: false,
                    width: 250,
                    onCloseTap: () {
                      print('好的');
                    },
                    disappearMilliseconds: 2000);
              },
            ),
            FlatButton(
              child: Text("图片文字"),
              color: Colors.blue,
              onPressed: () {
                // send();
                // SocketManage.send(textEditController.text);

                STAlert.show(
                    context: context,
                    type: STAlertType.info,
                    message:
                        "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                    autoClose: false,
                    showIcon: true,
                    closeText: "你说好不好",
                    width: 250,
                    onCloseTap: () {
                      print('好的');
                    },
                    disappearMilliseconds: 3000);
              },
            ),
            FlatButton(
              child: Text("文字说明"),
              color: Colors.blue,
              onPressed: () {
                // send();
                // SocketManage.send(textEditController.text);

                STAlert.show(
                    context: context,
                    type: STAlertType.error,
                    closable: true,
                    message: "你说是就是",
                    description:
                        "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                    autoClose: false,
                    showIcon: false,
                    width: 250,
                    disappearMilliseconds: 3000);
              },
            ),
            FlatButton(
              child: Text("图片文字说明"),
              color: Colors.blue,
              onPressed: () {
                // send();
                // SocketManage.send(textEditController.text);

                STAlert.show(
                    context: context,
                    type: STAlertType.warning,
                    message: "你说是就是",
                    description:
                        "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                    autoClose: false,
                    showIcon: true,
                    closeText: "关闭",
                    closable: true,
                    width: 250,
                    onCloseTap: () {
                      STAlert.hide(context);
                      print("好的");
                    },
                    disappearMilliseconds: 3000);
              },
            ),
          ],
        ),
      ),
    );
  }
}
