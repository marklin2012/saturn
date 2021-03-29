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
                  text: "你说是就是",
                  isAutoClose: false,
                  showLeftIcon: false,
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onRightTap: () {
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
                  type: STAlertType.alert,
                  text:
                      "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                  isAutoClose: true,
                  showLeftIcon: true,
                  rightText: "你说好不好",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onRightTap: () {
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
                  type: STAlertType.danger,
                  text: "你说是就是",
                  description:
                      "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                  isAutoClose: true,
                  showLeftIcon: true,
                  rightText: "你说好不好",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250,
                  onRightTap: () {
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
                  text: "你说是就是",
                  description:
                      "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                  isAutoClose: false,
                  showLeftIcon: true,
                  width: 250,
                  onRightTap: () {
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
