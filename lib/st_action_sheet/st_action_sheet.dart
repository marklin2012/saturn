import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';
import 'st_action_sheet_option.dart';

class STActionSheet extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final String icon;
  final String confirmTitle;
  final String cancelTitle;
  final List options;
  final bool hasCancelButton;
  final bool hasTextField;
  final VoidCallback onCancelTap;
  final Function(String text, List selectArr) onMakeSureTap;
  final STActionSheetDirectionType directionType;
  final bool closable;
  final Color selectedColor;
  final bool showSelectColor;
  final bool isSingleSelect;

  const STActionSheet(
      {Key key,
      this.width,
      this.title,
      this.message,
      this.icon,
      this.confirmTitle,
      this.cancelTitle,
      this.options,
      this.hasCancelButton,
      this.hasTextField,
      this.onCancelTap,
      this.onMakeSureTap,
      this.directionType,
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
    List options,
    bool hasCancelButton = false,
    bool hasTextField = false,
    VoidCallback onCancelTap,
    Function(String text, List selectArr) onMakeSureTap,
    STActionSheetDirectionType directionType =
        STActionSheetDirectionType.vertical,
    bool closable = true,
    Color selectedColor = Colors.black12,
    bool showSelectColor = true,
    bool isSingleSelect = false,
  }) {
    final dialog = STActionSheet(
      width: width,
      title: title,
      message: message,
      icon: icon,
      confirmTitle: makeSureText,
      cancelTitle: cancelText,
      options: options,
      hasCancelButton: hasCancelButton,
      hasTextField: hasTextField,
      onCancelTap: () {
        if (closable) STActionSheet.hide(context);
        if (onCancelTap != null) onCancelTap();
      },
      onMakeSureTap: (text, selectArr) {
        if (closable) STActionSheet.hide(context);
        if (onMakeSureTap != null) onMakeSureTap(text, selectArr);
      },
      directionType: directionType,
      closable: closable,
      selectedColor: selectedColor,
      showSelectColor: showSelectColor,
      isSingleSelect: isSingleSelect,
    );
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: closable,
        backgroundColor: Colors.transparent,
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
  _STActionSheetState createState() => _STActionSheetState();
}

class _STActionSheetState extends State<STActionSheet> {
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
              fontSize: STActionSheetConstant.titleFontSize,
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
          fontSize: STActionSheetConstant.messageFontSize,
          decoration: TextDecoration.none,
        ),
      );
    }

    List<Widget> columnArray;
    switch (widget.directionType) {
      case STActionSheetDirectionType.vertical:
        {
          containerWidth =
              screenWidth * STActionSheetConstant.listDefaultWidthPercent;
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
          for (int i = 0; i < widget.options.length; i++) {
            listViewList.add(
              getChoiceItemWidget(
                  widget.options[i], i, containerWidth, widget.directionType),
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

      case STActionSheetDirectionType.horizontal:
        {
          containerWidth = screenWidth *
              STActionSheetConstant.dynamicListDefaultWidthPercent;
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
          for (int i = 0; i < widget.options.length; i++) {
            final List innerChoiceList = widget.options[i];
            final List<Widget> innerListViewList = [];
            for (int j = 0; j < innerChoiceList.length; j++) {
              innerListViewList.add(
                getChoiceItemWidget(innerChoiceList[j], j, containerWidth,
                    widget.directionType),
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
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.closable) {
                  STActionSheet.hide(context);
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
                      BorderRadius.circular(STActionSheetConstant.cornerRadius),
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
          borderRadius:
              BorderRadius.circular(STActionSheetConstant.cornerRadius),
          color: STActionSheetConstant.defaultButtonTextColor,
        ),
        width: containerWidth - 24,
        height: 44,
        child: TextButton(
          onPressed: () {
            if (widget.onMakeSureTap != null) {
              if (widget.directionType == STActionSheetDirectionType.vertical) {
                widget.onMakeSureTap("", selectedList);
              }
            }
          },
          child: const Text(
            "操作",
            style: TextStyle(
                backgroundColor: STActionSheetConstant.defaultButtonTextColor,
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
          padding: EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: containerWidth / 2.0 - 20,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                side: MaterialStateProperty.all(BorderSide(
                    color: STActionSheetConstant.defaultButtonTextColor,
                    width: 1)),
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
                    color: STActionSheetConstant.defaultButtonTextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: SizedBox(
            width: containerWidth / 2.0 - 20,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      STActionSheetConstant.defaultButtonTextColor)),
              onPressed: () {
                if (widget.onMakeSureTap != null) {
                  widget.onMakeSureTap("", selectedList);
                }
              },
              child: const Text(
                "确定",
                style: TextStyle(
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
  }

  Widget getChoiceItemWidget(STActionSheetOption item, int index, double width,
      STActionSheetDirectionType directionType) {
    Widget content;
    if (directionType == STActionSheetDirectionType.vertical) {
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
    } else if (directionType == STActionSheetDirectionType.horizontal) {
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
          if (directionType == STActionSheetDirectionType.vertical) {
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
      color: STActionSheetConstant.defaultLineColor,
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
