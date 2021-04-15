import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatelessWidget {
  static void show(
      {@required BuildContext context,
      String icon,
      String text,
      bool loading,
      STLoadingDistributionType distributionType =
          STLoadingDistributionType.leftIconRightText,
      Color textColor = STLoadingConstant.defaultTextColor,
      bool showDefaultIcon = false,
      int animationTime = STLoadingConstant.animationTime}) {
    STLoading _loading = STLoading(
        icon: icon,
        text: text,
        loading: loading,
        distributionType: distributionType,
        showDefaultIcon: showDefaultIcon,
        animationTime: animationTime);
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              hide(context);
            },
            child: _loading,
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
                loading: true,
              );
            },
          ),
          FlatButton(
            child: Text("上文字图片"),
            color: Colors.blue,
            onPressed: () {
              show(
                  context: context,
                  text: "正在加载中...",
                  icon: "assets/images/icon_selected_20x20.png",
                  loading: true,
                  distributionType:
                      STLoadingDistributionType.leftIconRightText);
            },
          ),
          FlatButton(
            child: Text("文字图片"),
            color: Colors.blue,
            onPressed: () {
              show(
                  context: context,
                  text: "正在加载中...",
                  icon: "assets/images/icon_selected_20x20.png",
                  loading: true,
                  distributionType:
                      STLoadingDistributionType.topIconBottomText);
            },
          ),
        ],
      ),
    );
  }
}
