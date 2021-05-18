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
                  onMakeSureTap: (text, list) {
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
                hasCancelButton: true,
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
                hasTextField: true,
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
                  hasTextField: true,
                  hasCancelButton: true,
                  isSingleSelect: false,
                  type: STDialogType.list,
                  options: [
                    STDialogOption(
                      title: "好的",
                      hasSeparateLine: true,
                      isAligmentCenter: true,
                    ),
                    STDialogOption(
                      title: "好的",
                      hasSeparateLine: true,
                      isAligmentCenter: false,
                      isRadio: true,
                    ),
                    STDialogOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                        hasSeparateLine: true,
                        isAligmentCenter: true),
                    STDialogOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                        hasSeparateLine: true,
                        isAligmentCenter: false),
                    STDialogOption(
                      title: "好的",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STDialogOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STDialogOption(
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
                  hasTextField: true,
                  type: STDialogType.dynamicList,
                  options: [
                    [
                      STDialogOption(
                          title: "好的",
                          icon: "assets/images/basketball_check.png",
                          onTap: () {
                            print("好的");
                          }),
                      STDialogOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STDialogOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STDialogOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STDialogOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STDialogOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STDialogOption(
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
                  hasCancelButton: true,
                  type: STDialogType.normal);
            },
          ),
        ],
      ),
    );
  }
}
