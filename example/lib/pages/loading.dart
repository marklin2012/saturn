import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatelessWidget {
  static void show({
    @required BuildContext context,
    String icon,
    String gifIcon,
    String text,
    Color themeColor,
    bool showDefaultIcon = false,
    bool iconUpperText = false,
  }) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          STLoading loading = STLoading(
            icon: icon,
            gifIcon: gifIcon,
            text: text,
            showDefaultIcon: showDefaultIcon,
            iconUpperText: iconUpperText,
          );
          return GestureDetector(
            onTap: () {
              hide(context);
            },
            child: loading,
          );
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

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
              show(
                context: context,
                text: "正在加载中...",
              );
            },
          ),
          FlatButton(
            child: Text("图片"),
            color: Colors.blue,
            onPressed: () {
              show(
                context: context,
                icon: "assets/images/icon_selected_20x20.png",
              );
            },
          ),
          FlatButton(
            child: Text("gif"),
            color: Colors.blue,
            onPressed: () {
              show(context: context, gifIcon: "assets/images/1.gif");
            },
          ),
          FlatButton(
            child: Text("文字图片"),
            color: Colors.blue,
            onPressed: () {
              show(
                context: context,
                iconUpperText: true,
                text: "正在加载中...",
                icon: "assets/images/icon_selected_20x20.png",
              );
            },
          ),
          FlatButton(
            child: Text("文字Gif"),
            color: Colors.blue,
            onPressed: () {
              show(
                  context: context,
                  iconUpperText: true,
                  text: "正在加载中...",
                  gifIcon: "assets/images/1.gif");
            },
          ),
        ],
      ),
    );
  }
}
