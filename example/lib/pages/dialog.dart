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
                  hasCancelButton: true,
                  onCancelTap: () {
                    STToast.show(
                        context: context,
                        message: "这是一个message这是一个message这是一个message这是一个message",
                        autoClose: true);
                  });
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
                  cancelTitle: "取消",
                  hasCancelButton: true,
                  hasConfirmButton: true);
            },
          ),
          FlatButton(
            child: Text("icon文字"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                context: context,
                icon: Image.asset("assets/images/basketball_check.png",
                    fit: BoxFit.fitWidth),
                message: "描述说明信息",
              );
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
                  hasCancelButton: false,
                  hasConfirmButton: false,
                  options: [
                    STDialogOption(
                      title: "选项一",
                      onTap: () {
                        STToast.show(
                            context: context,
                            message:
                                "这是一个message这是一个message这是一个message这是一个message",
                            autoClose: true);
                      },
                    ),
                    STDialogOption(title: "选项二"),
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
                  cancelTitle: "取消",
                  hasTextField: true,
                  hasConfirmButton: true,
                  onConfirmTap: (text) {
                    print(text);
                  });
            },
          ),
        ],
      ),
    );
  }
}
