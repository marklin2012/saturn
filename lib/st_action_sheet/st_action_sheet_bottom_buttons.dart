import 'package:flutter/material.dart';
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
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  side: MaterialStateProperty.all(const BorderSide(
                      color: STActionSheetConstant.defaultButtonTextColor,
                      width: 1)),
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
                      color: STActionSheetConstant.defaultButtonTextColor,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: containerWidth / 2.0 - 20,
              child: TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    backgroundColor: MaterialStateColor.resolveWith((states) =>
                        STActionSheetConstant.defaultButtonTextColor)),
                onPressed: () {
                  if (onConfirmTap != null) {
                    onConfirmTap();
                  }
                },
                child: Text(
                  confirmTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
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
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(STActionSheetConstant.cornerRadius),
            color: STActionSheetConstant.defaultButtonTextColor,
          ),
          width: containerWidth - 24,
          height: 44,
          child: TextButton(
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
                  backgroundColor: STActionSheetConstant.defaultButtonTextColor,
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
    }
  }
}
