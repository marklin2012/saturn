import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/utils/include.dart';

const _defaultIconWidth = 20.0;

// ignore: must_be_immutable
class STCheckBox extends StatelessWidget {
  final bool value; // 是否选中
  final ValueChanged<bool>? onChanged;
  final Color activeColor; // 内部颜色
  final Color borderColor; // 边框颜色
  final String? text; // 文本内容
  final bool disabled; // 是否可用
  final double boxWidth; // 框的宽度
  final double space; // 文字与图的间距
  final TextStyle textStyle; // 文字的样式
  final EdgeInsets padding; // 内边距
  final double radius; // 框的圆角半径
  final Color iconColor; // 图片颜色

  STCheckBox({
    Key? key,
    this.value = false,
    this.text,
    this.disabled = false,
    this.onChanged,
    this.activeColor = const Color(0xFF095BF9),
    this.borderColor = const Color(0xFF888888),
    this.space = 12.0,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 17.0),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.iconColor = const Color(0xFFFFFFFF),
    this.boxWidth = 24.0,
    this.radius = 4.0,
  }) : super(key: key);

  Color? _borderColor;
  late ValueNotifier<Color?> _curColorNoti;

  void initNotifier() {
    _borderColor = borderColor;
    _curColorNoti = ValueNotifier(_borderColor);
  }

  @override
  Widget build(BuildContext context) {
    initNotifier();
    return STMouseRegion(
      onEnter: (PointerEnterEvent details) {
        if (disabled) return;
        _curColorNoti.value = STColor.firRankBlue;
      },
      onExit: (PointerExitEvent details) {
        _curColorNoti.value = borderColor;
      },
      child: Padding(
        padding: padding,
        child: Opacity(
          opacity: disabled ? 0.2 : 1.0,
          child: GestureDetector(
            onTap: () => disabled ? null : onChanged!(!value),
            child: Row(
              children: [
                _getChild(),
                if (text != null) SizedBox(width: space),
                if (text != null) Text(text!, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getChild() {
    if (disabled || !value) {
      return ValueListenableBuilder(
        valueListenable: _curColorNoti,
        builder: (context, Color? color, child) {
          return Container(
            height: boxWidth,
            width: boxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              border: Border.all(color: color!),
            ),
          );
        },
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
          Icon(
            Icons.check,
            size: _defaultIconWidth,
            color: iconColor,
          )
        ],
      );
    }
  }
}
