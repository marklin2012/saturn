import 'package:flutter/material.dart';

import 'package:saturn/sat_buttons/sat_button_include.dart';
import 'package:saturn/sat_color_utils.dart';

const SatBigSizeW = 172.0;
const SatSmallSizeW = 84.0;
const SatBigSizeH = 38.0;
const SatSmallSizeH = 24.0;
const SatSubSmallSpace = 4.0;
const SatSubBigSpace = 8.0;
const SatBtnEdgetInsetB = EdgeInsets.fromLTRB(16, 6, 16, 6);
const SatBtnEdgetInsetS = EdgeInsets.fromLTRB(
  12,
  3,
  12,
  3,
);

enum SatButtonType { SatTypeMain, SatTypeOutLine, SatTypeText, SatTypeIcon }

enum SatButtonSize { SatSizeBig, SatSizeSmall }

enum SatButtonState {
  SatStateDefault,
  SatStateFocus,
  SatStateLoading,
  SatStateDisable,
  SatStateSuccess,
  SatStateDanger
}

abstract class SatBtnTypeSizeState extends StatelessWidget {
  final SatButtonType btnType;
  final SatButtonSize btnSize;
  final SatButtonState btnState;

  const SatBtnTypeSizeState(
      {this.btnType = SatButtonType.SatTypeMain,
      this.btnSize = SatButtonSize.SatSizeBig,
      this.btnState = SatButtonState.SatStateDefault,
      Key key})
      : super(key: key);

  Color get backgroundColor {
    if (btnState == SatButtonState.SatStateSuccess) {
      return assistGreen;
    }
    if (btnState == SatButtonState.SatStateDanger) {
      return assistRed;
    }
    if (btnState == SatButtonState.SatStateFocus) {
      return secRankBlue;
    }
    if (btnState == SatButtonState.SatStateDisable) {
      return fourRankBlue;
    }
    return firRankBlue;
  }

  bool get disable {
    if (btnState == SatButtonState.SatStateDisable) {
      return true;
    }
    return false;
  }

  double get btnH {
    if (btnSize == SatButtonSize.SatSizeSmall) {
      return SatSmallSizeH;
    }
    return SatBigSizeH;
  }

  double get btnW {
    if (btnSize == SatButtonSize.SatSizeSmall) {
      return SatSmallSizeW;
    }
    return SatBigSizeW;
  }

  double get space {
    if (btnSize == SatButtonSize.SatSizeSmall) {
      return SatSubSmallSpace;
    }
    return SatSubBigSpace;
  }

  EdgeInsets get edgeInsets {
    if (btnSize == SatButtonSize.SatSizeSmall) {
      return SatBtnEdgetInsetS;
    }
    return SatBtnEdgetInsetB;
  }
}

class SatButtons extends SatBtnTypeSizeState {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;
  final SatButtonType btnType;
  final SatButtonSize btnSize;
  final SatButtonState btnState;

  const SatButtons(
      {Key key,
      this.icon,
      this.label,
      this.onPressed,
      this.btnSize,
      this.btnType,
      this.btnState})
      : super(key: key, btnSize: btnSize, btnType: btnType, btnState: btnState);

  @override
  Widget build(BuildContext context) {
    switch (btnType) {
      case SatButtonType.SatTypeOutLine:
        return SatButtonOutline(
          label: label,
          icon: icon,
          onPressed: onPressed,
          btnSize: btnSize,
          btnState: btnState,
        );
      case SatButtonType.SatTypeText:
        break;
      case SatButtonType.SatTypeIcon:
        break;
      default:
        return SatButtonMain(
          icon: icon,
          label: label,
          onPressed: onPressed,
          btnSize: btnSize,
          btnState: btnState,
        );
    }
    return Container();
  }
}
