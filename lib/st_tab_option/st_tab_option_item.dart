import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';

enum STTabOptionDirction {
  top,
  bottom,
  left,
  right,
}

class STTabOptionItem extends StatelessWidget {
  const STTabOptionItem({
    Key key,
    this.backgroundColor,
    this.prefix,
    this.suffix,
    this.selected = false,
    this.disabled = false,
    this.selectedStyle = const TextStyle(
      color: STColor.firRankBlue,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.unselectedStyle = const TextStyle(
      color: STColor.firRankFont,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    this.disabledStyle = const TextStyle(
      color: STColor.secRankGrey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    this.item,
    this.dirction = STTabOptionDirction.top,
    this.isCard = false,
    this.onTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget prefix;
  final Widget suffix;
  final bool selected;
  final bool disabled;
  final TextStyle selectedStyle;
  final TextStyle unselectedStyle;
  final TextStyle disabledStyle;
  final String item;
  final STTabOptionDirction dirction;
  final bool isCard;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (disabled) return;
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: _getDecoration(),
        child: _getChild(),
      ),
    );
  }

  Widget _getChild() {
    Widget _child;
    return _child;
  }

  BoxDecoration _getDecoration() {
    BoxDecoration _decoration;
    if (isCard) {
    } else {}
    return _decoration;
  }

  Widget _buildTitle() {
    TextStyle _style = unselectedStyle;
    if (disabled) {
      _style = disabledStyle;
    } else if (selected) {
      _style = selectedStyle;
    }
    return Text(
      item,
      style: _style,
    );
  }
}
