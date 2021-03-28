import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';

import 'package:saturn/st_button/st_button.dart';

// ignore: must_be_immutable
class STButtonBase extends StatelessWidget with STButtonInterface {
  Widget icon;
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final STButtonStyle style;
  final STButtonType type;
  final STButtonSize size;
  final bool disable;
  final bool loading;
  final EdgeInsets padding;

  STButtonBase(
      {Key key,
      this.icon,
      this.text,
      this.textStyle,
      this.onTap,
      this.height,
      this.width,
      this.radius,
      this.padding,
      this.borderColor,
      this.borderWidth,
      this.disable,
      this.loading,
      @required this.style,
      @required this.type,
      @required this.size})
      : super(key: key);

  BoxDecoration _decoration;
  Widget _icon;
  STButtonState _state;
  STButtonState _lastState;

  void getOriginState() {
    _lastState = STButtonState.normal;
    if (loading) {
      _lastState = STButtonState.loading;
    }
    if (disable) {
      _lastState = STButtonState.disable;
    }
    _state = _lastState;
  }

  @override
  Widget build(BuildContext context) {
    getOriginState();
    if (style == STButtonStyle.icon) {
      return buildIconTypeButton(context);
    } else {
      return buildOtherTypeButton(context);
    }
  }

  Widget buildIconTypeButton(BuildContext context) {
    final ValueNotifier<STButtonState> curState = ValueNotifier(_state);
    return ValueListenableBuilder(
      valueListenable: curState,
      builder: (context, STButtonState value, child) {
        return GestureDetector(
          onTap: excOnTap(),
          onTapDown: (details) {
            // 加载的过程或者不可用的状态下不可点击
            if (_state == STButtonState.loading || disable == true) {
              return;
            }
            curState.value = STButtonState.focus;
          },
          onTapCancel: () {
            if (disable == false) {
              curState.value = _lastState;
            }
          },
          child: Opacity(
            opacity: opacityFromButtonState(value),
            child: Container(
              width: width ?? STButtonConstant.iconWidth,
              padding: padding ?? STButtonConstant.iconPadding,
              decoration: BoxDecoration(
                color: bgColorFromButtonType(type),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: icon,
            ),
          ),
        );
      },
    );
  }

  Widget buildOtherTypeButton(BuildContext context) {
    final ValueNotifier<STButtonState> curState = ValueNotifier(_state);
    return ValueListenableBuilder(
      valueListenable: curState,
      builder: (context, STButtonState stateValue, child) {
        _decoration = const BoxDecoration();
        if (style == STButtonStyle.normal) {
          _decoration = BoxDecoration(
            color: bgColorFromButtonType(type),
            borderRadius:
                BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
          );
        } else if (style == STButtonStyle.outLine) {
          _decoration = BoxDecoration(
            borderRadius:
                BorderRadius.circular(radius ?? spaceFromButtonSize(size)),
            border: Border.all(
              color: borderColor ?? bgColorFromButtonType(type),
              width: borderWidth ?? 1,
            ),
          );
        }
        _icon = icon;
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
        return GestureDetector(
          onTap: excOnTap(),
          onTapDown: (details) {
            // 加载的过程或者不可用的状态下不可点击
            if (_state == STButtonState.loading || disable == true) {
              return;
            }
            curState.value = STButtonState.focus;
          },
          onTapCancel: () {
            if (disable == false) {
              curState.value = _lastState;
            }
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height ?? heightFromButtonSize(size),
            ),
            child: Opacity(
              opacity: opacityFromButtonState(stateValue),
              child: Container(
                width: width ?? widthFromButtonSize(size),
                decoration: _decoration,
                padding: edgeInsetsFromButtonSize(size),
                alignment: Alignment.center,
                child: _icon == null
                    ? Text(
                        text ?? 'button',
                        style: textStyle ??
                            TextStyle(
                              color: textColorFromButton(style, type),
                            ),
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
                            style: textStyle ??
                                TextStyle(
                                  color: textColorFromButton(style, type),
                                ),
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

  void Function() excOnTap() {
    // 加载的过程或者不可用的状态下不可点击
    if (_state == STButtonState.loading || disable == true) {
      return null;
    } else {
      return onTap;
    }
  }
}
