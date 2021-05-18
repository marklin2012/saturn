import 'package:flutter/material.dart';
import 'package:saturn/st_dialog/st_dialog_option.dart';

import '../utils/string.dart';
import 'common.dart';

class STDialog extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final String icon;
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
    String icon,
    String makeSureText = "确定",
    String cancelText = "取消",
    List options,
    bool hasCancelButton = false,
    bool hasConfirmButton = false,
    bool hasTextField = false,
    VoidCallback onCancelTap,
    Function(String text, List selectArr) onMakeSureTap,
    bool closable = true,
  }) {
    final dialog = STDialog(
      width: width,
      title: title,
      message: message,
      icon: icon,
      confirmTitle: makeSureText,
      cancelTitle: cancelText,
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
        if (onMakeSureTap != null) onMakeSureTap(text, selectArr);
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

    Image imageWidget;
    if (!isNullOrEmpty(widget.icon)) {
      imageWidget = Image.asset(widget.icon, fit: BoxFit.fitWidth);
    }

    Text titleWidget;
    if (!isNullOrEmpty(widget.title)) {
      titleWidget = Text(widget.title,
          softWrap: true,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: STDialogConstant.titleFontSize,
              decoration: TextDecoration.none));
    }

    Text messageWidget;
    if (!isNullOrEmpty(widget.message)) {
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
      imageWidget ?? (titleWidget ?? Container()),
      const SizedBox(
        height: 4,
      ),
      messageWidget,
    ];

    if (!isEmptyArray(widget.options)) {
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
    } else {
      if (widget.hasTextField) {
        columnArray.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 36),
              child: Theme(
                data: ThemeData(
                    primaryColor: STDialogConstant.textFieldThemeColor),
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
      columnArray.add(const SizedBox(height: 16));

      columnArray.add(getLineWidget(containerWidth));
      if (widget.hasCancelButton) {
        columnArray.add(getProcessButtons(containerWidth));
      } else {
        columnArray.add(SizedBox(
          width: containerWidth,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onPressed: () {
              if (widget.onConfirmTap != null) {
                widget.onConfirmTap(
                    widget.hasTextField ? textEditingController.text : "", []);
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
        ));
      }
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

  Widget getProcessButton(double containerWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(STDialogConstant.cornerRadius),
          color: STDialogConstant.defaultButtonTextColor,
        ),
        width: containerWidth - 24,
        height: 44,
        child: TextButton(
          onPressed: () {
            if (widget.onConfirmTap != null) {
              widget.onConfirmTap("", []);
            }
          },
          child: const Text(
            "操作",
            style: TextStyle(
                backgroundColor: STDialogConstant.defaultButtonTextColor,
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget getProcessButtons(double containerWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: SizedBox(
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
        ),
        Container(
          width: 1,
          height: 44,
          color: STDialogConstant.defaultLineColor,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: SizedBox(
            width: containerWidth / 2.0 - 1,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white)),
              onPressed: () {
                if (widget.onConfirmTap != null) {
                  widget.onConfirmTap("", []);
                }
              },
              child: const Text(
                "确定",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: STDialogConstant.defaultButtonTextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        )
      ],
    );
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
