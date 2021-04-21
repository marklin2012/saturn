import 'package:flutter/material.dart';

enum STDialogType { dialog, list, dynamicList, normal }

class STDialogConstant {
  static const double titleFontSize = 18.0;
  static const double messageFontSize = 16.0;

  static const double cornerRadius = 8.0;

  static const double dialogDefaultWidthPercent = 0.7;
  static const double listDefaultWidthPercent = 0.9;
  static const double dynamicListDefaultWidthPercent = 0.9;
  static const double normalDefaultWidthPercent = 0.7;
  static const double defaultMaxHeightPercent = 0.5;

  static const double defaultTopBottomPadding = 16.0;

  static const Color defaultButtonTextColor = Color.fromRGBO(9, 91, 249, 1);
  static const Color textFieldThemeColor = Color.fromRGBO(187, 187, 187, 0.5);
}
