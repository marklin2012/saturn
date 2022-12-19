import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
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
                text: "提示弹框",
                onTap: () {
                  STDialog.show(
                      context: context,
                      title: "标题标题",
                      message: "描述说明信息",
                      hasCancelButton: true,
                      onCancelTap: () {});
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "确认弹框",
                onTap: () {
                  STDialog.show(
                      context: context,
                      title: "标题标题",
                      message: "描述说明信息",
                      cancelTitle: "取消",
                      hasCancelButton: true,
                      hasConfirmButton: true);
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "含图标弹框",
                onTap: () {
                  STDialog.show(
                    context: context,
                    icon: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/iconfont.png",
                            fit: BoxFit.fitWidth)),
                    message: "描述说明信息",
                  );
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "含选项弹框",
                onTap: () {
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
              SizedBox(height: 20),
              STButton(
                text: "可自定义",
                onTap: () {
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
        ),
      ),
    );
  }
}
