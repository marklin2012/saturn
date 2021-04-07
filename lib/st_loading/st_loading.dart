import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends StatefulWidget {
  final String icon;
  final String gifIcon;
  final String text;
  final Color themeColor;
  final bool showDefaultIcon; //show default icon 只有在icon 和 gificon都为空时，设置才有效
  final bool iconUpperText;
  final bool showBackground;

  const STLoading({
    Key key,
    this.icon,
    this.gifIcon,
    this.text,
    this.themeColor,
    this.showDefaultIcon,
    this.iconUpperText,
    this.showBackground,
  }) : super(key: key);

  static void show(
      {@required BuildContext context,
      String icon,
      String gifIcon,
      String text,
      Color themeColor,
      bool showDefaultIcon = false,
      bool iconUpperText = false,
      bool showBackground = false}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return STLoading(
            icon: icon,
            gifIcon: gifIcon,
            text: text,
            showDefaultIcon: showDefaultIcon,
            iconUpperText: iconUpperText,
            showBackground: showBackground,
          );
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
    Widget returnWidget;

    Color curThemeColor;
    if (widget.themeColor == null) {
      if (widget.showBackground) {
        curThemeColor = Colors.white;
      } else {
        curThemeColor = Colors.black;
      }
    } else {
      curThemeColor = widget.themeColor;
    }

    Text textWidget;
    if (widget.text != null) {
      textWidget = Text(widget.text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: curThemeColor,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Widget imageWidget;
    if (widget.icon != null) {
      imageWidget = RotationTransition(
          turns: controller,
          child: Image.asset(widget.icon,
              width: STLoadingConstant.iconWidth,
              height: STLoadingConstant.iconWidth,
              fit: BoxFit.contain));
    } else {
      if (widget.gifIcon != null) {
        imageWidget = Image.asset(widget.gifIcon,
            width: STLoadingConstant.iconWidth,
            height: STLoadingConstant.iconWidth,
            fit: BoxFit.contain);
      } else {
        imageWidget = RotationTransition(
            turns: controller,
            child: Icon(
              Icons.autorenew,
              color: curThemeColor,
            ));
      }
    }

    if (isNullOrEmpty(widget.icon) && isNullOrEmpty(widget.gifIcon)) {
      if (!isNullOrEmpty(widget.text)) {
        if (widget.showDefaultIcon) {
          returnWidget =
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: 5),
            textWidget,
          ]);
        } else {
          returnWidget = textWidget;
        }
      } else {
        if (widget.showDefaultIcon) {
          returnWidget = imageWidget;
        }
      }
    } else {
      if (isNullOrEmpty(widget.text)) {
        returnWidget = imageWidget;
      } else {
        if (widget.iconUpperText == true) {
          returnWidget =
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget,
          ]);
        } else {
          returnWidget = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget
          ]);
        }
      }
    }

    if (widget.showBackground) {
      return Center(
        child: Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STLoadingConstant.cornerRadius),
            color: STLoadingConstant.defaultBackgroundColor,
          ),
          child: Center(child: returnWidget),
        ),
      );
    } else {
      return Center(child: returnWidget);
    }
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
