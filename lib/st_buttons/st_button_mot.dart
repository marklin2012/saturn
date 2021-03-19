import 'package:flutter/material.dart';

import 'package:saturn/st_buttons/st_buttons.dart';
import 'package:saturn/st_color_utils.dart';

class STButtonMOT extends STBtnTypeSizeState {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;
  final STButtonSize btnSize;
  final STButtonState btnState;
  final STButtonType btnType;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  const STButtonMOT(
      {Key key,
      this.icon,
      @required this.label,
      this.onPressed,
      this.btnSize,
      this.btnState,
      this.btnType,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth})
      : super(key: key, btnSize: btnSize, btnState: btnState, btnType: btnType);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration();
    if (btnType == STButtonType.Main) {
      boxDecoration = BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? space),
      );
    }
    if (btnType == STButtonType.OutLine) {
      boxDecoration = BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius ?? space),
        border: Border.all(
          color: borderColor ?? firRankBlue,
          width: borderWidth ?? 1,
        ),
      );
    }
    var _icon = icon;
    if (btnState == STButtonState.Loading && _icon == null) {
      _icon = Icon(
        Icons.refresh,
        color: colorWhite,
      );
    }
    return GestureDetector(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height ?? btnH),
        child: Container(
          width: width ?? btnW,
          decoration: boxDecoration,
          padding: edgeInsets,
          alignment: Alignment.center,
          child: _icon == null
              ? label
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _icon,
                    SizedBox(
                      width: space,
                    ),
                    label
                  ],
                ),
        ),
      ),
      onTap: disable == false ? onPressed : null,
    );
  }
}
