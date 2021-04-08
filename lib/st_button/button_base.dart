import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saturn/st_button/common.dart';
import 'package:saturn/st_button/st_button.dart';

class STButtonBase extends StatelessWidget with STButtonInterface {
  final Widget icon;
  final String text; // 文本内容
  final TextStyle textStyle; // 文本的style样式
  final VoidCallback onTap;
  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final STButtonType type;
  final STButtonSize size;
  final bool disabled;
  final bool loading;
  final bool circle;
  final EdgeInsets padding;

  const STButtonBase(
      {Key key,
      this.icon,
      this.text,
      this.textStyle,
      this.onTap,
      this.height,
      this.width,
      this.radius,
      this.backgroundColor,
      this.padding,
      this.borderColor,
      this.borderWidth,
      this.disabled = false,
      this.loading = false,
      this.circle = false,
      this.type = STButtonType.primary,
      this.size = STButtonSize.large})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final STButtonState _lastState = initOriginState();
    final STButtonState _state = _lastState;
    final Widget _icon = _getIcon(_state);
    final BoxDecoration _decoration = _baseConfig(_state);
    final ValueNotifier<STButtonState> _curState = ValueNotifier(_state);
    return ValueListenableBuilder(
      valueListenable: _curState,
      builder: (context, STButtonState stateValue, child) {
        _baseConfig(stateValue);
        return GestureDetector(
          onTap: excOnTap(),
          onTapDown: (details) {
            // 加载的过程或者不可用的状态下不可点击
            if (_state == STButtonState.loading ||
                disabled == true ||
                onTap == null) {
              return;
            }
            _curState.value = STButtonState.highlighted;
          },
          onTapCancel: () {
            if (disabled == false && onTap != null) {
              _curState.value = _lastState;
            }
          },
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: height ?? heightFromButtonSize(size)),
            child: Opacity(
              opacity: opacityFromButtonState(stateValue),
              child: Container(
                width: width ?? widthFromButtonSize(size),
                decoration: _decoration,
                padding: edgeInsetsFromButtonSize(size),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_icon != null) _icon,
                    if (!circle && text != null)
                      SizedBox(width: spaceFromButtonSize(size)),
                    if (!circle && text != null)
                      Text(
                        text ?? 'button',
                        style: textStyle ??
                            TextStyle(color: textColorFromButton(type)),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  STButtonState initOriginState() {
    STButtonState _lastState = STButtonState.primary;
    if (loading) {
      _lastState = STButtonState.loading;
    } else if (disabled) {
      _lastState = STButtonState.disabled;
    }
    return _lastState;
  }

  Widget _getIcon(STButtonState stateValue) {
    Widget _icon = icon;
    // 当状态为Loading且外部没有设置时，内部直接给定一个Loading的过程
    if (stateValue == STButtonState.loading && _icon == null) {
      _icon = const SizedBox(
        width: 24.0,
        height: 24.0,
        child: CupertinoActivityIndicator(
          radius: 12.0,
        ),
      );
    }
    return _icon;
  }

  BoxDecoration _baseConfig(STButtonState stateValue) {
    BoxDecoration _decoration = BoxDecoration(
      color: backgroundColor ?? bgColorFromButtonType(type),
      borderRadius: BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
    );
    if (type == STButtonType.text) {
      _decoration = const BoxDecoration();
    } else if (type == STButtonType.outline) {
      _decoration = BoxDecoration(
        borderRadius:
            BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
        border: Border.all(
          color: borderColor ?? bgColorFromButtonType(type),
          width: borderWidth ?? 1,
        ),
      );
    } else if (circle) {
      _decoration = BoxDecoration(
        color: backgroundColor ?? bgColorFromButtonType(type),
        shape: BoxShape.circle,
      );
    }
    return _decoration;
  }

  void Function() excOnTap() {
    // 加载的过程或者不可用的状态下不可点击
    if (loading || disabled == true) {
      return null;
    } else {
      return onTap;
    }
  }
}
