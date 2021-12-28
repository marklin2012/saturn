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
  final Function(STDropdownPositon positon)? showFunc;
  final Function()? hideFunc;

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
    return STMouseRegion(
      onHover: (PointerHoverEvent hover) {},
      onExit: (PointerExitEvent exit) {},
      child: Container(
        key: _triggerKey,
        padding: widget.data.padding ?? EdgeInsets.zero,
        decoration: _decoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.data.icon != null) {
                  debugPrint('点击按钮回调');
                  if (widget.data.textTap == null) {
                    return;
                  }
                  widget.data.textTap!();
                  return;
                }
                _showEntry();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.0),
                    child: Text(
                      _data.text,
                      style: TextStyle(
                        fontSize: _titleFontSize,
                        fontWeight: _titleFontWeight,
                        color: _data.disabled
                            ? _disbaleTitleColor
                            : widget.data.textColor,
                      ),
                    ),
                  ),
                  if (_data.isArrow)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        STIcons.direction_downoutlined,
                        size: 14,
                        color: _data.disabled
                            ? _disbaleIconColor
                            : widget.data.textColor,
                      ),
                    ),
                ],
              ),
            ),
            if (_data.icon != null)
              GestureDetector(
                onTap: _showEntry,
                child: Padding(
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
                          : widget.data.textColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showEntry() {
    if (_data.triggerMode == STDropdownTriggerMode.clickLeft &&
        widget.showFunc != null) {
      widget.showFunc!(
        STDropdownPositon(
          offset: _triggerOffset,
          size: _triggerSize,
        ),
      );
    }
  }
}
