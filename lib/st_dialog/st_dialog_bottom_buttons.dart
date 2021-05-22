import 'package:flutter/material.dart';
import 'common.dart';

class STDialogBottomButtons extends StatelessWidget {
  final bool hasCancelButton;
  final bool hasConfirmButton;
  final String cancelTitle;
  final String confirmTitle;
  final VoidCallback onCancelTap;
  final VoidCallback onConfirmTap;
  final double containerWidth;

  const STDialogBottomButtons(
      {this.hasCancelButton,
      this.hasConfirmButton,
      this.cancelTitle,
      this.confirmTitle,
      this.onCancelTap,
      this.onConfirmTap,
      this.containerWidth});

  @override
  Widget build(BuildContext context) {
    if (!hasCancelButton && !hasConfirmButton) return null;
    if (hasCancelButton && hasConfirmButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: containerWidth / 2.0 - 1,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.transparent, width: 1)),
              ),
              onPressed: () {
                if (onCancelTap != null) {
                  onCancelTap();
                }
              },
              child: Text(
                cancelTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: STDialogConstant.defaultButtonTextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 44,
            color: STDialogConstant.defaultLineColor,
          ),
          SizedBox(
            width: containerWidth / 2.0 - 1,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white)),
              onPressed: () {
                if (onConfirmTap != null) {
                  onConfirmTap();
                }
              },
              child: Text(
                confirmTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: STDialogConstant.defaultButtonTextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      );
    } else {
      String text;
      if (hasCancelButton) text = cancelTitle;
      if (hasConfirmButton) text = confirmTitle;
      return SizedBox(
        width: containerWidth,
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            if (hasConfirmButton && onConfirmTap != null) {
              onConfirmTap();
            }
            if (hasCancelButton && onCancelTap != null) {
              onCancelTap();
            }
          },
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: STDialogConstant.defaultButtonTextColor,
                fontSize: 16,
                decoration: TextDecoration.none),
          ),
        ),
      );
    }
  }
}
