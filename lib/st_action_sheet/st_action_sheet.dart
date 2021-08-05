import 'package:flutter/material.dart';

import '../utils/platform.dart';
import '../utils/string.dart';
import 'common.dart';
import 'st_action_sheet_bottom_buttons.dart';
import 'st_action_sheet_option.dart';

class STActionSheet extends StatefulWidget {
  final double width;
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
  final double listHeight;
  final bool showSeperateLine;

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
      this.isOptionAligmentCenter,
      this.listHeight,
      this.showSeperateLine})
      : super(key: key);

  static void show({
    @required BuildContext context,
    double width,
    String title,
    String message,
    Widget icon,
    String confirmTitle = "确定",
    String cancelTitle = "确定",
    List options = const [],
    bool hasCancelButton = true,
    bool hasConfirmButton = false,
    VoidCallback onCancelTap,
    Function(List selectList) onConfirmTap,
    STActionSheetDirectionType directionType =
        STActionSheetDirectionType.vertical,
    bool closable = true,
    bool canSelect = true,
    Color selectedColor = STActionSheetConstant.optionHighlightColor,
    bool showSelectColor = true,
    bool isSingleSelect = false,
    bool isOptionAligmentCenter = false,
    double listHeight = 200,
    bool showSeperateLine = false,
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
      listHeight: listHeight,
      showSeperateLine: showSeperateLine,
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
  List enteredList = [];

  @override
  void initState() {
    super.initState();
    if (widget.directionType == STActionSheetDirectionType.horizontal) {
      for (int i = 0; i < widget.options.length; i++) {
        selectedList.add([]);
        enteredList.add([]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = widget.width;

    double defaultWidth;
    if (getIsWeb()) {
      defaultWidth = screenWidth / 2.0;
    } else {
      defaultWidth = screenWidth;
    }
    containerWidth ??= defaultWidth;

    Widget titleWidget;
    if (isNotEmpty(widget.title)) {
      titleWidget = Text(
        widget.title,
        softWrap: true,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: STActionSheetConstant.titleFontSize,
            decoration: TextDecoration.none),
      );
    }

    Widget messageWidget;
    if (isNotEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        softWrap: true,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: STActionSheetConstant.messageColor,
          fontSize: STActionSheetConstant.messageFontSize,
          decoration: TextDecoration.none,
        ),
      );
    }

    List<Widget> columnArray;
    switch (widget.directionType) {
      case STActionSheetDirectionType.vertical:
        {
          columnArray = [
            const SizedBox(
              height: 16,
            ),
            if (widget.icon != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  widget.icon,
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (titleWidget != null) titleWidget,
                      if (messageWidget != null) messageWidget
                    ],
                  )
                ],
              ),
            if (widget.icon == null && titleWidget != null)
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: titleWidget),
            if (widget.icon == null && messageWidget != null)
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: messageWidget),
            const SizedBox(
              height: 16,
            ),
            if (widget.title != null) getLineWidget(containerWidth)
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
              enteredList: enteredList,
              canSelect: widget.canSelect,
              selectedColor: widget.selectedColor,
              showSelectColor: widget.showSelectColor,
              isSingleSelect: widget.isSingleSelect,
              selectAction: () {
                setState(() {});
              },
              isOptionAligmentCenter: widget.isOptionAligmentCenter,
              showSeperateLine: widget.showSeperateLine,
              totalCount: widget.options.length,
            ));
          }
          columnArray.add(
            SizedBox(
              height: widget.listHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: listViewList,
                ),
              ),
            ),
          );

          addBottomButtonToColumn(containerWidth, columnArray);
        }
        break;

      case STActionSheetDirectionType.horizontal:
        {
          columnArray = [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                if (widget.icon != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      widget.icon,
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (titleWidget != null) titleWidget,
                          if (messageWidget != null) messageWidget
                        ],
                      )
                    ],
                  ),
                if (widget.icon == null && titleWidget != null) titleWidget,
                if (widget.icon == null && messageWidget != null) messageWidget,
                const SizedBox(
                  height: 16,
                ),
              ],
            )
          ];
          if (widget.title != null)
            columnArray.add(getLineWidget(containerWidth));

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
                enteredList: enteredList,
                canSelect: widget.canSelect,
                selectedColor: widget.selectedColor,
                showSelectColor: widget.showSelectColor,
                isSingleSelect: widget.isSingleSelect,
                selectAction: () {
                  setState(() {});
                },
                isOptionAligmentCenter: widget.isOptionAligmentCenter,
              ));
            }
            columnArray.add(const SizedBox(height: 12));
            columnArray.add(Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: horizontalListViewList,
                ),
              ),
            ));
            columnArray.add(const SizedBox(height: 6));
            if (i == widget.options.length - 1 &&
                !widget.hasCancelButton &&
                !widget.hasConfirmButton) {
              columnArray.add(const SizedBox(height: 16));
            } else if (widget.options.length != 1 &&
                widget.title == null &&
                (i != widget.options.length - 1)) {
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: containerWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(STActionSheetConstant.cornerRadius),
                    topRight:
                        Radius.circular(STActionSheetConstant.cornerRadius)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    (titleWidget != null && messageWidget != null)
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                children: columnArray,
              ),
            ),
          )
        ],
      ),
    );
  }

  void addBottomButtonToColumn(
      double containerWidth, List<Widget> columnArray) {
    if (widget.hasCancelButton && widget.hasConfirmButton) {
      columnArray.add(const SizedBox(height: 16));
    }
    if (widget.hasCancelButton || widget.hasConfirmButton) {
      columnArray.add(
        Center(
          child: Center(
            child: STActionSheetBottomButtons(
              hasCancelButton: widget.hasCancelButton,
              hasConfirmButton: widget.hasConfirmButton,
              cancelTitle: widget.cancelTitle,
              confirmTitle: widget.confirmTitle,
              onCancelTap: widget.onCancelTap,
              onConfirmTap: () {
                widget.onConfirmTap(selectedList);
              },
              containerWidth: containerWidth,
            ),
          ),
        ),
      );
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
