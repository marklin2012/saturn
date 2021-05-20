import 'package:flutter/material.dart';
import 'package:saturn/st_dialog/st_dialog_option.dart';

import '../utils/string.dart';
import 'common.dart';

class STDialog extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final Widget icon;
  final String confirmTitle;
  final String cancelTitle;
  final List options;
  final bool hasCancelButton;
  final bool hasConfirmButton;
  final bool hasTextField;
  final VoidCallback onCancelTap;
  final Function(String text, List selectArr) onConfirmTap;
  final bool closable;

  const STDialog({
    Key key,
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
    @required BuildContext context,
    int width,
    String title,
    String message,
    Widget icon,
    String confirmTitle = "确定",
    String cancelTitle = "确定",
    List options,
    bool hasCancelButton = true,
    bool hasConfirmButton = false,
    bool hasTextField = false,
    VoidCallback onCancelTap,
    Function(String text, List selectArr) onConfirmTap,
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
      onConfirmTap: (text, selectArr) {
        if (closable) STDialog.hide(context);
        if (onConfirmTap != null) onConfirmTap(text, selectArr);
      },
      closable: closable,
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return dialog;
        });
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
  FocusNode focusNode;
  TextEditingController textEditingController;
  List selectedList = [];

  @override
  void initState() {
    super.initState();

    if (widget.hasTextField) {
      focusNode = FocusNode();
      textEditingController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth;

    Text titleWidget;
    if (isNotEmpty(widget.title)) {
      titleWidget = Text(widget.title,
          softWrap: true,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: STDialogConstant.titleFontSize,
              decoration: TextDecoration.none));
    }

    Text messageWidget;
    if (isNotEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        softWrap: true,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: STDialogConstant.messageFontSize,
          decoration: TextDecoration.none,
        ),
      );
    }

    List<Widget> columnArray;
    containerWidth = screenWidth * STDialogConstant.defaultWidthPercent;
    columnArray = [
      const SizedBox(
        height: 16,
      ),
      widget.icon ?? (titleWidget ?? Container()),
      const SizedBox(
        height: 4,
      ),
      messageWidget,
    ];

    addTextFieldToColumn(columnArray);

    addOptionsToColumn(containerWidth, columnArray);

    if (widget.hasCancelButton || widget.hasConfirmButton) {
      columnArray.add(const SizedBox(height: 16));
      columnArray.add(getLineWidget(containerWidth));
      columnArray.add(getBottomButtons(containerWidth));
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.closable) {
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
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 5.0,
                        spreadRadius: 2.0),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: columnArray,
                ),
              ),
            ),
          ],
        ));
  }

  void addTextFieldToColumn(List<Widget> columnArray) {
    if (widget.hasTextField) {
      columnArray.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 36),
            child: Theme(
              data:
                  ThemeData(primaryColor: STDialogConstant.textFieldThemeColor),
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                focusNode: focusNode,
                cursorColor: STDialogConstant.textFieldThemeColor,
                decoration: const InputDecoration(
                  hintText: "请输入",
                  hintStyle:
                      TextStyle(color: STDialogConstant.textFieldThemeColor),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: STDialogConstant.textFieldThemeColor,
                        width: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void addOptionsToColumn(double containerWidth, List<Widget> columnArray) {
    if (isEmptyArray(widget.options)) return;
    columnArray.add(const SizedBox(height: 16));

    for (int i = 0; i < widget.options.length; i++) {
      columnArray.add(getLineWidget(containerWidth));

      final STDialogOption model = widget.options[i];
      final String title = model.title;
      final VoidCallback action = model.onTap;
      columnArray.add(
        SizedBox(
          width: containerWidth,
          height: 44,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onPressed: () {
              if (widget.closable) {
                STDialog.hide(context);
              }
              if (action != null) {
                action();
              }
            },
            child: Text(
              title,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: STDialogConstant.defaultButtonTextColor,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget getBottomButtons(double containerWidth) {
    if (!widget.hasCancelButton && !widget.hasConfirmButton) return null;
    if (widget.hasCancelButton && widget.hasConfirmButton) {
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
                if (widget.onCancelTap != null) {
                  widget.onCancelTap();
                }
              },
              child: Text(
                widget.cancelTitle,
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
                if (widget.onConfirmTap != null) {
                  widget.onConfirmTap(
                      widget.hasTextField ? textEditingController.text : "",
                      []);
                }
              },
              child: Text(
                widget.confirmTitle,
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
      if (widget.hasCancelButton) text = widget.cancelTitle;
      if (widget.hasConfirmButton) text = widget.confirmTitle;
      return SizedBox(
        width: containerWidth,
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            if (widget.hasConfirmButton && widget.onConfirmTap != null) {
              widget.onConfirmTap(
                  widget.hasTextField ? textEditingController.text : "", []);
            }
            if (widget.hasCancelButton && widget.onCancelTap != null) {
              widget.onCancelTap();
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

  Widget getLineWidget(double containerWidth) {
    return Container(
      width: containerWidth,
      height: 1,
      color: STDialogConstant.defaultLineColor,
    );
  }

  bool isEmptyArray(List list) {
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
