import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

enum STDropdownItemDataType {
  normal,
  danger,
}

class STDropdownItemData {
  final String title;
  // final List<String>? groups;
  final IconData? icon;
  final bool disabled;
  final bool divider;
  final STDropdownItemDataType type;
  final List<STDropdownItemData>? nextDatas;

  // bool get hasGroup => groups != null && groups!.isNotEmpty;
  bool get hasNext => nextDatas != null && nextDatas!.isNotEmpty;

  const STDropdownItemData({
    required this.title,
    // this.groups,
    this.icon,
    this.disabled = false,
    this.divider = false,
    this.type = STDropdownItemDataType.normal,
    this.nextDatas,
  });
}

// ignore: must_be_immutable
class STDropdownItem extends StatelessWidget {
  static const _disabledColor = STColor.fourRankFont;
  static const _dangerColor = STColor.assistRed;
  static const _normalColor = Colors.black;
  static const _hoverColor = STColor.fourRankGrey;
  static const _fontSize = 14.0;
  static const _fontWeight = FontWeight.w400;

  STDropdownItem({
    Key? key,
    required this.data,
    this.height = 32.0,
    this.width,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  final STDropdownItemData data;
  final double height;
  final double? width;
  final bool selected;
  final Function(STDropdownItemData)? onTap;

  final _backgroundColorNoti = ValueNotifier(Colors.transparent);
  var _primaryColor = _normalColor;

  @override
  Widget build(BuildContext context) {
    if (data.disabled) {
      _primaryColor = _disabledColor;
    } else if (data.type == STDropdownItemDataType.danger) {
      _primaryColor = _dangerColor;
    }
    if (selected) {
      _primaryColor = STColor.firRankBlue;
    }
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: data.divider
            ? const Border(
                bottom: BorderSide(color: STColor.thrRankGrey),
              )
            : null,
      ),
      child: _buildSubRow(),
    );
  }

  Widget _buildSubRow() {
    return STMouseRegion(
      onExit: (PointerExitEvent exit) {
        _backgroundColorNoti.value = Colors.transparent;
      },
      onHover: (PointerHoverEvent hover) {
        if (data.disabled) return;
        _backgroundColorNoti.value = _hoverColor;
      },
      child: GestureDetector(
        onTap: () {
          STDebounce().start(
            key: 'STDropdownDebounceKey',
            func: () {
              if (onTap == null) return;
              onTap!(data);
            },
            time: 100,
          );
        },
        child: ValueListenableBuilder(
          valueListenable: _backgroundColorNoti,
          builder: (context, Color bgColor, _) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              height: height,
              color: bgColor,
              child: _buildrealityRow(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildrealityRow() {
    return Row(
      children: [
        if (data.icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              data.icon,
              size: 16,
              color: _primaryColor,
            ),
          ),
        Expanded(
          child: _buildText(data.title),
        ),
        if (data.hasNext)
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              STIcons.direction_rightoutlined,
              size: 16,
              color: _primaryColor,
            ),
          ),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: _fontWeight,
        color: _primaryColor,
        decoration: TextDecoration.none,
      ),
    );
  }

  // Widget _buildColumn() {
  //   final List<Widget> _children = [];
  //   _children.add(_buildSubRow());
  // if (data.hasGroup) {
  //   for (final group in data.groups!) {
  //     final _groupW = ValueListenableBuilder(
  //       valueListenable: _backgroundColorNoti,
  //       builder: (context, Color bgColor, _) {
  //         return GestureDetector(
  //           onTap: () {
  //             STDebounce().start(
  //               key: 'STDropdownDebounceKey',
  //               func: () {
  //                 if (onTap == null) return;
  //                 onTap!(data);
  //               },
  //               time: 100,
  //             );
  //           },
  //           child: Container(
  //             height: height,
  //             alignment: Alignment.centerLeft,
  //             color: bgColor,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 36.0,
  //                 vertical: 4.0,
  //               ),
  //               child: _buildText(group, _primaryColor),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //     _children.add(_groupW);
  //   }
  // }
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: _children,
  //   );
  // }
}
