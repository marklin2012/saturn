import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';
import 'package:saturn/st_icons/st_icons.dart';

class STRowOption extends StatelessWidget {
  const STRowOption({
    Key key,
    this.leading,
    this.trailing,
    this.isHavRightArrow = false,
    this.center,
    this.padding,
    this.height = 48.0,
    this.isHavBottomLine = true,
    this.backgroundColor = STColor.backgroundColor,
    this.leadingPadding = const EdgeInsets.only(right: 32),
    this.trailingPadding = const EdgeInsets.only(right: 12.0),
    this.rightArrowIconSize = 24,
    this.contentCrossAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final Widget leading;

  final Widget trailing;

  final bool isHavRightArrow;

  final Widget center;

  final EdgeInsetsGeometry padding;

  final double height;

  final bool isHavBottomLine;

  final Color backgroundColor;

  final EdgeInsets leadingPadding;

  final EdgeInsets trailingPadding;

  final double rightArrowIconSize;

  final CrossAxisAlignment contentCrossAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
      ),
      padding: padding ?? const EdgeInsets.only(left: 16.0),
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRow(),
          if (isHavBottomLine)
            Container(
              height: 1,
              color: const Color(0xFFEFF3F9),
            ),
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: center == null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: contentCrossAlignment,
        children: [
          if (leading != null)
            Padding(
              padding: leadingPadding,
              child: leading,
            ),
          Expanded(child: center ?? const SizedBox()),
          _buildTrailing(),
          const SizedBox(width: 16.0),
        ],
      ),
    );
  }

  Widget _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailing != null)
          Padding(
            padding: isHavRightArrow ? trailingPadding : EdgeInsets.zero,
            child: trailing,
          ),
        if (isHavRightArrow)
          Icon(
            STIcons.direction_rightoutlined,
            color: const Color(0xFFC4C5C7),
            size: rightArrowIconSize,
          ),
      ],
    );
  }
}
