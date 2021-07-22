import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_icons/st_icons.dart';

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
              FlatButton(
                child: Text("基本使用"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      message: "文字信息文字信息文字信息",
                      autoClose: true);
                },
              ),
              FlatButton(
                child: Text("含图标样式"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                    context: context,
                    icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/images/iconfont.png",
                            fit: BoxFit.fitWidth)),
                    message: "文字信息文字信息文字信息",
                    isIconTop: false,
                  );
                },
              ),
              FlatButton(
                child: Text("显示状态"),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      icon: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/iconfont.png",
                              fit: BoxFit.fitWidth)),
                      message: "手机号修改成功",
                      isIconTop: true);
                },
              ),
              FlatButton(
                child: Text("加载中的样式"),
                color: Colors.blue,
                onPressed: () {
                  STToast.showLoading(
                      context: context,
                      icon: Icon(
                        STIcons.status_loading,
                        color: Colors.white,
                      ),
                      position: STToastPosition.center);
                },
              ),
            ],
          ),
        ));
  }
}
