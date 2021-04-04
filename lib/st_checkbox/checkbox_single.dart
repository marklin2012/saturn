import 'package:flutter/material.dart';

class STCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor; // 内部颜色
  final Color borderColor; // 边框颜色
  final String text;
  final bool disabled;
  final double boxWidth; // 框的宽度
  final double space; // 文字与图的间距
  final TextStyle textStyle; // 文字的样式
  final EdgeInsets padding; // 内边距
  final double radius; // 框的圆角半径
  final Color iconColor; // 图片颜色
  final String iconPath; // 图片的路径
  final String iconPackage; // 包名
  final Size iconSize;

  const STCheckBox({
    Key key,
    this.value,
    this.onChanged,
    this.activeColor = const Color(0xFF095BF9),
    this.borderColor = const Color(0xFF888888),
    this.text,
    this.disabled = false,
    this.space = 12.0,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 17.0),
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    this.iconColor = const Color(0xFFFFFFFF),
    this.boxWidth = 24.0,
    this.radius = 4.0,
    this.iconPath = 'images/checkbox/selected.png',
    this.iconPackage = 'saturn',
    this.iconSize = const Size(14.0, 12.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Opacity(
        opacity: disabled ? 0.2 : 1.0,
        child: GestureDetector(
          onTap: () => disabled ? null : onChanged(!value),
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
    if (disabled || !value) {
      return Container(
        height: boxWidth,
        width: boxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(color: borderColor),
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: boxWidth,
            width: boxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              color: activeColor,
            ),
          ),
          Image.asset(
            iconPath,
            package: iconPackage,
            width: iconSize.width,
            height: iconSize.height,
            color: iconColor,
          )
        ],
      );
    }
  }
}
