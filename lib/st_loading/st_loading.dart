import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends StatefulWidget {
  final String icon;
  final String text;
  final bool loading;
  final STLoadingDistributionType distributionType;
  final Color textColor;
  final bool showDefaultIcon;
  final int animationTime;

  const STLoading(
      {Key key,
      this.icon,
      this.text,
      this.loading = false,
      this.distributionType = STLoadingDistributionType.leftIconRightText,
      this.textColor = STLoadingConstant.defaultTextColor,
      this.showDefaultIcon = false,
      this.animationTime = STLoadingConstant.animationTime})
      : super(key: key);

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
        duration: Duration(seconds: widget.animationTime), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Text textWidget;
    if (!isNullOrEmpty(widget.text)) {
      textWidget = Text(widget.text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: widget.textColor,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Widget imageWidget;
    if (isNullOrEmpty(widget.icon)) {
      if (widget.showDefaultIcon) {
        imageWidget = Icon(
          Icons.autorenew,
          color: widget.textColor,
        );
      }
    } else {
      imageWidget = Image.asset(widget.icon,
          width: STLoadingConstant.iconWidth,
          height: STLoadingConstant.iconWidth,
          fit: BoxFit.contain);
    }

    if (imageWidget != null) {
      imageWidget = RotationTransition(turns: controller, child: imageWidget);
    }

    final bool haveTextAndIcon = (imageWidget != null) && (textWidget != null);

    if (widget.loading) {
      controller.forward();
    } else {
      controller.stop();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (haveTextAndIcon &&
              (widget.distributionType ==
                  STLoadingDistributionType.leftIconRightText))
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              imageWidget,
              const SizedBox(width: STLoadingConstant.iconTextDistance),
              textWidget
            ]),
          if (textWidget == null ||
              (haveTextAndIcon &&
                  (widget.distributionType ==
                      STLoadingDistributionType.topIconBottomText)))
            imageWidget,
          if (imageWidget == null ||
              (haveTextAndIcon &&
                  (widget.distributionType ==
                      STLoadingDistributionType.topIconBottomText)))
            textWidget,
        ],
      ),
    );
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
