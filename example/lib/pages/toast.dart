import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ToastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Toast'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              STToast(
                type: STToastType.none,
                position: STToastPosition.center,
                closable: false,
                autoClose: false,
                disappearMilliseconds:
                    STToastConstant.defaultDisappearMilliseconds,
                hasSafeArea: true,
                message: "这是一条文字提示",
              ),
              STToast(
                type: STToastType.none,
                closable: false,
                autoClose: false,
                hasSafeArea: true,
                rotateAnimation: false,
                disappearMilliseconds:
                    STToastConstant.defaultDisappearMilliseconds,
                isIconTop: false,
                icon: Icon(
                  Icons.info_outline,
                  size: STMessageConstant.iconWidth,
                  color: Colors.white,
                ),
                message: "带图标的文字提示",
                position: STToastPosition.bottom,
              ),
              STToast(
                type: STToastType.success,
                closable: false,
                autoClose: false,
                hasSafeArea: true,
                rotateAnimation: false,
                disappearMilliseconds:
                    STToastConstant.defaultDisappearMilliseconds,
                isIconTop: true,
                message: "成功文字信息",
                position: STToastPosition.bottom,
              ),
              STToast(
                type: STToastType.warning,
                closable: false,
                autoClose: false,
                hasSafeArea: true,
                rotateAnimation: false,
                disappearMilliseconds:
                    STToastConstant.defaultDisappearMilliseconds,
                isIconTop: true,
                message: "失败文字信息",
                position: STToastPosition.bottom,
              ),
              STToast(
                type: STToastType.error,
                closable: false,
                autoClose: false,
                hasSafeArea: true,
                rotateAnimation: false,
                disappearMilliseconds:
                    STToastConstant.defaultDisappearMilliseconds,
                isIconTop: true,
                message: "错误文字信息",
                position: STToastPosition.bottom,
              ),
              FlatButton(
                child: Text("文字"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                    context: context,
                    message: "这是一个message这是一个message这是一个message这是一个message",
                  );
                },
              ),
              FlatButton(
                child: Text("文字"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      message: "这是一个message这是一个message这是一个message这是一个message",
                      autoClose: true);
                },
              ),
              FlatButton(
                child: Text("左文字图片位置下"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      icon: Image.asset("assets/images/basketball_check.png",
                          fit: BoxFit.fitWidth),
                      message: "这是一个message这是一个message这是一个message这是一个message",
                      position: STToastPosition.bottom,
                      closable: true);
                  ;
                },
              ),
              FlatButton(
                child: Text("图片"),
                color: Colors.blue,
                onPressed: () {
                  STToast.showLoading(
                      context: context,
                      icon: Icon(Icons.error_outline, color: Colors.white),
                      position: STToastPosition.center);
                },
              ),
              FlatButton(
                child: Text("上文字图片"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      icon: Image.asset("assets/images/basketball_check.png",
                          fit: BoxFit.fitWidth),
                      message: "这是一个message这是一个message这是一个message这是一个message",
                      isIconTop: true);
                },
              ),
            ],
          ),
        ));
  }
}
