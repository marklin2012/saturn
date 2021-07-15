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
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: false,
                isButtonHasBackground: false,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "文字信息文字信息文字信息文字信息文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: false,
                isButtonHasBackground: false,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "这是标题",
                message: "文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                buttonText: "Button",
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "文字信息文字信息文字信息文字信息文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                buttonText: "Button",
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "这是标题",
                message: "文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                buttonText: "Button",
                isButtonHasBackground: false,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "文字信息文字信息文字信息文字信息文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                buttonText: "Button",
                isButtonHasBackground: false,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "这是标题",
                message: "文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "文字信息文字信息文字信息文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                hasCloseButton: true,
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "这是标题",
                message: "文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                icon: Icon(Icons.error, color: Colors.white),
                hasCloseButton: true,
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "文字信息文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              SizedBox(height: 20),
              STSnackbar(
                icon: Icon(Icons.error, color: Colors.white),
                hasCloseButton: true,
                isButtonHasBackground: true,
                disappearMilliseconds:
                    STSnackbarConstant.defaultDisappearMilliseconds,
                title: "这是标题",
                message: "文字信息文字信息",
                autoClose: false,
                hasSafeArea: true,
              ),
              FlatButton(
                child: Text("标题"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                  );
                },
              ),
              FlatButton(
                child: Text("标题"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("标题文字"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说",
                    message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("icon标题文字"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说",
                    message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                    icon: Icon(Icons.error, color: Colors.white),
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("image标题文字"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说",
                    message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                    icon: Image.asset("assets/images/basketball_check.png",
                        fit: BoxFit.fitWidth),
                    hasCloseButton: false,
                  );
                },
              ),
              FlatButton(
                child: Text("标题close"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                      context: context,
                      title: "你说是就是你说你说是就是你说",
                      hasCloseButton: true,
                      onButtonTap: () {
                        print("好的");
                      });
                },
              ),
              FlatButton(
                child: Text("标题button"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                      context: context,
                      title: "你说是就是你说你说是就是你说",
                      buttonText: "文字按钮",
                      onButtonTap: () {
                        print("好的");
                      });
                },
              ),
              FlatButton(
                child: Text("标题button背景"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                    context: context,
                    title: "你说是就是你说你说是就是你说",
                    buttonText: "文字按钮",
                    isButtonHasBackground: true,
                  );
                },
              ),
              FlatButton(
                child: Text("icon标题button背景"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                      context: context,
                      title: "你说是就是你说你说是就是你说",
                      buttonText: "文字按钮",
                      isButtonHasBackground: true,
                      icon: Icon(Icons.error, color: Colors.white));
                },
              ),
              FlatButton(
                child: Text("icon标题文字button背景"),
                color: Colors.blue,
                onPressed: () {
                  // send();
                  // SocketManage.send(textEditController.text);

                  STSnackbar.show(
                      context: context,
                      title: "你说是就是你说你说是就是你说",
                      message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                      buttonText: "文字按钮",
                      isButtonHasBackground: true,
                      icon: Icon(Icons.error, color: Colors.white));
                },
              )
            ],
          ),
        ));
  }
}
