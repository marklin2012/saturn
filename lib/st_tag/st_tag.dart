import 'package:flutter/material.dart';

import 'common.dart';

class STTag extends StatelessWidget {
  final String text;
  final STTagType type;
  final STTagCorner corner;
  final STTagTextSizeType textSizeType;
  final bool isBorder;
  final bool needClose;
  final VoidCallback onTap;
  final VoidCallback onCloseTap;

  const STTag(
      {this.text,
      this.type,
      this.corner = STTagCorner.normal,
      this.textSizeType,
      this.isBorder = false,
      this.needClose = false,
      this.onTap,
      this.onCloseTap});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (type) {
      case STTagType.normal:
        {
          backgroundColor = STTagConstant.colorNormal;
        }
        break;
      case STTagType.success:
        {
          backgroundColor = STTagConstant.colorSuccess;
        }
        break;
      case STTagType.failure:
        {
          backgroundColor = STTagConstant.colorFailure;
        }
        break;
      case STTagType.warning:
        {
          backgroundColor = STTagConstant.colorWarnning;
        }
        break;
    }

    BorderRadiusGeometry borderRadius;
    switch (corner) {
      case STTagCorner.normal:
        {
          borderRadius = BorderRadius.circular(2.0);
        }
        break;
      case STTagCorner.circle:
        {
          borderRadius = BorderRadius.circular(20);
        }
        break;
      case STTagCorner.rightHalf:
        {
          borderRadius =
              const BorderRadius.horizontal(right: Radius.elliptical(20, 20));
        }
        break;
    }

    double textSize;
    switch (textSizeType) {
      case STTagTextSizeType.big:
        textSize = 18.0;
        break;
      case STTagTextSizeType.small:
        textSize = 16.0;
        break;
      default:
        textSize = 17.0;
    }

    return Container(
      height: 34,
      decoration: BoxDecoration(
          color: isBorder ? Colors.white : backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: backgroundColor, width: 0.5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: onTap,
              style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.zero)),
              child: Text(text,
                  style: TextStyle(
                      fontSize: textSize,
                      color: isBorder ? backgroundColor : Colors.white))),
          if (needClose)
            GestureDetector(
                onTap: () {
                  onCloseTap();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ))
        ],
      ),
    );
  }
}
