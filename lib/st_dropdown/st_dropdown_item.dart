import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/utils/include.dart';

enum STDropdownDataType {
  normal,
  danger,
}

class STDropdownData {
  final String title;
  final IconData? icon;
  final bool disabled;
  final bool divider;
  final STDropdownDataType type;
  final VoidCallback? onTap;
  final List<STDropdownData>? nextDatas;

  bool get hasNext => nextDatas != null && nextDatas!.isNotEmpty;

  const STDropdownData({
    required this.title,
    this.icon,
    this.disabled = false,
    this.divider = false,
    this.type = STDropdownDataType.normal,
    this.onTap,
    this.nextDatas,
  });
}

class STDropdownItem extends StatelessWidget {
  static const _disabledColor = STColor.fourRankFont;
  static const _dangerColor = STColor.assistRed;
  static const _normalColor = Colors.black;
  static const _fontSize = 14.0;
  static const _fontWeight = FontWeight.w400;

  const STDropdownItem({Key? key, required this.data}) : super(key: key);

  final STDropdownData data;

  @override
  Widget build(BuildContext context) {
    var _primaryColor = _normalColor;
    if (data.disabled) {
      _primaryColor = _disabledColor;
    } else if (data.type == STDropdownDataType.danger) {
      _primaryColor = _dangerColor;
    }
    return STMouseRegion(
      onExit: (PointerExitEvent exit) {},
      onHover: (PointerHoverEvent hover) {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
            Text(
              data.title,
              style: TextStyle(
                color: _primaryColor,
                fontSize: _fontSize,
                fontWeight: _fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
