import 'package:flutter/material.dart';
import 'package:saturn/st_button/st_button_size_state.dart';

import 'package:saturn/st_button/st_button.dart';

class STButtonIcon extends StatelessWidget with STButtonSizeState {
  final Widget icon;
  final VoidCallback onPressed;
  final double width;
  final EdgeInsets padding;
  final STButtonSize buttonSize;
  final STButtonState buttonState;

  const STButtonIcon(
      {Key key,
      @required this.icon,
      this.onPressed,
      this.buttonSize,
      this.buttonState,
      this.width,
      this.padding})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable == false ? onPressed : null,
      child: Container(
        width: width ?? STButtonConst.iconWidth,
        padding: padding ?? STButtonConst.iconPadding,
        decoration: BoxDecoration(
          color: stBackgroundColor(buttonState),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

  bool get disable {
    if (buttonState == STButtonState.disable || onPressed == null) {
      return true;
    }
    return false;
  }
}
