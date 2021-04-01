import 'package:flutter/material.dart';

import 'package:saturn/st_button/base.dart';

// 提供三种样式
enum STButtonType {
  primary, // 主按钮
  outline, // 描边按钮
  text, // 纯文本按钮
  success, // 成功
  danger, // 危险
}
// 区分大小
enum STButtonSize {
  large,
  small,
}

class STButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final STButtonSize size;
  final STButtonType type;
  final bool disabled;
  final bool loading;
  final bool circle;
  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  const STButton(
      {Key key,
      this.icon,
      this.text,
      this.textStyle,
      this.onTap,
      this.size = STButtonSize.large,
      this.type = STButtonType.primary,
      this.height,
      this.width,
      this.radius,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.padding,
      this.circle = false,
      this.disabled = false,
      this.loading = false})
      : super(key: key);

  const STButton.icon(
      {Key key,
      @required this.icon,
      this.width,
      this.padding,
      this.textStyle,
      this.size,
      this.onTap,
      this.text,
      this.type,
      this.height,
      this.radius,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.circle = true,
      this.disabled = false,
      this.loading = false})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return STButtonBase(
      key: key,
      icon: icon,
      text: text,
      textStyle: textStyle,
      onTap: onTap,
      size: size,
      type: type,
      disabled: disabled,
      loading: loading,
      height: height,
      width: width,
      radius: radius,
      circle: circle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }
}
