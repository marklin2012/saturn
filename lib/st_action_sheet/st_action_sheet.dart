import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';
import 'st_action_sheet_option.dart';

class STActionSheet extends StatefulWidget {
  final int width;
  final String title;
  final String message;
  final Widget icon;
  final String confirmTitle;
  final String cancelTitle;
  final List options;
  final bool hasCancelButton;
  final bool hasConfirmButton;
  final VoidCallback onCancelTap;
  final Function(String text, List selectArr) onConfirmTap;
  final STActionSheetDirectionType directionType;
  final bool closable;
  final bool canSelect;
  final Color selectedColor;
  final bool showSelectColor;
  final bool isSingleSelect;
  final bool isOptionAligmentCenter;

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
      this.hasConfirmButton,
      this.onCancelTap,
      this.onConfirmTap,
      this.directionType,
      this.closable,
      this.canSelect,
      this.selectedColor,
      this.showSelectColor,
      this.isSingleSelect,
      this.isOptionAligmentCenter})
      : super(key: key);

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
    VoidCallback onCancelTap,
    Function(String text, List selectArr) onConfirmTap,
    STActionSheetDirectionType directionType =
        STActionSheetDirectionType.vertical,
    bool closable = true,
    bool canSelect = true,
    Color selectedColor = Colors.black12,
    bool showSelectColor = true,
    bool isSingleSelect = false,
    bool isOptionAligmentCenter = false,
  }) {
    final actionSheet = STActionSheet(
      width: width,
      title: title,
      message: message,
      icon: icon,
      confirmTitle: confirmTitle,
      cancelTitle: cancelTitle,
      options: options,
      hasCancelButton: hasCancelButton,
      hasConfirmButton: hasConfirmButton,
      onCancelTap: () {
        if (closable) STActionSheet.hide(context);
        if (onCancelTap != null) onCancelTap();
      },
      onConfirmTap: (text, selectArr) {
        if (closable) STActionSheet.hide(context);
        if (onConfirmTap != null) onConfirmTap(text, selectArr);
      },
      directionType: directionType,
      closable: closable,
      canSelect: canSelect,
      selectedColor: selectedColor,
      showSelectColor: showSelectColor,
      isSingleSelect: isSingleSelect,
      isOptionAligmentCenter: isOptionAligmentCenter,
    );
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: closable,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return actionSheet;
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
  List selectedList = [];

  @override
  void initState() {
    super.initState();
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
              fontSize: STActionSheetConstant.titleFontSize,
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
          fontSize: STActionSheetConstant.messageFontSize,
          decoration: TextDecoration.none,
        ),
      );
    }

    List<Widget> columnArray;
    switch (widget.directionType) {
      case STActionSheetDirectionType.vertical:
        {
          containerWidth = screenWidth *
              STActionSheetConstant.verticalListDefaultWidthPercent;
          columnArray = [
            const SizedBox(
              height: 16,
            ),
            if (widget.icon != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon,
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

          addBottomButtonToColumn(containerWidth, columnArray);
        }
        break;

      case STActionSheetDirectionType.horizontal:
        {
          containerWidth = screenWidth *
              STActionSheetConstant.horizontalListDefaultWidthPercent;
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
            if (i == widget.options.length - 1 &&
                !widget.hasCancelButton &&
                !widget.hasConfirmButton) {
              columnArray.add(const SizedBox(height: 16));
            } else {
              columnArray.add(getLineWidget(containerWidth));
            }
          }

          addBottomButtonToColumn(containerWidth, columnArray);
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

  void addBottomButtonToColumn(
      double containerWidth, List<Widget> columnArray) {
    if (widget.hasCancelButton && widget.hasConfirmButton) {
      columnArray.add(const SizedBox(height: 16));
    }
    if (widget.hasCancelButton || widget.hasConfirmButton) {
      columnArray.add(getBottomButtons(containerWidth));
    }
    if (widget.hasCancelButton && widget.hasConfirmButton) {
      columnArray.add(const SizedBox(height: 16));
    }
  }

  Widget getBottomButtons(double containerWidth) {
    if (!widget.hasConfirmButton && !widget.hasCancelButton) return null;
    if (widget.hasConfirmButton && widget.hasCancelButton) {
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
                  if (widget.onConfirmTap != null) {
                    widget.onConfirmTap("", selectedList);
                  }
                },
                child: Text(
                  widget.confirmTitle,
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
      if (widget.hasCancelButton) text = widget.cancelTitle;
      if (widget.hasConfirmButton) text = widget.confirmTitle;
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
              if (widget.hasConfirmButton && widget.onConfirmTap != null) {
                widget.onConfirmTap("", selectedList);
              }
              if (widget.hasCancelButton && widget.onCancelTap != null) {
                widget.onCancelTap();
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

  Widget getChoiceItemWidget(STActionSheetOption item, int index, double width,
      STActionSheetDirectionType directionType) {
    Widget content;
    final bool isSelected = selectedList.contains(index);

    if (directionType == STActionSheetDirectionType.vertical) {
      content = Container(
        color: (widget.showSelectColor &&
                isSelected &&
                !item.isRadio &&
                widget.canSelect)
            ? widget.selectedColor
            : Colors.transparent,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.isOptionAligmentCenter
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (!widget.isOptionAligmentCenter) const SizedBox(height: 13),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isOptionAligmentCenter) const SizedBox(width: 24),
                if (item.isRadio)
                  Radio(
                    value: index,
                    groupValue: isSelected ? 1 : 0,
                    onChanged: null,
                  ),
                if (item.isRadio) const SizedBox(width: 16),
                if (isNotEmpty(item.icon))
                  Image.asset(item.icon, fit: BoxFit.fitWidth),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNotEmpty(item.title))
                      Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                    if (isNotEmpty(item.message))
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
            getLineWidget(width)
          ],
        ),
      );
    } else if (directionType == STActionSheetDirectionType.horizontal) {
      content = Container(
        color: (widget.showSelectColor &&
                isSelected &&
                !item.isRadio &&
                widget.canSelect)
            ? widget.selectedColor
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isNotEmpty(item.icon))
                Image.asset(item.icon, fit: BoxFit.fitWidth),
              if (isNotEmpty(item.title))
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
        ),
      );
    }

    if (content != null) {
      return GestureDetector(
        onTap: () {
          if (widget.canSelect) {
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
          } else {
            if (item.onTap != null) item.onTap();
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
