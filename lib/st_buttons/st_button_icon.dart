import 'package:flutter/material.dart';

import 'package:saturn/st_buttons/st_button_type_size_state.dart';
import 'package:saturn/st_buttons/st_button_enum.dart';

class STButtonIcon extends STButtonTypeSizeState {
  final Widget icon;
  final VoidCallback onPressed;
  final double width;
  final EdgeInsets padding;

  const STButtonIcon(
      {Key key,
      @required this.icon,
      this.onPressed,
      @required STButtonSize buttonSize,
      @required STButtonState buttonState,
      this.width,
      this.padding})
      : assert(icon != null),
        super(
            key: key,
            buttonSize: buttonSize,
            buttonState: buttonState,
            buttonType: STButtonType.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable == false ? onPressed : null,
      child: Container(
        width: width ?? STButtonConst.iconWidth,
        padding: padding ?? STButtonConst.iconPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
