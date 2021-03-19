import 'package:flutter/material.dart';

import 'package:saturn/st_buttons/st_button_mot.dart';
import 'package:saturn/st_buttons/st_button_icon.dart';
import 'package:saturn/st_buttons/st_button_enum.dart';

class STButtons extends StatelessWidget {
  final Widget icon;
  final String label;
  final TextStyle style;
  final VoidCallback onPressed;
  final STButtonSize buttonSize;
  final STButtonState buttonState;
  final STButtonType buttonType;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  const STButtons(
      {Key key,
      this.icon,
      this.label,
      this.style,
      this.onPressed,
      this.buttonSize,
      this.buttonState,
      @required this.buttonType,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth,
      this.padding})
      : assert(buttonType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (buttonType == STButtonType.icon) {
      return STButtonIcon(
        icon: icon,
        width: width,
        padding: padding,
        buttonSize: buttonSize,
        buttonState: buttonState,
        onPressed: onPressed,
      );
    } else {
      return STButtonMOT(
        label: label,
        icon: icon,
        style: style,
        onPressed: onPressed,
        buttonSize: buttonSize,
        buttonState: buttonState,
        buttonType: buttonType,
        height: height,
        width: width,
        radius: radius,
        borderColor: borderColor,
        borderWidth: borderWidth,
      );
    }
  }
}
