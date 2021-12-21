import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/utils/include.dart';

import '../../utils/string.dart';
import 'common.dart';

class STActionSheetOption {
  String? title;
  String? message;
  Widget? icon;
  bool isRadio;
  VoidCallback? onTap;

  STActionSheetOption(
      {this.title, this.message, this.icon, this.isRadio = false, this.onTap});
}

class STActionSheetOptionWidget extends StatelessWidget
    with STActionSheetInterface {
  final STActionSheetOption? actionSheetOption;
  final int? verticalIndex;
  final int? horizontalIndex;
  final double? width;
  final STActionSheetDirectionType? directionType;
  final List? selectedList;
  final List? enteredList;
  final bool? canSelect;
  final Color? selectedColor;
  final bool? showSelectColor;
  final bool? isSingleSelect;
  final VoidCallback? selectAction;
  final bool? isOptionAligmentCenter;
  final int? totalCount;
  final bool? showSeperateLine;

  const STActionSheetOptionWidget(
      {this.actionSheetOption,
      this.verticalIndex,
      this.horizontalIndex,
      this.width,
      this.directionType,
      this.selectedList,
      this.enteredList,
      this.canSelect,
      this.selectedColor,
      this.showSelectColor,
      this.isSingleSelect,
      this.selectAction,
      this.isOptionAligmentCenter,
      this.totalCount,
      this.showSeperateLine});

  @override
  Widget build(BuildContext context) {
    Widget? content;

    bool? isSelected;
    bool? isEnter;
    if (directionType == STActionSheetDirectionType.vertical) {
      isSelected = selectedList!.contains(verticalIndex);
      isEnter = enteredList!.contains(verticalIndex);
    } else {
      isSelected = selectedList![verticalIndex!].contains(horizontalIndex);
      isEnter = enteredList![verticalIndex!].contains(horizontalIndex);
    }

    Color? curColor;
    if (showSelectColor! &&
        isSelected! &&
        !actionSheetOption!.isRadio &&
        canSelect!) {
      curColor = selectedColor;
    } else {
      curColor = Colors.transparent;
    }

    if (isEnter!) {
      curColor = selectedColor!.withOpacity(0.5);
    }

    if (directionType == STActionSheetDirectionType.vertical) {
      content = Container(
        color: curColor,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isOptionAligmentCenter!
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 13),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isOptionAligmentCenter!) const SizedBox(width: 20),
                if (actionSheetOption!.isRadio)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio(
                      value: 1,
                      groupValue: isSelected! ? 1 : 0,
                      onChanged: null,
                    ),
                  ),
                if (actionSheetOption!.isRadio) const SizedBox(width: 10),
                if (actionSheetOption!.icon != null) actionSheetOption!.icon!,
                if (actionSheetOption!.icon != null) const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNotEmpty(actionSheetOption!.title))
                      Text(
                        actionSheetOption!.title!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                    if (isNotEmpty(actionSheetOption!.message))
                      Text(
                        actionSheetOption!.message!,
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
            if (showSeperateLine! && (verticalIndex != totalCount! - 1))
              getLineWidget(width)
          ],
        ),
      );
    } else if (directionType == STActionSheetDirectionType.horizontal) {
      content = Container(
        color: curColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (actionSheetOption!.icon != null) actionSheetOption!.icon!,
              if (isNotEmpty(actionSheetOption!.title))
                Text(
                  actionSheetOption!.title!,
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
            if (canSelect!) {
              if (directionType == STActionSheetDirectionType.vertical) {
                if (isSingleSelect!) {
                  selectedList!.clear();
                  selectedList!.add(verticalIndex);
                } else {
                  if (selectedList!.contains(verticalIndex)) {
                    selectedList!.remove(verticalIndex);
                  } else {
                    selectedList!.add(verticalIndex);
                  }
                }
              } else {
                if (isSingleSelect!) {
                  for (int i = 0; i < selectedList!.length; i++) {
                    selectedList![i].clear();
                  }
                  selectedList![verticalIndex!].add(horizontalIndex);
                } else {
                  if (selectedList![verticalIndex!].contains(horizontalIndex)) {
                    selectedList![verticalIndex!].remove(horizontalIndex);
                  } else {
                    selectedList![verticalIndex!].add(horizontalIndex);
                  }
                }
              }

              selectAction!();
            } else {
              if (actionSheetOption!.onTap != null) actionSheetOption!.onTap!();
            }
          },
          child: STMouseRegion(
            onEnter: (PointerEnterEvent details) {
              selectAction!();
              if (directionType == STActionSheetDirectionType.vertical) {
                enteredList!.add(verticalIndex);
              } else {
                enteredList![verticalIndex!].add(horizontalIndex);
              }
            },
            onExit: (PointerExitEvent details) {
              if (directionType == STActionSheetDirectionType.vertical) {
                enteredList!.clear();
              } else {
                for (int i = 0; i < enteredList!.length; i++) {
                  enteredList![i].clear();
                }
              }

              selectAction!();
            },
            child: content,
          ));
    }
    return content!;
  }
}
