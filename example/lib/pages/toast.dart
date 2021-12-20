import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';

class ToastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toast'),
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
              FlatButton(
                child: Text("基本使用", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STToast.show(
                      context: context,
                      message: "文字信息文字信息文字信息",
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("含图标样式", style: TextStyle(color: Colors.white)),
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
              SizedBox(height: 20),
              FlatButton(
                child: Text("显示状态", style: TextStyle(color: Colors.white)),
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
              SizedBox(height: 20),
              FlatButton(
                child: Text("加载中的样式", style: TextStyle(color: Colors.white)),
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
        ),
      ),
    );
  }
}
