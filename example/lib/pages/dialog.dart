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
              );
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
                isDoubleButton: true,
              );
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
                  choiceList: [
                    ChoiceItem(
                        title: "选项一",
                        onItemTap: () {
                          print("好的");
                        }),
                    ChoiceItem(title: "选项二"),
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
                haveTextField: true,
              );
            },
          ),
          FlatButton(
            child: Text("message List"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  title: "是不是",
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  haveTextField: true,
                  type: STDialogType.list,
                  choiceList: [
                    ChoiceItem(
                      title: "好的",
                      haveSeparateLine: true,
                      isAligmentCenter: true,
                    ),
                    ChoiceItem(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                        haveSeparateLine: true,
                        isAligmentCenter: true),
                    ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                        haveSeparateLine: true,
                        isAligmentCenter: false),
                    ChoiceItem(
                      title: "好的",
                      icon: "assets/images/basketball_check.png",
                    ),
                    ChoiceItem(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    ChoiceItem(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                  ]);
            },
          ),
          FlatButton(
            child: Text("message dynamic List"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  message: "描述说明信息",
                  haveTextField: true,
                  type: STDialogType.dynamicList,
                  choiceList: [
                    [
                      ChoiceItem(
                        title: "好的",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      ChoiceItem(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      )
                    ],
                  ]);
            },
          ),
          FlatButton(
            child: Text("自定义"),
            color: Colors.blue,
            onPressed: () {
              STDialog.show(
                  context: context,
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  title: "这是一个标题",
                  type: STDialogType.normal);
            },
          ),
        ],
      ),
    );
  }
}
