import 'package:flutter/material.dart';

import 'package:saturn/st_button/base.dart';

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

class STButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final TextStyle style;
  final VoidCallback onTap;
  final STButtonSize size;
  final STButtonState state;
  final STButtonType type;
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
      this.style,
      this.onTap,
      this.size = STButtonSize.big,
      this.state = STButtonState.main,
      this.type = STButtonType.main,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.borderWidth,
      this.padding})
      : assert(type != null),
        assert(size != null),
        assert(state != null),
        super(key: key);

  const STButton.icon(
      {Key key,
      @required this.icon,
      this.width,
      this.padding,
      this.state,
      this.size,
      this.onTap,
      this.text,
      this.style,
      this.type = STButtonType.icon,
      this.height,
      this.radius,
      this.borderColor,
      this.borderWidth})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return STButtonBase(
      text: text,
      icon: icon,
      style: style,
      onTap: onTap,
      size: size,
      state: state,
      type: type,
      height: height,
      width: width,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }
}
