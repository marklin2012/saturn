import 'dart:html';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_dropdown/st_dropdown_overlay.dart';

enum STDropdownTriggerMode {
  clickLeft,
  onHover,
  clickRight,
}

enum STDropdownTriggerAligment {
  left,
  center,
  right,
}

class STDropdownTriggerData {
  final String text;
  final Color textColor;
  final bool disabled;
  final bool isArrow;
  final IconData? icon;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final STDropdownTriggerMode triggerMode;
  final STDropdownTriggerAligment aligment;
  final Function()? textTap; // 有图片时，文字点击回调

  const STDropdownTriggerData({
    required this.text,
    this.disabled = false,
    this.isArrow = false,
    this.icon,
    this.triggerMode = STDropdownTriggerMode.clickLeft,
    this.aligment = STDropdownTriggerAligment.left,
    this.textColor = STColor.firRankBlue,
    this.decoration,
    this.padding,
    this.textTap,
  });
}

class STDropdownTrigger extends StatefulWidget {
  const STDropdownTrigger({
    Key? key,
    required this.data,
    this.showFunc,
    this.hideFunc,
  }) : super(key: key);

  final STDropdownTriggerData data;
  final Function(STDropdownPosition position)? showFunc;
  final Function(Offset position)? hideFunc;

  @override
  _STDropdownTriggerState createState() => _STDropdownTriggerState();
}

class _STDropdownTriggerState extends State<STDropdownTrigger> {
  static const _normalBorderColor = STColor.thrRankGrey;
  static const _disableBorderColor = Color(0xFFD9D9D9);
  static const _disbaleTitleColor = STColor.fourRankFont;
  static const _titleFontSize = 14.0;
  static const _titleFontWeight = FontWeight.w400;
  static const _disbaleIconColor = STColor.secRankGrey;

  final _triggerKey = GlobalKey(debugLabel: 'tirgger');
  late Offset _triggerOffset;
  late Size _triggerSize;
  late STDropdownTriggerData _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _positonTrigger();
    });
    // 屏蔽浏览器默认的右键点击事件
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  void _positonTrigger() {
    final _renderObj = _triggerKey.currentContext?.findRenderObject();
    if (_renderObj != null && _renderObj is RenderBox) {
      final _renderBox = _renderObj;
      _triggerOffset = _renderBox.localToGlobal(Offset.zero);
      _triggerSize = _renderBox.size;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = widget.data.decoration;
    return Container(
      key: _triggerKey,
      padding: widget.data.padding ?? EdgeInsets.zero,
      decoration: _decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildReadyText(),
          if (_data.icon != null) _buildReadyIcon(),
        ],
      ),
    );
  }

  Widget _buildReadyIcon() {
    return STMouseRegion(
      onHover: (PointerHoverEvent hover) {
        if (widget.data.triggerMode == STDropdownTriggerMode.onHover) {
          _showEntry();
        }
      },
      onExit: (PointerExitEvent exit) {
        if (widget.data.triggerMode == STDropdownTriggerMode.onHover) {
          _hideEntry(exit.position);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.data.triggerMode == STDropdownTriggerMode.clickLeft) {
            _showEntry();
          }
        },
        child: Listener(
          onPointerDown: (event) {
            if (event.kind == PointerDeviceKind.mouse &&
                event.buttons == kSecondaryMouseButton) {
              if (widget.data.triggerMode == STDropdownTriggerMode.clickRight) {
                _showEntry();
              }
            }
          },
          child: _buildIcon(),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: _data.disabled ? _disableBorderColor : _normalBorderColor,
            ),
          ),
        ),
        child: Icon(
          _data.icon,
          size: 16,
          color: _data.disabled ? _disbaleIconColor : widget.data.textColor,
        ),
      ),
    );
  }

  Widget _buildReadyText() {
    return STMouseRegion(
      onHover: (PointerHoverEvent hover) {
        if (widget.data.triggerMode == STDropdownTriggerMode.onHover) {
          _textTriggerAction();
        }
      },
      onExit: (PointerExitEvent exit) {
        if (widget.data.triggerMode == STDropdownTriggerMode.onHover) {
          _hideEntry(exit.position);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.data.triggerMode == STDropdownTriggerMode.clickLeft) {
            _textTriggerAction();
          }
        },
        child: Listener(
          onPointerDown: (event) {
            if (event.kind == PointerDeviceKind.mouse &&
                event.buttons == kSecondaryMouseButton) {
              if (widget.data.triggerMode == STDropdownTriggerMode.clickRight) {
                _textTriggerAction();
              }
            }
          },
          child: _buildText(),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Text(
            _data.text,
            style: TextStyle(
              fontSize: _titleFontSize,
              fontWeight: _titleFontWeight,
              color:
                  _data.disabled ? _disbaleTitleColor : widget.data.textColor,
            ),
          ),
        ),
        if (_data.isArrow)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              STIcons.direction_downoutlined,
              size: 14,
              color: _data.disabled ? _disbaleIconColor : widget.data.textColor,
            ),
          ),
      ],
    );
  }

  void _textTriggerAction() {
    if (widget.data.icon != null) {
      if (widget.data.textTap == null) return;
      widget.data.textTap!();
      return;
    }
    _showEntry();
  }

  void _showEntry() {
    if (widget.showFunc == null) return;
    widget.showFunc!(
      STDropdownPosition(
        offset: _triggerOffset,
        size: _triggerSize,
      ),
    );
  }

  void _hideEntry(Offset position) {
    if (widget.hideFunc == null) return;
    widget.hideFunc!(position);
  }
}
