import 'package:flutter/material.dart';

class STLoadingConstant {
  static const defaultWidth = 100.0; //默认宽度
  static const defaultHeight = 40.0; //默认宽度

  static const iconWidth = 40.0; //默认宽度

  static const cornerRadius = 4.0;

  static const textFontSize = 14.0;
}

class STLoading extends Dialog {
  final String icon;
  final String text;
  final bool iconUpperText;

  const STLoading({
    Key key,
    this.icon,
    this.text,
    this.iconUpperText = false,
  }) : super(key: key);

  static void show(
      {@required BuildContext context,
      String icon,
      String text,
      bool iconUpperText}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return STLoading(
              icon: icon, text: text, iconUpperText: iconUpperText);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    Text textWidget;
    if (text == null) {
    } else {
      textWidget = Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Image imageWidget;
    if (icon == null) {
    } else {
      imageWidget = Image.asset(icon,
          width: STLoadingConstant.iconWidth,
          height: STLoadingConstant.iconWidth,
          fit: BoxFit.contain);
    }

    if (icon == null) {
      if (text == null) {
      } else {
        widget = textWidget;
      }
    } else {
      if (text == null) {
        if (iconUpperText == true) {
          widget = Row(children: <Widget>[textWidget, imageWidget]);
        } else {
          widget = Column(children: <Widget>[textWidget, imageWidget]);
        }
      } else {
        widget = imageWidget;
      }
    }
    // TODO: implement build
    return Center(
      child: Container(
          width: STLoadingConstant.defaultWidth,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
                Radius.circular(STLoadingConstant.cornerRadius)),
          ),
          child: Container(
            width: STLoadingConstant.defaultWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xffAA1F52))),
              ],
            ),
          )),
    );
  }
}
