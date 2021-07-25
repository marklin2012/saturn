import 'package:flutter/material.dart';

enum STActionSheetDirectionType { vertical, horizontal }

class STActionSheetConstant {
  static const double titleFontSize = 18.0;
  static const double messageFontSize = 16.0;

  static const double cornerRadius = 8.0;

  static const double defaultMaxHeightPercent = 0.5;

  static const double defaultTopBottomPadding = 16.0;

  static const Color butttonHighlightColor = Color(0xFFEFF3F9);
  static const Color optionHighlightColor = Color(0xFFEFF3F9);

  static const Color messageColor = Color(0xFF555555);
  static const Color defaultButtonTextColor = Color.fromRGBO(9, 91, 249, 1);
  static const Color textFieldThemeColor = Color.fromRGBO(187, 187, 187, 0.5);
  static const Color defaultLineColor = Color(0xFFEFF3F9);
}

class STActionSheetInterface {
  Widget getLineWidget(double containerWidth) {
    return Container(
      width: containerWidth,
      height: 1,
      color: STActionSheetConstant.defaultLineColor,
    );
  }
}
