import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';
import 'st_action_sheet_bottom_buttons.dart';
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
  final Function(List selectArr) onConfirmTap;
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
    Function(List selectList) onConfirmTap,
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
      onConfirmTap: (selectArr) {
        if (closable) STActionSheet.hide(context);
        if (onConfirmTap != null) onConfirmTap(selectArr);
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

class _STActionSheetState extends State<STActionSheet>
    with STActionSheetInterface {
  List selectedList = [];

  @override
  void initState() {
    super.initState();
    if (widget.directionType == STActionSheetDirectionType.horizontal) {
      for (int i = 0; i < widget.options.length; i++) {
        selectedList.add([]);
      }
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
            listViewList.add(STActionSheetOptionWidget(
                actionSheetOption: widget.options[i],
                verticalIndex: i,
                horizontalIndex: 0,
                width: containerWidth,
                directionType: widget.directionType,
                selectedList: selectedList,
                canSelect: widget.canSelect,
                selectedColor: widget.selectedColor,
                showSelectColor: widget.showSelectColor,
                isSingleSelect: widget.isSingleSelect,
                selectAction: () {
                  setState(() {});
                },
                isOptionAligmentCenter: widget.isOptionAligmentCenter));
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
            final List optionList = widget.options[i];
            final List<Widget> horizontalListViewList = [];
            for (int j = 0; j < optionList.length; j++) {
              horizontalListViewList.add(STActionSheetOptionWidget(
                  actionSheetOption: optionList[j],
                  verticalIndex: i,
                  horizontalIndex: j,
                  width: containerWidth,
                  directionType: widget.directionType,
                  selectedList: selectedList,
                  canSelect: widget.canSelect,
                  selectedColor: widget.selectedColor,
                  showSelectColor: widget.showSelectColor,
                  isSingleSelect: widget.isSingleSelect,
                  selectAction: () {
                    setState(() {});
                  },
                  isOptionAligmentCenter: widget.isOptionAligmentCenter));
            }
            columnArray.add(const SizedBox(height: 6));

            columnArray.add(SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: horizontalListViewList,
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
      columnArray.add(STActionSheetBottomButtons(
        hasCancelButton: widget.hasCancelButton,
        hasConfirmButton: widget.hasConfirmButton,
        cancelTitle: widget.cancelTitle,
        confirmTitle: widget.confirmTitle,
        onCancelTap: widget.onCancelTap,
        onConfirmTap: () {
          widget.onConfirmTap(selectedList);
        },
        containerWidth: containerWidth,
      ));
    }
    if (widget.hasCancelButton && widget.hasConfirmButton) {
      columnArray.add(const SizedBox(height: 16));
    }
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
