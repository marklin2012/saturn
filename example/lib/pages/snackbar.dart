import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

const _textStyle1 = const TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: STSnackbarConstant.titleFontSize,
  decoration: TextDecoration.none,
);
const _textStyle2 = const TextStyle(
    fontWeight: FontWeight.w400,
    color: STSnackbarConstant.defaultMessageColor,
    fontSize: STSnackbarConstant.messageFontSize,
    decoration: TextDecoration.none);

class SnackbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbar'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('st_snackbar'),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("基本使用", style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                    onPressed: () {
                      STSnackbar.show(
                        context: context,
                        hasCloseButton: false,
                        title: "文字信息文字信息文字信息文字信息文字信息文字信息文字信息",
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child:
                        Text("含辅助性文字描述", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("含图标样式", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("含关闭操作", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("含按钮操作", style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("自定义样式", style: TextStyle(color: Colors.white)),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('easy_snackbar'),
                  SizedBox(height: 20),
                  STButton(
                    text: '基本使用',
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 56,
                          left: 20,
                          right: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        radius: 5,
                        title: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '文字信息文字信息文字信息',
                            style: _textStyle1,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  STButton(
                    text: '含辅助性文字描述',
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                          left: 20,
                          right: 20,
                        ),
                        padding: EdgeInsets.all(5),
                        title: Text(
                          '这是标题',
                          style: _textStyle1,
                        ),
                        message: Text(
                          '文字信息文字信息文字信息',
                          style: _textStyle2,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  STButton(
                    text: "含图标样式",
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        title: Text(
                          '这是标题',
                          style: _textStyle1,
                        ),
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/images/iconfont.png",
                              fit: BoxFit.fitWidth),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  STButton(
                    text: '含关闭操作',
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        title: Text(
                          '这是标题',
                          style: _textStyle1,
                        ),
                        message: Text(
                          '文字信息文字信息文字信息',
                          style: _textStyle2,
                        ),
                        closeButton: Icon(
                          STIcons.commonly_close,
                          size: 20,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  STButton(
                    text: "含按钮操作",
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        title: Text(
                          '这是标题',
                          style: _textStyle1,
                        ),
                        message: Text(
                          '文字信息文字信息文字信息',
                          style: _textStyle2,
                        ),
                        closeButton: Text(
                          'Button',
                          style: _textStyle1,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  STButton(
                    text: '自定义样式',
                    onTap: () {
                      EasySnackbar.show(
                        context: context,
                        title: Text(
                          '这是标题',
                          style: _textStyle1,
                        ),
                        message: Text(
                          '文字信息文字信息文字信息',
                          style: _textStyle2,
                        ),
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/images/iconfont.png",
                              fit: BoxFit.fitWidth),
                        ),
                        closeButton: Icon(
                          STIcons.commonly_close,
                          size: 20,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
