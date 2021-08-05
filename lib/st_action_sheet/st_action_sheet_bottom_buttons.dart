import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

import 'common.dart';

class STActionSheetBottomButtons extends StatelessWidget {
  final bool hasCancelButton;
  final bool hasConfirmButton;
  final String cancelTitle;
  final String confirmTitle;
  final VoidCallback onCancelTap;
  final VoidCallback onConfirmTap;
  final double containerWidth;

  const STActionSheetBottomButtons(
      {this.hasCancelButton,
      this.hasConfirmButton,
      this.cancelTitle,
      this.confirmTitle,
      this.onCancelTap,
      this.onConfirmTap,
      this.containerWidth});

  @override
  Widget build(BuildContext context) {
    if (!hasConfirmButton && !hasCancelButton) return null;
    if (hasConfirmButton && hasCancelButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: containerWidth / 2.0 - 20,
              child: STButton(
                backgroundColor: STActionSheetConstant.defaultButtonTextColor,
                onTap: () {
                  if (onCancelTap != null) {
                    onCancelTap();
                  }
                },
                text: cancelTitle,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: containerWidth / 2.0 - 20,
              child: STButton(
                backgroundColor: STActionSheetConstant.defaultButtonTextColor,
                onTap: () {
                  if (onConfirmTap != null) {
                    onConfirmTap();
                  }
                },
                text: confirmTitle,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          )
        ],
      );
    } else {
      String text;
      if (hasCancelButton) text = cancelTitle;
      if (hasConfirmButton) text = confirmTitle;
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(STActionSheetConstant.cornerRadius),
            color: Colors.transparent,
          ),
          width: containerWidth - 24,
          height: 44,
          child: STButton(
            backgroundColor: STActionSheetConstant.defaultButtonTextColor,
            onTap: () {
              if (hasConfirmButton && onConfirmTap != null) {
                onConfirmTap();
              }
              if (hasCancelButton && onCancelTap != null) {
                onCancelTap();
              }
            },
            text: text,
            textStyle: const TextStyle(
                backgroundColor: STActionSheetConstant.defaultButtonTextColor,
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      );
    }
  }
}
