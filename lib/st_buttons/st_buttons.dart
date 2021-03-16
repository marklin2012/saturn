import 'package:flutter/material.dart';

import 'package:saturn/st_color_utils.dart';

const STBigSizeW = 172.0;
const STSmallSizeW = 84.0;
const STBigSizeH = 38.0;
const STSmallSizeH = 24.0;
const STSubSmallSpace = 4.0;
const STSubBigSpace = 8.0;
const STBtnEdgetInsetB = EdgeInsets.fromLTRB(16, 6, 16, 6);
const STBtnEdgetInsetS = EdgeInsets.fromLTRB(
  12,
  3,
  12,
  3,
);
const STBtnIconW = 44.0;
const STBtnIconPadding = EdgeInsets.all(10);

enum STButtonType { Main, OutLine, Text, Icon }

enum STButtonSize { Big, Small }

enum STButtonState { Default, Focus, Loading, Disable, Success, Danger }

abstract class STBtnTypeSizeState extends StatelessWidget {
  final STButtonType btnType;
  final STButtonSize btnSize;
  final STButtonState btnState;

  const STBtnTypeSizeState(
      {this.btnType = STButtonType.Main,
      this.btnSize = STButtonSize.Big,
      this.btnState = STButtonState.Default,
      Key key})
      : super(key: key);

  Color get backgroundColor {
    if (btnState == STButtonState.Success) {
      return assistGreen;
    }
    if (btnState == STButtonState.Danger) {
      return assistRed;
    }
    if (btnState == STButtonState.Focus) {
      return secRankBlue;
    }
    if (btnState == STButtonState.Disable) {
      return fourRankBlue;
    }
    return firRankBlue;
  }

  bool get disable {
    if (btnState == STButtonState.Disable) {
      return true;
    }
    return false;
  }

  double get btnH {
    if (btnSize == STButtonSize.Small) {
      return STSmallSizeH;
    }
    return STBigSizeH;
  }

  double get btnW {
    if (btnSize == STButtonSize.Small) {
      return STSmallSizeW;
    }
    return STBigSizeW;
  }

  double get space {
    if (btnSize == STButtonSize.Small) {
      return STSubSmallSpace;
    }
    return STSubBigSpace;
  }

  EdgeInsets get edgeInsets {
    if (btnSize == STButtonSize.Small) {
      return STBtnEdgetInsetS;
    }
    return STBtnEdgetInsetB;
  }
}
