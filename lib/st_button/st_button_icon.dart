import 'package:flutter/material.dart';

import 'package:saturn/st_button/st_buttons.dart';
import 'package:saturn/st_color_utils.dart';

class STButtonIcon extends StatelessWidget {
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
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon,
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
