import 'package:flutter/material.dart';

import 'package:saturn/st_buttons/st_buttons.dart';

class STButtonIcon extends STBtnTypeSizeState {
  final Widget icon;
  final VoidCallback onPressed;
  final STButtonSize btnSize;
  final STButtonState btnState;
  final double width;
  final EdgeInsets padding;

  const STButtonIcon(
      {Key key,
      @required this.icon,
      this.onPressed,
      this.btnSize,
      this.btnState,
      this.width = STBtnIconW,
      this.padding = STBtnIconPadding})
      : super(
            key: key,
            btnSize: btnSize,
            btnState: btnState,
            btnType: STButtonType.Icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
      onTap: disable == false ? onPressed : null,
    );
  }
}
