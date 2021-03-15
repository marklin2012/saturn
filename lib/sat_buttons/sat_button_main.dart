import 'package:flutter/material.dart';
import 'package:saturn/sat_buttons/sat_buttons.dart';

class SatButtonMain extends SatBtnTypeSizeState {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;
  final SatButtonSize btnSize;
  final SatButtonState btnState;

  const SatButtonMain({
    Key key,
    this.icon,
    @required this.label,
    this.onPressed,
    this.btnSize,
    this.btnState,
  }) : super(
            key: key,
            btnSize: btnSize,
            btnState: btnState,
            btnType: SatButtonType.SatTypeMain);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: btnH,
        width: btnW,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(space),
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

class SatButtonSub extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final double space;

  const SatButtonSub({Key key, this.icon, this.label, this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: buildChild(),
    );
  }

  Widget buildChild() {
    return icon == null
        ? label
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: space),
              label,
            ],
          );
  }
}
