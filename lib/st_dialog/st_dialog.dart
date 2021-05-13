import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';

class ChoiceItem {
  String title;
  String message;
  String icon;
  bool isRadio;
  bool isAligmentCenter;
  bool hasSeparateLine;
  VoidCallback onTap;

  ChoiceItem(
      {this.title,
      this.message,
      this.icon,
      this.isRadio = false,
      this.isAligmentCenter = false,
      this.hasSeparateLine = false,
      this.onTap});
}

class STDialog extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final String icon;
  final String makeSureText;
  final String cancelText;
  final List choiceList;
  final bool hasCancelButton;
  final bool hasTextField;
  final VoidCallback onCancelTap;
  final Function(String text, List selectArr) onMakeSureTap;
  final STDialogType type;
  final bool closable;
  final Color selectedColor;
  final bool showSelectColor;
  final bool isSingleSelect;

  const STDialog(
      {Key key,
      this.width,
      this.title,
      this.message,
      this.icon,
      this.makeSureText,
      this.cancelText,
      this.choiceList,
      this.hasCancelButton,
      this.hasTextField,
      this.onCancelTap,
      this.onMakeSureTap,
      this.type,
      this.closable,
      this.selectedColor,
      this.showSelectColor,
      this.isSingleSelect})
      : super(key: key);

  static void show({
    @required BuildContext context,
    int width,
    String title,
    String message,
    String icon,
    String makeSureText = "确定",
    String cancelText = "取消",
    List choiceList,
    bool hasCancelButton = false,
    bool hasTextField = false,
    VoidCallback onCancelTap,
    Function(String text, List selectArr) onMakeSureTap,
    STDialogType type = STDialogType.custom,
    bool closable = true,
    Color selectedColor = Colors.black12,
    bool showSelectColor = true,
    bool isSingleSelect = false,
  }) {
    final dialog = STDialog(
      width: width,
      title: title,
      message: message,
      icon: icon,
      makeSureText: makeSureText,
      cancelText: cancelText,
      choiceList: choiceList,
      hasCancelButton: hasCancelButton,
      hasTextField: hasTextField,
      onCancelTap: () {
        if (closable) STDialog.hide(context);
        if (onCancelTap != null) onCancelTap();
      },
      onMakeSureTap: (text, selectArr) {
        if (closable) STDialog.hide(context);
        if (onMakeSureTap != null) onMakeSureTap(text, selectArr);
      },
      type: type,
      closable: closable,
      selectedColor: selectedColor,
      showSelectColor: showSelectColor,
      isSingleSelect: isSingleSelect,
    );
    if (type == STDialogType.custom) {
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
          isDismissible: closable,
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
    switch (widget.type) {
      case STDialogType.custom:
        {
          containerWidth =
              screenWidth * STDialogConstant.customDefaultWidthPercent;
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
                    if (widget.onMakeSureTap != null) {
                      widget.onMakeSureTap(
                          widget.hasTextField ? textEditingController.text : "",
                          []);
                    }
                  },
                  child: Text(
                    widget.makeSureText,
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
                  widget.choiceList[i], i, containerWidth, widget.type),
            );
          }
          columnArray.add(
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: listViewList,
            )),
          );
          columnArray.add(widget.hasCancelButton
              ? getProcessButtons(containerWidth)
              : getProcessButton(containerWidth));
          if (widget.hasCancelButton)
            columnArray.add(const SizedBox(height: 16));
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
                    innerChoiceList[j], j, containerWidth, widget.type),
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

          columnArray.add(widget.hasCancelButton
              ? getProcessButtons(containerWidth)
              : getProcessButton(containerWidth));
          if (widget.hasCancelButton)
            columnArray.add(const SizedBox(height: 16));
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
                  child: widget.hasCancelButton
                      ? getProcessButtons(containerWidth)
                      : getProcessButton(containerWidth),
                ),
              ],
            )
          ];
        }
        break;
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
            if (widget.onMakeSureTap != null) {
              if (widget.type == STDialogType.list) {
                widget.onMakeSureTap("", selectedList);
              } else {
                widget.onMakeSureTap("", []);
              }
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
    final bool isDialog = widget.type == STDialogType.custom;
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
              child: Text(
                widget.cancelText,
                style: const TextStyle(
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
                  if (widget.type == STDialogType.list) {
                    widget.onMakeSureTap("", selectedList);
                  } else {
                    widget.onMakeSureTap("", []);
                  }
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

  Widget getChoiceItemWidget(
      ChoiceItem item, int index, double width, STDialogType type) {
    Widget content;
    if (type == STDialogType.list) {
      final bool isSelected = selectedList.contains(index);
      content = Container(
        color: (widget.showSelectColor && isSelected && !item.isRadio)
            ? widget.selectedColor
            : Colors.transparent,
        width: width,
        child: Column(
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
                if (item.isRadio)
                  Radio(
                    value: index,
                    groupValue: isSelected ? 1 : 0,
                    onChanged: null,
                  ),
                if (item.isRadio) const SizedBox(width: 16),
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
        ),
      );
    } else if (type == STDialogType.dynamicList) {
      content = Padding(
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
    }

    if (content != null) {
      return GestureDetector(
        onTap: () {
          if (item.onTap != null) item.onTap();
          if (type == STDialogType.list) {
            if (widget.isSingleSelect) {
              selectedList.clear();
              selectedList.add(index);
            } else {
              if (selectedList.contains(index)) {
                selectedList.remove(index);
              } else {
                selectedList.add(index);
              }
            }

            setState(() {});
          }
        },
        child: content,
      );
    }
    return content;
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
