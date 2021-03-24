import 'package:flutter/material.dart';

import 'package:saturn/st_button/st_button_mot.dart';
import 'package:saturn/st_button/st_button_icon.dart';

// 提供四种样式的按钮
enum STButtonType {
  main, // 实心主按钮
  outLine, // 描边按钮
  text, // 文本按钮
  icon, // 图形按钮
}

// 提供两种大小样式的按钮
enum STButtonSize {
  big,
  small,
}

// 提供六种状态样式的按钮
enum STButtonState {
  main, // 默认
  focus, // 点击
  loading, // 加载
  disable, // 禁用
  success, // 成功
  danger, // 危险
}

// 按钮相关常量
class STButtonConst {
  static const bigWidth = 172.0; // 大按钮的宽度
  static const smallWidth = 84.0; // 小按钮的宽度
  static const bigHeight = 38.0; // 大按钮的最小高度
  static const smallHeight = 24.0; // 小按钮的最小高度
  static const smallSpace = 4.0; // 小按钮中的间距以及圆角
  static const bigSpace = 8.0; // 大按钮中的间距以及圆角
  static const bigEdgetInset = EdgeInsets.fromLTRB(16, 6, 16, 6); // 大按钮内容的inset
  static const smallEdgetInset =
      EdgeInsets.fromLTRB(12, 3, 12, 3); // 小按钮内容的inset
  static const iconWidth = 44.0; // 图形按钮的宽度
  static const iconPadding = EdgeInsets.all(10); // 图形按钮的padding,图形与外部内容的inset
}

class STButton extends StatelessWidget {
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

  const STButton(
      {Key key,
      this.icon,
      this.label = 'button',
      this.style,
      this.onPressed,
      this.buttonSize = STButtonSize.big,
      this.buttonState = STButtonState.main,
      this.buttonType = STButtonType.main,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth,
      this.padding})
      : assert(buttonType != null),
        assert(buttonSize != null),
        assert(buttonState != null),
        assert(label != null),
        super(key: key);

  const STButton.icon(
      {Key key,
      @required this.icon,
      this.width,
      this.padding,
      this.buttonState,
      this.buttonSize,
      this.onPressed,
      this.label,
      this.style,
      this.buttonType = STButtonType.icon,
      this.height,
      this.radius,
      this.borderColor,
      this.borderWidth})
      : assert(icon != null),
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
