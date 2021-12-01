import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';
import 'package:saturn/utils/include.dart';

// ignore: must_be_immutable
class STRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor; // 内部颜色
  final Color backgroundColor; // 背景颜色
  final Color borderColor; // 边框颜色
  final String text; // 文本内容
  final bool disabled;
  final double internalDiameter; // 内径
  final double externalDiameter; // 外径
  final double space; // 文字与图的间距
  final TextStyle textStyle; // 文字的样式
  final EdgeInsets padding; // 内边距

  STRadio({
    Key key,
    @required this.value,
    @required this.groupValue,
    this.text,
    @required this.onChanged,
    this.activeColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF095BF9),
    this.borderColor = const Color(0xFFDFE2E7),
    this.disabled = false,
    this.internalDiameter = 12.0,
    this.externalDiameter = 24.0,
    this.space = 12.0,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 17.0),
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  bool get _selected => value == groupValue;

  Color _borderColor;
  ValueNotifier<Color> _curColorNoti;

  void initNotifier() {
    _borderColor = borderColor;
    _curColorNoti = ValueNotifier(_borderColor);
  }

  @override
  Widget build(BuildContext context) {
    initNotifier();
    return STMouseRegion(
      onEnter: (PointerEnterEvent details) {
        if (disabled) return; // 不可用的不加效果
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
      ),
    );
  }

  Widget _getChild() {
    if (disabled || !_selected) {
      return ValueListenableBuilder(
        valueListenable: _curColorNoti,
        builder: (context, Color color, child) {
          return Container(
            height: externalDiameter,
            width: externalDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
          );
        },
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
