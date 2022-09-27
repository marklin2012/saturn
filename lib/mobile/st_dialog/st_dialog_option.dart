import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class STDialogOption {
  String? title;
  VoidCallback? onTap;

  STDialogOption({this.title, this.onTap});
}

class STDialogOptionWidget extends StatelessWidget {
  final STDialogOption? dialogOption;
  final double? containerWidth;
  final bool? closable;
  final VoidCallback? hide;
  final VoidCallback? updateAction;
  final int? verticalIndex;
  final List? enteredList;

  const STDialogOptionWidget({
    this.dialogOption,
    this.containerWidth,
    this.closable,
    this.hide,
    this.updateAction,
    this.verticalIndex,
    this.enteredList,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnter = enteredList!.contains(verticalIndex);

    Color curColor = Colors.transparent;
    if (isEnter) {
      curColor = STDialogConstant.optionHighlightColor.withOpacity(0.5);
    }
    final Widget content = SizedBox(
      width: containerWidth,
      height: 44,
      child: STButton(
        backgroundColor: curColor,
        onTap: () {
          if (closable!) {
            hide!();
          }
          if (dialogOption!.onTap != null) {
            dialogOption!.onTap!();
          }
        },
        text: dialogOption!.title,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: STDialogConstant.defaultButtonTextColor,
          fontSize: 16,
          decoration: TextDecoration.none,
        ),
      ),
    );
    return STMouseRegion(
      onEnter: (PointerEnterEvent details) {
        enteredList!.add(verticalIndex);
        updateAction!();
      },
      onExit: (PointerExitEvent details) {
        enteredList!.clear();
        updateAction!();
      },
      child: content,
    );
  }
}
