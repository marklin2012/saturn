import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';

import 'package:saturn/st_button/st_button.dart';

// ignore: must_be_immutable
class STButtonBase extends StatelessWidget with STButtonInterface {
  Widget icon;
  final String text;
  final TextStyle style;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final STButtonType type;
  final STButtonSize size;
  STButtonState state;
  final EdgeInsets padding;

  STButtonBase(
      {Key key,
      this.icon,
      this.text,
      this.style,
      this.onTap,
      this.height,
      this.width,
      this.radius,
      this.padding,
      this.borderColor,
      this.borderWidth,
      @required this.type,
      @required this.size,
      @required this.state})
      : super(key: key);

  BoxDecoration _decoration;
  Widget _icon;
  STButtonState _lastState;

  @override
  Widget build(BuildContext context) {
    _lastState = state;
    final ValueNotifier<STButtonState> curState = ValueNotifier(state);
    if (type == STButtonType.icon) {
      return ValueListenableBuilder(
        valueListenable: curState,
        builder: (context, STButtonState value, child) {
          return GestureDetector(
            onTap: disable == false ? onTap : null,
            onTapDown: (details) => curState.value = STButtonState.focus,
            onTapCancel: () => curState.value = _lastState,
            child: Container(
              width: width ?? STButtonConstant.iconWidth,
              padding: padding ?? STButtonConstant.iconPadding,
              decoration: BoxDecoration(
                color: bgColorFromButtonState(value),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: icon,
            ),
          );
        },
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: curState,
        builder: (context, STButtonState value, child) {
          _decoration = const BoxDecoration();
          if (type == STButtonType.main) {
            _decoration = BoxDecoration(
              color: bgColorFromButtonState(value),
              borderRadius:
                  BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
            );
          } else if (type == STButtonType.outLine) {
            _decoration = BoxDecoration(
              borderRadius:
                  BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
              border: Border.all(
                color: borderColor ?? STColor.firRankBlue,
                width: borderWidth ?? 1,
              ),
            );
          }
          _icon = icon;
          if (state == STButtonState.loading && _icon == null) {
            _icon = const Icon(
              Icons.refresh,
              color: STColor.colorWhite,
            );
          }
          return GestureDetector(
            onTap: disable == false ? onTap : null,
            onTapDown: (details) => curState.value = STButtonState.focus,
            onTapCancel: () => curState.value = _lastState,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height ?? heightFromButtonSize(size),
              ),
              child: Container(
                width: width ?? widthFromButtonSize(size),
                decoration: _decoration,
                padding: edgeInsetsFromButtonSize(size),
                alignment: Alignment.center,
                child: _icon == null
                    ? Text(
                        text ?? 'button',
                        style: style ??
                            const TextStyle(color: STColor.thrRankFont),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _icon,
                          SizedBox(
                            width: spaceFromButtonSize(size),
                          ),
                          Text(
                            text ?? 'button',
                            style: style ??
                                const TextStyle(color: STColor.thrRankFont),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      );
    }
  }

  bool get disable {
    if (state == STButtonState.disable || onTap == null) {
      return true;
    }
    return false;
  }
}
