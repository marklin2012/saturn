import 'package:flutter/material.dart';

class STRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor; // 内部颜色
  final Color backgroundColor; // 背景颜色
  final Color borderColor; // 边框颜色
  final String text;
  final bool disabled;
  final double internalDiameter; // 内径
  final double externalDiameter; // 外径
  final double space; // 文字与图的间距
  final TextStyle textStyle; // 文字的样式
  final EdgeInsets padding; // 内边距

  const STRadio({
    Key key,
    this.value,
    this.groupValue,
    this.onChanged,
    this.activeColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF095BF9),
    this.borderColor = const Color(0xFF888888),
    this.text,
    this.disabled = false,
    this.internalDiameter = 12.0,
    this.externalDiameter = 24.0,
    this.space = 12.0,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 17.0),
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
  }) : super(key: key);

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Opacity(
        opacity: disabled ? 0.2 : 1.0,
        child: GestureDetector(
          onTap: () => disabled ? null : onChanged(value),
          child: Row(
            children: [
              _getChild(),
              if (text != null) SizedBox(width: space),
              if (text != null) Text(text, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChild() {
    if (disabled || !_selected) {
      return Container(
        height: externalDiameter,
        width: externalDiameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: externalDiameter,
            width: externalDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
          ),
          Container(
            height: internalDiameter,
            width: internalDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
          )
        ],
      );
    }
  }
}
