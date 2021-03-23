import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';
import 'package:saturn/st_color_utils.dart';

abstract class STButtonSizeState {
  Color stBackgroundColor(STButtonState state) {
    if (state == STButtonState.success) {
      return assistGreen;
    }
    if (state == STButtonState.danger) {
      return assistRed;
    }
    if (state == STButtonState.focus) {
      return secRankBlue;
    }
    if (state == STButtonState.disable) {
      return fourRankBlue;
    }
    return firRankBlue;
  }

  double stDefaultHeight(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConst.smallHeight;
    }
    return STButtonConst.bigHeight;
  }

  double stDefaultWidth(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConst.smallWidth;
    }
    return STButtonConst.bigWidth;
  }

  double stSpace(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConst.smallSpace;
    }
    return STButtonConst.bigSpace;
  }

  EdgeInsets stEdgeInsets(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConst.smallEdgetInset;
    }
    return STButtonConst.bigEdgetInset;
  }
}
