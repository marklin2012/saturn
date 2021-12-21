import 'package:flutter/material.dart';

import 'common.dart';

class STTag extends StatelessWidget {
  final String text;
  final STTagType? type;
  final STTagShape shape;
  final STTagSize size;
  final Function(String)? onTap;
  final Function(String)? onCloseTap;

  const STTag({
    required this.text,
    this.type,
    this.shape = STTagShape.primary,
    this.size = STTagSize.normal,
    this.onTap,
    this.onCloseTap,
  });

  Color colorFromType(STTagType? type) {
    switch (type) {
      case STTagType.success:
        return STTagConstant.colorSuccess;
      case STTagType.error:
        return STTagConstant.colorError;
      case STTagType.warning:
        return STTagConstant.colorWarnning;
      default:
        return STTagConstant.colorPrimary;
    }
  }

  double fontSizeFromSize(STTagSize size) {
    switch (size) {
      case STTagSize.big:
        return STTagConstant.bigTextFont;
      case STTagSize.normal:
        return STTagConstant.normalTextFont;
      default:
        return STTagConstant.smallTextFont;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = colorFromType(type);
    final double textSize = fontSizeFromSize(size);
    bool isBorder = false;
    BorderRadiusGeometry borderRadius;

    switch (shape) {
      case STTagShape.outline:
        {
          borderRadius = BorderRadius.circular(2.0);
          isBorder = true;
        }
        break;
      case STTagShape.roundRect:
        {
          borderRadius = BorderRadius.circular(20);
        }
        break;
      case STTagShape.rightRoundRect:
        {
          borderRadius =
              const BorderRadius.horizontal(right: Radius.elliptical(20, 20));
        }
        break;
      default: // 主要的
        {
          borderRadius = BorderRadius.circular(2.0);
        }
    }

    return Container(
      decoration: BoxDecoration(
          color: isBorder ? Colors.white : backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: backgroundColor,
          )),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap!(text);
                }
              },
              child: Text(text,
                  style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.w400,
                      color: isBorder ? backgroundColor : Colors.white))),
          if (onCloseTap != null)
            GestureDetector(
                onTap: () {
                  onCloseTap!(text);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: textSize,
                  ),
                ))
        ],
      ),
    );
  }
}
