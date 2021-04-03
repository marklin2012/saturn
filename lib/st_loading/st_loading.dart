import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends StatefulWidget {
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
  _STLoadingState createState() => _STLoadingState();
}

class _STLoadingState extends State<STLoading>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(seconds: STLoadingConstant.animationTime),
        vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    Text textWidget;
    if (this.widget.text != null) {
      textWidget = Text(this.widget.text,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Widget imageWidget;
    if (this.widget.icon != null) {
      imageWidget = RotationTransition(
          turns: controller,
          child: Image.asset(this.widget.icon,
              width: STLoadingConstant.iconWidth,
              height: STLoadingConstant.iconWidth,
              fit: BoxFit.contain));
    } else {
      if (this.widget.gifIcon != null) {
        imageWidget = Image.asset(this.widget.gifIcon,
            width: STLoadingConstant.iconWidth,
            height: STLoadingConstant.iconWidth,
            fit: BoxFit.contain);
      }
    }

    if ((this.widget.icon == null) && (this.widget.gifIcon == null)) {
      if (!(this.widget.text == null)) {
        widget = textWidget;
      }
    } else {
      if (this.widget.text == null) {
        widget = imageWidget;
      } else {
        if (this.widget.iconUpperText == true) {
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
