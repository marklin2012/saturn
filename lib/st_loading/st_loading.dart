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
    Widget widget;

    Color curThemeColor;
    if (this.widget.themeColor == null) {
      if (this.widget.showBackground) {
        curThemeColor = Colors.white;
      } else {
        curThemeColor = Colors.black;
      }
    } else {
      curThemeColor = this.widget.themeColor;
    }

    Text textWidget;
    if (this.widget.text != null) {
      textWidget = Text(this.widget.text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: curThemeColor,
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
      } else {
        imageWidget = RotationTransition(
            turns: controller,
            child: Icon(
              Icons.autorenew,
              color: curThemeColor,
            ));
      }
    }

    if ((this.widget.icon == null) && (this.widget.gifIcon == null)) {
      if (this.widget.text != null) {
        if (this.widget.showDefaultIcon) {
          widget = Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: 5),
            textWidget,
          ]);
        } else {
          widget = textWidget;
        }
      } else {
        if (this.widget.showDefaultIcon) {
          widget = imageWidget;
        }
      }
    } else {
      if (this.widget.text == null) {
        widget = imageWidget;
      } else {
        if (this.widget.iconUpperText == true) {
          widget = Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget,
          ]);
        } else {
          widget = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget
          ]);
        }
      }
    }

    if (this.widget.showBackground) {
      return Center(
        child: Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STLoadingConstant.cornerRadius),
            color: STLoadingConstant.defaultBackgroundColor,
          ),
          child: Center(child: widget),
        ),
      );
    } else {
      return Center(child: widget);
    }
  }
}
