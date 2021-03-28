import 'package:flutter/material.dart';

import 'package:saturn/st_button/base.dart';

// 提供四种风格
enum STButtonStyle {
  normal, // 实心主按钮
  outLine, // 描边按钮
  text, // 文本按钮
  icon, // 图形按钮
}
// 提供三种样式
enum STButtonType {
  normal, // 默认
  success, // 成功
  danger, // 危险
}
// 区分大小
enum STButtonSize {
  big,
  small,
}

class STButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final STButtonSize size;
  final STButtonStyle style;
  final STButtonType type;
  final bool disable;
  final bool loading;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  const STButton(
      {Key key,
      this.icon,
      this.text,
      this.textStyle,
      this.onTap,
      this.size = STButtonSize.big,
      this.style = STButtonStyle.normal,
      this.type = STButtonType.normal,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth,
      this.padding,
      this.disable = false,
      this.loading = false})
      : assert(type != null),
        assert(size != null),
        super(key: key);

  const STButton.icon(
      {Key key,
      @required this.icon,
      this.width,
      this.padding,
      this.textStyle,
      this.size,
      this.onTap,
      this.text,
      this.style = STButtonStyle.icon,
      this.type,
      this.height,
      this.radius,
      this.borderColor,
      this.borderWidth,
      this.disable = false,
      this.loading = false})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return STButtonBase(
      text: text,
      textStyle: textStyle,
      icon: icon,
      onTap: onTap,
      size: size,
      style: style,
      type: type,
      disable: disable,
      loading: loading,
      height: height,
      width: width,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }
}
