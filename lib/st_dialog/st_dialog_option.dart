import 'package:flutter/material.dart';
import 'common.dart';

class STDialogOption {
  String title;
  VoidCallback onTap;

  STDialogOption({this.title, this.onTap});
}

class STDialogOptionWidget extends StatelessWidget {
  final STDialogOption dialogOption;
  final double containerWidth;
  final bool closable;
  final VoidCallback hide;

  const STDialogOptionWidget(
      {this.dialogOption, this.containerWidth, this.closable, this.hide});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth,
      height: 44,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
              (states) => STDialogConstant.defaultMessageColor),
        ),
        onPressed: () {
          if (closable) {
            hide();
          }
          if (dialogOption.onTap != null) {
            dialogOption.onTap();
          }
        },
        child: Text(
          dialogOption.title,
          softWrap: true,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: STDialogConstant.defaultButtonTextColor,
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
