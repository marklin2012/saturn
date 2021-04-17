import 'package:flutter/material.dart';

import 'common.dart';

class ChoiceItem {
  String title;
  String message;
  String icon;
  bool isSelect;
  bool isAligmentCenter;
  bool haveSeparateLine;
  VoidCallback onItemTap;

  ChoiceItem(
      {this.title,
      this.message,
      this.icon,
      this.isSelect = false,
      this.isAligmentCenter = false,
      this.haveSeparateLine = false,
      this.onItemTap});
}

class STDialog extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final String icon;
  final String buttonText;
  final List choiceList;
  final bool isDoubleButton;
  final bool haveTextField;
  final VoidCallback onCancelTap;
  final VoidCallback onMakeSureTap;
  final STDialogType type;

  const STDialog({
    Key key,
    this.width,
    this.title,
    this.message,
    this.icon,
    this.buttonText,
    this.choiceList,
    this.isDoubleButton,
    this.haveTextField,
    this.onCancelTap,
    this.onMakeSureTap,
    this.type,
  }) : super(key: key);

  static void show({
    @required BuildContext context,
    int width,
    String title,
    String message,
    String icon,
    String buttonText,
    List choiceList,
    bool isDoubleButton = false,
    bool haveTextField = false,
    VoidCallback onCancelTap,
    VoidCallback onMakeSureTap,
    STDialogType type = STDialogType.dialog,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          if (onMakeSureTap == null) {}
          final toast = STDialog(
            width: width,
            title: title,
            message: message,
            icon: icon,
            buttonText: buttonText,
            choiceList: choiceList,
            isDoubleButton: isDoubleButton,
            haveTextField: haveTextField,
            onCancelTap: onCancelTap ??
                () {
                  STDialog.hide(context);
                },
            onMakeSureTap: onMakeSureTap ??
                () {
                  STDialog.hide(context);
                },
            type: type,
          );
          return toast;
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
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
    switch (widget.type) {
      case STDialogType.dialog:
        {
          containerWidth =
              screenWidth * STDialogConstant.dialogDefaultWidthPercent;
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

          if (!isEmptyArray(widget.choiceList)) {
            columnArray.add(const SizedBox(height: 16));

            for (int i = 0; i < widget.choiceList.length; i++) {
              columnArray.add(getLineWidget(containerWidth));

              final ChoiceItem model = widget.choiceList[i];
              final String title = model.title;
              final VoidCallback action = model.onItemTap;
              columnArray.add(
                SizedBox(
                    height: 44,
                    child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        onPressed: () {
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
                        ))),
              );
            }
          } else {
            String buttonText = "我知道了";
            if (widget.haveTextField) {
              buttonText = "确定";
              columnArray.add(SizedBox(
                width: containerWidth - 30,
                height: 36,
                child: TextField(
                  autofocus: true,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    hintText: "请输入",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ));
            }
            columnArray.add(const SizedBox(height: 16));

            columnArray.add(getLineWidget(containerWidth));
            if (widget.isDoubleButton) {
              columnArray.add(Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: containerWidth / 2.0 - 1,
                    child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        onPressed: () {
                          if (widget.onCancelTap != null) {
                            widget.onCancelTap();
                          }
                        },
                        child: const Text("取消",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: STDialogConstant.defaultButtonTextColor,
                                fontSize: 16,
                                decoration: TextDecoration.none))),
                  ),
                  Container(
                    width: 1,
                    height: 44,
                    color: const Color.fromRGBO(239, 243, 249, 1),
                  ),
                  SizedBox(
                      width: containerWidth / 2.0 - 1,
                      child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                          ),
                          onPressed: () {
                            if (widget.onMakeSureTap != null) {
                              widget.onMakeSureTap();
                            }
                          },
                          child: const Text("确定",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      STDialogConstant.defaultButtonTextColor,
                                  fontSize: 16,
                                  decoration: TextDecoration.none))))
                ],
              ));
            } else {
              columnArray.add(TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () {
                    if (widget.onMakeSureTap != null) {
                      widget.onMakeSureTap();
                    }
                  },
                  child: Text(buttonText,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: STDialogConstant.defaultButtonTextColor,
                          fontSize: 16,
                          decoration: TextDecoration.none))));
            }
          }
        }
        break;
      case STDialogType.list:
        {
          containerWidth =
              screenWidth * STDialogConstant.dialogDefaultWidthPercent;
          columnArray = [
            const SizedBox(
              height: 16,
            ),
            if (imageWidget != null)
              Row(
                children: [
                  imageWidget,
                  Column(
                    children: [titleWidget, messageWidget],
                  )
                ],
              )
            else
              messageWidget ?? Container(),
          ];

          for (int i = 0; i < widget.choiceList.length; i++) {
            columnArray
                .add(getChoiceItemWidget(widget.choiceList[i], containerWidth));
          }
          columnArray.add(Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(STDialogConstant.cornerRadius),
                color: STDialogConstant.defaultButtonTextColor,
              ),
              width: containerWidth - 24,
              height: 44,
              child: TextButton(
                onPressed: () {},
                child: const Text("操作",
                    style: TextStyle(
                        backgroundColor:
                            STDialogConstant.defaultButtonTextColor,
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ));
        }
        break;

      case STDialogType.dynamicList:
        {}
        break;
      case STDialogType.normal:
        {}
        break;
    }

    return Center(
      child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STDialogConstant.cornerRadius),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: columnArray,
          )),
    );
  }

  Widget getChoiceItemWidget(ChoiceItem item, double width) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: item.isAligmentCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (!item.isAligmentCenter) const SizedBox(height: 13),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!item.isAligmentCenter) const SizedBox(width: 24),
            if (item.isSelect)
              Radio(
                value: 1,
                groupValue: false,
                onChanged: (value) {},
              ),
            if (item.isSelect) const SizedBox(width: 16),
            if (!isNullOrEmpty(item.icon))
              Image.asset(item.icon, fit: BoxFit.fitWidth),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isNullOrEmpty(item.title))
                  Text(item.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          color: Colors.black)),
                if (!isNullOrEmpty(item.message))
                  Text(item.message,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          color: Colors.grey)),
              ],
            )
          ],
        ),
        const SizedBox(height: 13),
        if (item.haveSeparateLine) getLineWidget(width)
      ],
    );
  }

  Widget getLineWidget(double containerWidth) {
    return Container(
      width: containerWidth,
      height: 1,
      color: const Color.fromRGBO(239, 243, 249, 1),
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

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
