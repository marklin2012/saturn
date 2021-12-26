import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/utils/include.dart';

enum STDropdownTriggerPositon {
  left,
  right,
}

enum STDropdownTriggerMode {
  clickLeft,
  onHover,
  clickRight,
}

class STDropdownTriggerData {
  final String title;
  final bool disabled;
  final bool isArrow;
  final IconData? icon;
  final STDropdownTriggerPositon triggerPositon;
  final STDropdownTriggerMode triggerMode;

  const STDropdownTriggerData({
    required this.title,
    this.disabled = false,
    this.isArrow = false,
    this.icon,
    this.triggerPositon = STDropdownTriggerPositon.left,
    this.triggerMode = STDropdownTriggerMode.onHover,
  });
}

class STDropdownTrigger extends StatefulWidget {
  const STDropdownTrigger({Key? key, required this.data}) : super(key: key);

  final STDropdownTriggerData data;

  @override
  _STDropdownTriggerState createState() => _STDropdownTriggerState();
}

class _STDropdownTriggerState extends State<STDropdownTrigger> {
  static const _normalBorderColor = STColor.thrRankGrey;
  static const _disableBorderColor = Color(0xFFD9D9D9);
  static const _normalTitleColor = Colors.black;
  static const _disbaleTitleColor = STColor.fourRankFont;
  static const _titleFontSize = 14.0;
  static const _titleFontWeight = FontWeight.w400;
  static const _disbaleIconColor = STColor.secRankGrey;

  GlobalKey _triggerKey = GlobalKey(debugLabel: 'tirgger');
  late Offset _triggerOffset;
  late Size _triggerSize;
  late STDropdownTriggerData _data;
  late OverlayState _overlayState;

  @override
  void initState() {
    super.initState();
    _data = widget.data;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _positonTrigger();
    });
  }

  void _positonTrigger() {
    final _renderObj = _triggerKey.currentContext?.findRenderObject();
    if (_renderObj != null && _renderObj is RenderBox) {
      final _renderBox = _renderObj;
      _triggerOffset = _renderBox.localToGlobal(Offset.zero);
      _triggerSize = _renderBox.size;
    }
  }

  @override
  Widget build(BuildContext context) {
    _overlayState = Overlay.of(context)!;
    final _decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(2.0),
      color: _data.disabled ? const Color(0xFFF5F5F5) : Colors.white,
      border: Border.all(
        color: _data.disabled ? _disableBorderColor : _normalBorderColor,
      ),
    );
    return STMouseRegion(
      onHover: (PointerHoverEvent hover) {},
      onExit: (PointerExitEvent exit) {},
      child: GestureDetector(
        onTap: () {},
        child: Container(
          key: _triggerKey,
          padding:
              EdgeInsets.only(left: 16.0, right: _data.icon != null ? 0 : 16.0),
          decoration: _decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  _data.title,
                  style: TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: _titleFontWeight,
                    color:
                        _data.disabled ? _disbaleTitleColor : _normalTitleColor,
                  ),
                ),
              ),
              if (_data.isArrow)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    STIcons.direction_downoutlined,
                    size: 14,
                    color:
                        _data.disabled ? _disbaleIconColor : _normalTitleColor,
                  ),
                ),
              if (_data.icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _data.disabled
                              ? _disableBorderColor
                              : _normalBorderColor,
                        ),
                      ),
                    ),
                    child: Icon(
                      _data.icon,
                      size: 16,
                      color: _data.disabled
                          ? _disbaleIconColor
                          : _normalTitleColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
