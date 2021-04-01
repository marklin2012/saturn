import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class AlertPage extends StatelessWidget {
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
              // send();
              // SocketManage.send(textEditController.text);

              STAlert.show(
                  context: context,
                  type: STAlertType.success,
                  message: "你说是就是",
                  autoClose: false,
                  showIcon: false,
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onCloseTap: () {
                    print('好的');
                  },
                  disappearTime: 3);
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
                  autoClose: true,
                  showIcon: true,
                  closeText: "你说好不好",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onCloseTap: () {
                    print('好的');
                  },
                  disappearTime: 3);
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
                  autoClose: true,
                  showIcon: true,
                  closeText: "你说好不好",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onCloseTap: () {
                    print('好的');
                  },
                  disappearTime: 3);
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
                  width: 250,
                  onCloseTap: () {
                    print('好的');
                  },
                  disappearTime: 3);
            },
          ),
        ],
      ),
    );
  }
}
