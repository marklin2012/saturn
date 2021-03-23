import 'package:flutter/material.dart';

import 'package:saturn/st_button/st_buttons.dart';
import 'package:saturn/st_color_utils.dart';

class STButtonMOT extends StatelessWidget {
  final Widget icon;
  final String label;
  final TextStyle style;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final STButtonType buttonType;
  final STButtonSize buttonSize;
  final STButtonState buttonState;

  const STButtonMOT(
      {Key key,
      this.icon,
      @required this.label,
      this.style,
      this.onPressed,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth,
      @required this.buttonType,
      @required this.buttonSize,
      @required this.buttonState})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = const BoxDecoration();
    if (buttonType == STButtonType.main) {
      boxDecoration = BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? space),
      );
    }
    if (buttonType == STButtonType.outLine) {
      boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? space),
        border: Border.all(
          color: borderColor ?? firRankBlue,
          width: borderWidth ?? 1,
        ),
      );
    }
    var _icon = icon;
    if (buttonState == STButtonState.loading && _icon == null) {
      _icon = const Icon(
        Icons.refresh,
        color: colorWhite,
      );
    }
    return GestureDetector(
      onTap: disable == false ? onPressed : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height ?? defaultHeight),
        child: Container(
          width: width ?? defaultWidth,
          decoration: boxDecoration,
          padding: edgeInsets,
          alignment: Alignment.center,
          child: _icon == null
              ? Text(
                  label,
                  style: style ?? const TextStyle(color: thrRankFont),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _icon,
                    SizedBox(
                      width: space,
                    ),
                    Text(
                      label,
                      style: style ?? const TextStyle(color: thrRankFont),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Color get backgroundColor {
    if (buttonState == STButtonState.success) {
      return assistGreen;
    }
    if (buttonState == STButtonState.danger) {
      return assistRed;
    }
    if (buttonState == STButtonState.focus) {
      return secRankBlue;
    }
    if (buttonState == STButtonState.disable) {
      return fourRankBlue;
    }
    return firRankBlue;
  }

  bool get disable {
    if (buttonState == STButtonState.disable || onPressed == null) {
      return true;
    }
    return false;
  }

  double get defaultHeight {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallHeight;
    }
    return STButtonConst.bigHeight;
  }

  double get defaultWidth {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallWidth;
    }
    return STButtonConst.bigWidth;
  }

  double get space {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallSpace;
    }
    return STButtonConst.bigSpace;
  }

  EdgeInsets get edgeInsets {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallEdgetInset;
    }
    return STButtonConst.bigEdgetInset;
  }
}
