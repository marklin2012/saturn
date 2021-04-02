import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends Dialog {
  final String icon;
  final String gifIcon;
  final String text;
  final bool iconUpperText;

  const STLoading({
    Key key,
    this.icon,
    this.gifIcon,
    this.text,
    this.iconUpperText = false,
  }) : super(key: key);

  static void show(
      {@required BuildContext context,
      String icon,
      String gifIcon,
      String text,
      bool iconUpperText}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return STLoading(
              icon: icon,
              gifIcon: gifIcon,
              text: text,
              iconUpperText: iconUpperText);
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    Text textWidget;
    if (!(text == null)) {
      textWidget = Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Image imageWidget;
    if (!(icon == null)) {
      imageWidget = Image.asset(icon,
          width: STLoadingConstant.iconWidth,
          height: STLoadingConstant.iconWidth,
          fit: BoxFit.contain);
    } else {
      if (!(gifIcon == null)) {
        imageWidget = Image.asset(gifIcon,
            width: STLoadingConstant.iconWidth,
            height: STLoadingConstant.iconWidth,
            fit: BoxFit.contain);
      }
    }

    if ((icon == null) && (gifIcon == null)) {
      if (!(text == null)) {
        widget = textWidget;
      }
    } else {
      if (text == null) {
        widget = imageWidget;
      } else {
        if (iconUpperText == true) {
          widget = Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: 5),
            textWidget,
          ]);
        } else {
          widget = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: 5),
            textWidget
          ]);
        }
      }
    }
    // TODO: implement build
    return Center(child: widget);
  }
}
