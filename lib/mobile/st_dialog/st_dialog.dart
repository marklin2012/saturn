import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_dialog/common.dart';
import 'package:saturn/mobile/st_dialog/st_dialog_bottom_buttons.dart';
import 'package:saturn/mobile/st_dialog/st_dialog_option.dart';
import 'package:saturn/mobile/st_dialog/st_dialog_textfield.dart';
import 'package:saturn/utils/platform.dart';
import 'package:saturn/utils/string.dart';

class STDialog extends StatefulWidget {
  final double? width;
  final String? title;
  final String? message;
  final Widget? icon;
  final String? confirmTitle;
  final String? cancelTitle;
  final List? options;
  final bool? hasCancelButton;
  final bool? hasConfirmButton;
  final bool? hasTextField;
  final VoidCallback? onCancelTap;
  final Function(String text)? onConfirmTap;
  final bool? closable;

  const STDialog({
    Key? key,
    this.width,
    this.title,
    this.message,
    this.icon,
    this.confirmTitle,
    this.cancelTitle,
    this.options,
    this.hasCancelButton,
    this.hasConfirmButton,
    this.hasTextField,
    this.onCancelTap,
    this.onConfirmTap,
    this.closable,
  }) : super(key: key);

  static void show({
    required BuildContext context,
    double? width,
    String? title,
    String? message,
    Widget? icon,
    String confirmTitle = "确定",
    String cancelTitle = "确定",
    List? options,
    bool hasCancelButton = true,
    bool hasConfirmButton = false,
    bool hasTextField = false,
    VoidCallback? onCancelTap,
    Function(String text)? onConfirmTap,
    bool closable = true,
  }) {
    final dialog = STDialog(
      width: width,
      title: title,
      message: message,
      icon: icon,
      confirmTitle: confirmTitle,
      cancelTitle: cancelTitle,
      options: options,
      hasCancelButton: hasCancelButton,
      hasConfirmButton: hasConfirmButton,
      hasTextField: hasTextField,
      onCancelTap: () {
        if (closable) STDialog.hide(context);
        if (onCancelTap != null) onCancelTap();
      },
      onConfirmTap: (text) {
        if (closable) STDialog.hide(context);
        if (onConfirmTap != null) onConfirmTap(text);
      },
      closable: closable,
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return dialog;
        },);
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  _STDialogState createState() => _STDialogState();
}

class _STDialogState extends State<STDialog> {
  STDialogTextField? dialogTextField;
  List enteredList = [];

  @override
  void initState() {
    super.initState();
    if (widget.options != null) {
      for (int i = 0; i < widget.options!.length; i++) {
        enteredList.add([]);
      }
    }

    if (widget.hasTextField!) {
      dialogTextField = STDialogTextField();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double? containerWidth;

    Text? titleWidget;
    if (isNotEmpty(widget.title)) {
      titleWidget = Text(widget.title!,
          softWrap: true,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: STDialogConstant.titleFontSize,
              decoration: TextDecoration.none,),);
    }

    Text? messageWidget;
    if (isNotEmpty(widget.message)) {
      messageWidget = Text(
        widget.message!,
        softWrap: true,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: STDialogConstant.messageFontSize,
          decoration: TextDecoration.none,
        ),
      );
    }

    List<Widget?> columnArray;
    containerWidth = widget.width;
    double defaultWidth;
    if (getIsWeb()) {
      defaultWidth = screenWidth * STDialogConstant.defaultWidthPercent / 2.0;
    } else {
      defaultWidth = screenWidth * STDialogConstant.defaultWidthPercent;
    }
    containerWidth ??= defaultWidth;

    columnArray = [
      const SizedBox(
        height: 16,
      ),
      widget.icon ?? (titleWidget ?? Container()),
      if (widget.icon != null)
        const SizedBox(
          height: 12,
        )
      else
        const SizedBox(height: 8),
      if (messageWidget != null) messageWidget,
    ];

    if (widget.hasTextField!) {
      columnArray.add(dialogTextField);
    }

    addOptionsToColumn(containerWidth, columnArray);

    if (widget.hasCancelButton! || widget.hasConfirmButton!) {
      columnArray.add(const SizedBox(height: 16));
      columnArray.add(getLineWidget(containerWidth));
      columnArray.add(STDialogBottomButtons(
        hasCancelButton: widget.hasCancelButton,
        hasConfirmButton: widget.hasConfirmButton,
        cancelTitle: widget.cancelTitle,
        confirmTitle: widget.confirmTitle,
        onCancelTap: widget.onCancelTap,
        onConfirmTap: () {
          widget.onConfirmTap!(
              widget.hasTextField! ? dialogTextField!.getText() : "",);
        },
        containerWidth: containerWidth,
      ),);
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.closable!) {
                  STDialog.hide(context);
                }
              },
              child: Container(
                width: screenWidth,
                height: screenHeight,
                color: Colors.transparent,
              ),
            ),
            Center(
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(STDialogConstant.cornerRadius),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: columnArray as List<Widget>,
                ),
              ),
            ),
          ],
        ),);
  }

  void addOptionsToColumn(double containerWidth, List<Widget?> columnArray) {
    if (isEmptyArray(widget.options)) return;
    columnArray.add(const SizedBox(height: 16));

    for (int i = 0; i < widget.options!.length; i++) {
      columnArray.add(getLineWidget(containerWidth));

      final STDialogOption option = widget.options![i];
      columnArray.add(STDialogOptionWidget(
          dialogOption: option,
          containerWidth: containerWidth,
          closable: widget.closable,
          hide: () {
            STDialog.hide(context);
          },
          updateAction: () {
            setState(() {});
          },
          verticalIndex: i,
          enteredList: enteredList,),);
    }
  }

  Widget getLineWidget(double containerWidth) {
    return Container(
      width: containerWidth,
      height: 1,
      color: STDialogConstant.defaultLineColor,
    );
  }

  bool isEmptyArray(List? list) {
    if (list == null) {
      return true;
    } else {
      if (list.isEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }
}
