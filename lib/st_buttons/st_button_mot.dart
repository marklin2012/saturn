import 'package:flutter/material.dart';

import 'package:saturn/st_buttons/st_button_type_size_state.dart';
import 'package:saturn/st_color_utils.dart';
import 'package:saturn/st_buttons/st_button_enum.dart';

class STButtonMOT extends STButtonTypeSizeState {
  final Widget icon;
  final String label;
  final TextStyle style;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  const STButtonMOT(
      {Key key,
      this.icon,
      @required this.label,
      this.style,
      this.onPressed,
      @required STButtonSize buttonSize,
      @required STButtonState buttonState,
      STButtonType buttonType,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth})
      : assert(label != null),
        super(
            key: key,
            buttonSize: buttonSize,
            buttonState: buttonState,
            buttonType: buttonType);

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
}
