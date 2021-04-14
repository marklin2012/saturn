import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class DialogPage extends StatelessWidget {
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
              STDialog.show(
                  context: context,
                  title: "标题标题",
                  message: "描述说明信息",
                  dialogType: STDialogDialogType.title);
            },
          ),
          FlatButton(
            child: Text("文字双button"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  title: "标题标题",
                  message: "描述说明信息",
                  dialogType: STDialogDialogType.doubleButton);
            },
          ),
          FlatButton(
            child: Text("icon文字"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  dialogType: STDialogDialogType.icon);
            },
          ),
          FlatButton(
            child: Text("文字list"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  title: "标题标题",
                  message: "描述说明信息",
                  dialogType: STDialogDialogType.list,
                  choiceList: [
                    {
                      "text": "选项一",
                      "action": () {
                        print("好的");
                      }
                    },
                    {
                      "text": "选项二",
                    }
                  ]);
            },
          ),
          FlatButton(
            child: Text("文字textfiled"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  title: "标题标题",
                  message: "描述说明信息",
                  dialogType: STDialogDialogType.textField);
            },
          ),
        ],
      ),
    );
  }
}
