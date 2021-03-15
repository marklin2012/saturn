import 'package:flutter/material.dart';
import 'package:saturn/sat_buttons/sat_button_include.dart';
import 'package:saturn/sat_color_utils.dart';

class SatButtonOutline extends SatBtnTypeSizeState {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;
  final SatButtonSize btnSize;
  final SatButtonState btnState;

  const SatButtonOutline(
      {Key key,
      this.icon,
      @required this.label,
      this.onPressed,
      this.btnSize,
      this.btnState})
      : super(
            key: key,
            btnSize: btnSize,
            btnState: btnState,
            btnType: SatButtonType.SatTypeOutLine);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: btnH,
        width: btnW,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(space),
          border: Border.all(
            color: firRankBlue,
          ),
        ),
        padding: edgeInsets,
        child: SatButtonSub(
          icon: icon,
          space: space,
          label: label,
        ),
      ),
      onTap: disable == false ? onPressed : null,
    );
  }
}
