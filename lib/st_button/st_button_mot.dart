import 'package:flutter/material.dart';
import 'package:saturn/st_button/st_button_size_state.dart';

import 'package:saturn/st_button/st_button.dart';
import 'package:saturn/st_color_utils.dart';

class STButtonMOT extends StatelessWidget with STButtonSizeState {
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
        color: stBackgroundColor(buttonState),
        borderRadius: BorderRadius.circular(radius ?? stSpace(buttonSize)),
      );
    }
    if (buttonType == STButtonType.outLine) {
      boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? stSpace(buttonSize)),
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
        constraints:
            BoxConstraints(minHeight: height ?? stDefaultHeight(buttonSize)),
        child: Container(
          width: width ?? stDefaultWidth(buttonSize),
          decoration: boxDecoration,
          padding: stEdgeInsets(buttonSize),
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
                      width: stSpace(buttonSize),
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

  bool get disable {
    if (buttonState == STButtonState.disable || onPressed == null) {
      return true;
    }
    return false;
  }
}
