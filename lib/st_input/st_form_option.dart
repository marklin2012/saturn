import 'package:flutter/material.dart';
import 'package:saturn/st_icons/st_icons.dart';

class STFormOption extends StatelessWidget {
  const STFormOption({
    Key key,
    this.leading,
    this.trailing,
    this.isHavRightArrow = false,
    this.formFeild,
    this.padding,
    this.height = 48.0,
    this.isHavBottomLine = true,
  }) : super(key: key);

  final Widget leading;

  final Widget trailing;

  final bool isHavRightArrow;

  final Widget formFeild;

  final EdgeInsetsGeometry padding;

  final double height;

  final bool isHavBottomLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildRow()),
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
    return Row(
      mainAxisAlignment: formFeild == null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        if (leading != null)
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: leading,
          ),
        if (formFeild != null) Expanded(child: formFeild),
        _buildTrailing(),
      ],
    );
  }

  Widget _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailing != null)
          Padding(
            padding: isHavRightArrow
                ? const EdgeInsets.only(right: 12.0)
                : EdgeInsets.zero,
            child: trailing,
          ),
        if (isHavRightArrow)
          const Icon(
            STIcons.direction_rightoutlined,
            color: Color(0xFFC4C5C7),
          ),
      ],
    );
  }
}
