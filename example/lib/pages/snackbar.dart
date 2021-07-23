import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SnackbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Snackbar'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Text("基本使用"),
                color: Colors.blue,
                onPressed: () {
                  STSnackbar.show(
                    context: context,
                    hasCloseButton: false,
                    title: "文字信息文字信息文字信息文字信息文字信息文字信息文字信息",
                  );
                },
              ),
              FlatButton(
                child: Text("含辅助性文字描述"),
                color: Colors.blue,
                onPressed: () {
                  STSnackbar.show(
                    context: context,
                    title: "这是标题",
                    message: "文字信息文字信息",
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("含图标样式"),
                color: Colors.blue,
                onPressed: () {
                  STSnackbar.show(
                    context: context,
                    title: "文字信息文字信息",
                    icon: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/images/iconfont.png",
                            fit: BoxFit.fitWidth)),
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("含关闭操作"),
                color: Colors.blue,
                onPressed: () {
                  STSnackbar.show(
                    context: context,
                    title: "这是标题",
                    message: "文字信息文字信息",
                    hasCloseButton: true,
                  );
                },
              ),
              FlatButton(
                child: Text("含按钮操作"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "这是标题",
                    message: "文字信息文字信息",
                    hasCloseButton: true,
                    buttonText: "Button",
                    isButtonHasBackground: true,
                  );
                },
              ),
              FlatButton(
                child: Text("自定义样式"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "这是标题",
                    message: "文字信息文字信息",
                    hasCloseButton: true,
                    icon: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/images/iconfont.png",
                            fit: BoxFit.fitWidth)),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
