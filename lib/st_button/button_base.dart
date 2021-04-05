import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saturn/st_button/common.dart';
import 'package:saturn/st_button/st_button.dart';

class STButtonBase extends StatefulWidget {
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
  _STButtonBaseState createState() => _STButtonBaseState();
}

class _STButtonBaseState extends State<STButtonBase> with STButtonInterface {
  BoxDecoration _decoration;
  Widget _icon;
  STButtonState _state;
  STButtonState _lastState;
  ValueNotifier<STButtonState> _curState;

  void initOriginState() {
    _lastState = STButtonState.primary;
    if (widget.loading) {
      _lastState = STButtonState.loading;
    } else if (widget.disabled) {
      _lastState = STButtonState.disabled;
    }
    _state = _lastState;
    _curState = ValueNotifier(_state);
  }

  @override
  Widget build(BuildContext context) {
    initOriginState();
    return ValueListenableBuilder(
      valueListenable: _curState,
      builder: (context, STButtonState stateValue, child) {
        _baseConfig(stateValue);
        return GestureDetector(
          onTap: excOnTap(),
          onTapDown: (details) {
            // 加载的过程或者不可用的状态下不可点击
            if (_state == STButtonState.loading ||
                widget.disabled == true ||
                widget.onTap == null) {
              return;
            }
            _curState.value = STButtonState.highlighted;
          },
          onTapCancel: () {
            if (widget.disabled == false && widget.onTap != null) {
              _curState.value = _lastState;
            }
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: widget.height ?? heightFromButtonSize(widget.size)),
            child: Opacity(
              opacity: opacityFromButtonState(stateValue),
              child: Container(
                width: widget.width ?? widthFromButtonSize(widget.size),
                decoration: _decoration,
                padding: edgeInsetsFromButtonSize(widget.size),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_icon != null) _icon,
                    if (!widget.circle && widget.text != null)
                      SizedBox(width: spaceFromButtonSize(widget.size)),
                    if (!widget.circle && widget.text != null)
                      Text(
                        widget.text ?? 'button',
                        style: widget.textStyle ??
                            TextStyle(color: textColorFromButton(widget.type)),
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

  void _baseConfig(STButtonState stateValue) {
    _decoration = BoxDecoration(
      color: widget.backgroundColor ?? bgColorFromButtonType(widget.type),
      borderRadius: BorderRadius.circular(
          widget.radius ?? spaceFromButtonSize(widget.size)),
    );
    if (widget.type == STButtonType.text) {
      _decoration = const BoxDecoration();
    } else if (widget.type == STButtonType.outline) {
      _decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(
            widget.radius ?? spaceFromButtonSize(widget.size)),
        border: Border.all(
          color: widget.borderColor ?? bgColorFromButtonType(widget.type),
          width: widget.borderWidth ?? 1,
        ),
      );
    } else if (widget.circle) {
      _decoration = BoxDecoration(
        color: widget.backgroundColor ?? bgColorFromButtonType(widget.type),
        shape: BoxShape.circle,
      );
    }
    _icon = widget.icon;
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
  }

  void Function() excOnTap() {
    // 加载的过程或者不可用的状态下不可点击
    if (widget.loading || widget.disabled == true) {
      return null;
    } else {
      return widget.onTap;
    }
  }
}
