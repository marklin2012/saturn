import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';

class ChoiceItem {
  String title;
  String message;
  String icon;
  bool isSelectItem;
  bool isAligmentCenter;
  bool hasSeparateLine;
  VoidCallback onTap;

  ChoiceItem(
      {this.title,
      this.message,
      this.icon,
      this.isSelectItem = false,
      this.isAligmentCenter = false,
      this.hasSeparateLine = false,
      this.onTap});
}

class STDialog extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final String icon;
  final String buttonText;
  final List choiceList;
  final bool isDoubleButton;
  final bool hasTextField;
  final VoidCallback onCancelTap;
  final Function(String text) onMakeSureTap;
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
    this.hasTextField,
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
    bool hasTextField = false,
    VoidCallback onCancelTap,
    Function(String text) onMakeSureTap,
    STDialogType type = STDialogType.dialog,
  }) {
    final dialog = STDialog(
      width: width,
      title: title,
      message: message,
      icon: icon,
      buttonText: buttonText,
      choiceList: choiceList,
      isDoubleButton: isDoubleButton,
      hasTextField: hasTextField,
      onCancelTap: onCancelTap ??
          () {
            STDialog.hide(context);
          },
      onMakeSureTap: onMakeSureTap ??
          (text) {
            STDialog.hide(context);
          },
      type: type,
    );
    if (type == STDialogType.dialog) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialog;
          });
    } else {
      showModalBottomSheet(
          context: context,
          enableDrag: false,
          isDismissible: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return dialog;
          });
    }
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
              final VoidCallback action = model.onTap;
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
                    ),
                  ),
                ),
              );
            }
          } else {
            String buttonText = "我知道了";
            if (widget.hasTextField) {
              buttonText = "确定";
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
                          hintStyle: TextStyle(
                              color: STDialogConstant.textFieldThemeColor),
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
            if (widget.isDoubleButton) {
              columnArray.add(getDoubleButtons(containerWidth, widget.type));
            } else {
              columnArray.add(
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () {
                    if (widget.onMakeSureTap != null) {
                      widget.onMakeSureTap(widget.hasTextField
                          ? textEditingController.text
                          : "");
                    }
                  },
                  child: Text(
                    buttonText,
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
        break;
      case STDialogType.list:
        {
          containerWidth =
              screenWidth * STDialogConstant.listDefaultWidthPercent;
          columnArray = [
            const SizedBox(
              height: 16,
            ),
            if (imageWidget != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageWidget,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [titleWidget, messageWidget],
                  )
                ],
              )
            else
              messageWidget ?? Container(),
          ];

          final List<Widget> listViewList = [];
          for (int i = 0; i < widget.choiceList.length; i++) {
            listViewList.add(
              getChoiceItemWidget(
                  widget.choiceList[i], containerWidth, widget.type),
            );
          }
          columnArray.add(
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: listViewList,
            )),
          );
          columnArray.add(getListMakeSureButton(containerWidth));
        }
        break;

      case STDialogType.dynamicList:
        {
          containerWidth =
              screenWidth * STDialogConstant.dynamicListDefaultWidthPercent;
          columnArray = [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                if (!(titleWidget == null)) titleWidget,
                if (!(messageWidget == null)) messageWidget,
                const SizedBox(
                  height: 16,
                ),
              ],
            )
          ];
          for (int i = 0; i < widget.choiceList.length; i++) {
            final List innerChoiceList = widget.choiceList[i];
            final List<Widget> innerListViewList = [];
            for (int j = 0; j < innerChoiceList.length; j++) {
              innerListViewList.add(
                getChoiceItemWidget(
                    innerChoiceList[j], containerWidth, widget.type),
              );
            }
            columnArray.add(const SizedBox(height: 6));

            columnArray.add(SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: innerListViewList,
              ),
            ));
            columnArray.add(const SizedBox(height: 6));
            columnArray.add(getLineWidget(containerWidth));
          }

          columnArray.add(getListMakeSureButton(containerWidth));
        }
        break;
      case STDialogType.normal:
        {
          containerWidth =
              screenWidth * STDialogConstant.normalDefaultWidthPercent;
          columnArray = [
            Column(
              children: [
                if (!(imageWidget == null))
                  Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: imageWidget),
                const SizedBox(
                  height: 16,
                ),
                if (!(titleWidget == null))
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: titleWidget,
                  ),
                if (!(messageWidget == null))
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: messageWidget,
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                  child: getDoubleButtons(containerWidth, widget.type),
                ),
              ],
            )
          ];
        }
        break;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STDialogConstant.cornerRadius),
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
    );
  }

  Widget getListMakeSureButton(double containerWidth) {
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
          onPressed: () {},
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

  Widget getDoubleButtons(double containerWidth, STDialogType type) {
    final bool isDialog = type == STDialogType.dialog;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: isDialog ? 0 : 10.0),
          child: SizedBox(
            width:
                isDialog ? containerWidth / 2.0 - 1 : containerWidth / 2.0 - 20,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                side: MaterialStateProperty.all(BorderSide(
                    color: isDialog
                        ? Colors.transparent
                        : STDialogConstant.defaultButtonTextColor,
                    width: 1)),
              ),
              onPressed: () {
                if (widget.onCancelTap != null) {
                  widget.onCancelTap();
                }
              },
              child: const Text(
                "取消",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: STDialogConstant.defaultButtonTextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
        if (isDialog)
          Container(
            width: 1,
            height: 44,
            color: STDialogConstant.defaultLineColor,
          ),
        Padding(
          padding: EdgeInsets.only(right: isDialog ? 0 : 10.0),
          child: SizedBox(
            width:
                isDialog ? containerWidth / 2.0 - 1 : containerWidth / 2.0 - 20,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      isDialog
                          ? Colors.white
                          : STDialogConstant.defaultButtonTextColor)),
              onPressed: () {
                if (widget.onMakeSureTap != null) {
                  widget.onMakeSureTap(
                      widget.hasTextField ? textEditingController.text : "");
                }
              },
              child: Text(
                "确定",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDialog
                        ? STDialogConstant.defaultButtonTextColor
                        : Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget getChoiceItemWidget(ChoiceItem item, double width, STDialogType type) {
    if (type == STDialogType.list) {
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
              if (item.isSelectItem)
                Radio(
                  value: 1,
                  groupValue: false,
                  onChanged: (value) {},
                ),
              if (item.isSelectItem) const SizedBox(width: 16),
              if (!isNullOrEmpty(item.icon))
                Image.asset(item.icon, fit: BoxFit.fitWidth),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isNullOrEmpty(item.title))
                    Text(
                      item.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                  if (!isNullOrEmpty(item.message))
                    Text(
                      item.message,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          color: Colors.grey),
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 14),
          if (item.hasSeparateLine) getLineWidget(width)
        ],
      );
    } else if (type == STDialogType.dynamicList) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isNullOrEmpty(item.icon))
              Image.asset(item.icon, fit: BoxFit.fitWidth),
            if (!isNullOrEmpty(item.title))
              Text(
                item.title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
          ],
        ),
      );
    } else {
      return null;
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
