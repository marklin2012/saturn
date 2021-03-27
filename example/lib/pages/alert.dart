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

              STAlert.show(context, STAlertType.text, STAlertState.warning,
                  STAlertRightButtonType.text, STAlertDisappearType.auto,
                  text: "你说是就是你说是就是你说是就是你说是就是",
                  rightText: "你说好不好",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250, onRightTap: () {
                print('好的');
              }, disappearTime: 3);
            },
          ),
          FlatButton(
            child: Text("图片文字"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STAlert.show(context, STAlertType.iconText, STAlertState.success,
                  STAlertRightButtonType.text, STAlertDisappearType.none,
                  text: "你说是就是你说是就是你说是就是你说是就是",
                  icon: "assets/images/basketball_check.png",
                  rightText: "你说是就",
                  width: 250, onRightTap: () {
                print('好的');
              }, disappearTime: 0);
            },
          ),
          FlatButton(
            child: Text("文字说明"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STAlert.show(
                  context,
                  STAlertType.textDescription,
                  STAlertState.alert,
                  STAlertRightButtonType.none,
                  STAlertDisappearType.auto,
                  text: "好的",
                  description: "好的好的好的好的好的好的好的好的好的",
                  width: 250, onRightTap: () {
                print('好的');
              }, disappearTime: 3);
            },
          ),
          FlatButton(
            child: Text("图片文字说明"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STAlert.show(
                  context,
                  STAlertType.iconTextDescription,
                  STAlertState.warning,
                  STAlertRightButtonType.icon,
                  STAlertDisappearType.auto,
                  text: "好的",
                  icon: "assets/images/basketball_check.png",
                  description: "好的好的好的好的好的好的好的好的好的",
                  rightIcon: "assets/images/basketball_check.png",
                  width: 250, onRightTap: () {
                print('好的');
              }, disappearTime: 3);
            },
          )
        ],
      ),
    );
  }
}
