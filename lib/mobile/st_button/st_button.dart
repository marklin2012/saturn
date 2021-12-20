import 'package:flutter/material.dart';

import 'package:saturn/mobile/st_button/base.dart';

// 按钮的样式
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
  final double loadingIconSize;
  final bool circle;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final MainAxisSize mainAxisSize;
  final bool debounce; // 是否防抖动
  final int debounceTime; // 防抖动时长
  final double height;

  const STButton({
    Key key,
    this.icon,
    this.text,
    this.textStyle,
    this.onTap,
    this.size = STButtonSize.large,
    this.type = STButtonType.primary,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.circle = false,
    this.disabled = false,
    this.loading = false,
    this.loadingIconSize = 24,
    this.debounce = true,
    this.debounceTime = 500,
    this.height,
  }) : super(key: key);

  const STButton.icon({
    Key key,
    @required this.icon,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.textStyle,
    this.size,
    this.onTap,
    this.text,
    this.type,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.circle = true,
    this.disabled = false,
    this.loading = false,
    this.loadingIconSize = 24,
    this.debounce = true,
    this.debounceTime = 500,
    this.height,
  })  : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return STButtonBase(
      key: key,
      icon: icon,
      text: text,
      padding: padding,
      textStyle: textStyle,
      onTap: onTap,
      size: size,
      type: type,
      disabled: disabled,
      loading: loading,
      loadingIconSize: loadingIconSize,
      radius: radius,
      circle: circle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      mainAxisSize: mainAxisSize,
      debounce: debounce,
      debounceTime: debounceTime,
      height: height,
    );
  }
}
