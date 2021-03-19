import 'package:flutter/material.dart';

import 'package:saturn/st_color_utils.dart';
import 'package:saturn/st_buttons/st_button_enum.dart';

// 按钮相关常量
class STButtonConst {
  // 大按钮的宽度
  static const bigWidth = 172.0;
  // 小按钮的宽度
  static const smallWidth = 84.0;
  // 大按钮的最小高度
  static const bigHeight = 38.0;
  // 小按钮的最小高度
  static const smallHeight = 24.0;
  // 小按钮中的间距以及圆角
  static const smallSpace = 4.0;
  // 大按钮中的间距以及圆角
  static const bigSpace = 8.0;
  // 大按钮内容的inset
  static const bigEdgetInset = EdgeInsets.fromLTRB(16, 6, 16, 6);
  // 小按钮内容的inset
  static const smallEdgetInset = EdgeInsets.fromLTRB(12, 3, 12, 3);
  // 图形按钮的宽度
  static const iconWidth = 44.0;
  // 图形按钮的padding,图形与外部内容的inset
  static const iconPadding = EdgeInsets.all(10);
}

abstract class STButtonTypeSizeState extends StatelessWidget {
  final STButtonType buttonType;
  final STButtonSize buttonSize;
  final STButtonState buttonState;

  const STButtonTypeSizeState(
      {this.buttonType = STButtonType.main,
      this.buttonSize = STButtonSize.big,
      this.buttonState = STButtonState.main,
      Key key})
      : super(key: key);

  Color get backgroundColor {
    if (buttonState == STButtonState.success) {
      return assistGreen;
    }
    if (buttonState == STButtonState.danger) {
      return assistRed;
    }
    if (buttonState == STButtonState.focus) {
      return secRankBlue;
    }
    if (buttonState == STButtonState.disable) {
      return fourRankBlue;
    }
    return firRankBlue;
  }

  bool get disable {
    if (buttonState == STButtonState.disable) {
      return true;
    }
    return false;
  }

  double get defaultHeight {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallHeight;
    }
    return STButtonConst.bigHeight;
  }

  double get defaultWidth {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallWidth;
    }
    return STButtonConst.bigWidth;
  }

  double get space {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallSpace;
    }
    return STButtonConst.bigSpace;
  }

  EdgeInsets get edgeInsets {
    if (buttonSize == STButtonSize.small) {
      return STButtonConst.smallEdgetInset;
    }
    return STButtonConst.bigEdgetInset;
  }
}
