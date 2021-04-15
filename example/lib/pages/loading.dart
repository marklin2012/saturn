import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _isloading = true;
  Function(void Function()) _curSetState;

  void show({
    @required BuildContext context,
    String icon,
    String text,
    bool loading,
    STLoadingDistributionType distributionType =
        STLoadingDistributionType.leftIconRightText,
    Color textColor = STLoadingConstant.defaultTextColor,
    bool showDefaultIcon = false,
    int animationTime = STLoadingConstant.animationTime,
  }) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, theSetState) {
              _curSetState = theSetState;
              return GestureDetector(
                onTap: () {
                  hide(context);
                },
                child: STLoading(
                    icon: icon,
                    text: text,
                    loading: _isloading,
                    distributionType: distributionType,
                    showDefaultIcon: showDefaultIcon,
                    animationTime: animationTime),
              );
            },
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
            child: Text("左文字右图片"),
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
            child: Text("上文字下图片"),
            color: Colors.blue,
            onPressed: () {
              show(
                  context: context,
                  text: "正在加载中...",
                  icon: "assets/images/icon_selected_20x20.png",
                  loading: true,
                  distributionType:
                      STLoadingDistributionType.topIconBottomText);
              Future.delayed(Duration(seconds: 2), () {
                _curSetState(() {
                  _isloading = !_isloading;
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
