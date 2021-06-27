import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';

class STActionSheetOption {
  String title;
  String message;
  Widget icon;
  bool isRadio;
  VoidCallback onTap;

  STActionSheetOption(
      {this.title, this.message, this.icon, this.isRadio = false, this.onTap});
}

class STActionSheetOptionWidget extends StatelessWidget
    with STActionSheetInterface {
  final STActionSheetOption actionSheetOption;
  final int verticalIndex;
  final int horizontalIndex;
  final double width;
  final STActionSheetDirectionType directionType;
  final List selectedList;
  final bool canSelect;
  final Color selectedColor;
  final bool showSelectColor;
  final bool isSingleSelect;
  final VoidCallback selectAction;
  final bool isOptionAligmentCenter;

  const STActionSheetOptionWidget(
      {this.actionSheetOption,
      this.verticalIndex,
      this.horizontalIndex,
      this.width,
      this.directionType,
      this.selectedList,
      this.canSelect,
      this.selectedColor,
      this.showSelectColor,
      this.isSingleSelect,
      this.selectAction,
      this.isOptionAligmentCenter});

  @override
  Widget build(BuildContext context) {
    Widget content;

    bool isSelected;
    if (directionType == STActionSheetDirectionType.vertical) {
      isSelected = selectedList.contains(verticalIndex);
    } else {
      isSelected = selectedList[verticalIndex].contains(horizontalIndex);
    }

    if (directionType == STActionSheetDirectionType.vertical) {
      content = Container(
        color: (showSelectColor &&
                isSelected &&
                !actionSheetOption.isRadio &&
                canSelect)
            ? selectedColor
            : Colors.transparent,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isOptionAligmentCenter
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (!isOptionAligmentCenter) const SizedBox(height: 13),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isOptionAligmentCenter) const SizedBox(width: 24),
                if (actionSheetOption.isRadio)
                  Radio(
                    value: verticalIndex,
                    groupValue: isSelected ? 1 : 0,
                    onChanged: null,
                  ),
                if (actionSheetOption.isRadio) const SizedBox(width: 16),
                if (actionSheetOption.icon != null) actionSheetOption.icon,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNotEmpty(actionSheetOption.title))
                      Text(
                        actionSheetOption.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                    if (isNotEmpty(actionSheetOption.message))
                      Text(
                        actionSheetOption.message,
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
        color: (showSelectColor &&
                isSelected &&
                !actionSheetOption.isRadio &&
                canSelect)
            ? selectedColor
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (actionSheetOption.icon != null) actionSheetOption.icon,
              if (isNotEmpty(actionSheetOption.title))
                Text(
                  actionSheetOption.title,
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
          if (canSelect) {
            if (directionType == STActionSheetDirectionType.vertical) {
              if (isSingleSelect) {
                selectedList.clear();
                selectedList.add(verticalIndex);
              } else {
                if (selectedList.contains(verticalIndex)) {
                  selectedList.remove(verticalIndex);
                } else {
                  selectedList.add(verticalIndex);
                }
              }
            } else {
              if (isSingleSelect) {
                for (int i = 0; i < selectedList.length; i++) {
                  selectedList[i].clear();
                }
                selectedList[verticalIndex].add(horizontalIndex);
              } else {
                if (selectedList[verticalIndex].contains(horizontalIndex)) {
                  selectedList[verticalIndex].remove(horizontalIndex);
                } else {
                  selectedList[verticalIndex].add(horizontalIndex);
                }
              }
            }

            selectAction();
          } else {
            if (actionSheetOption.onTap != null) actionSheetOption.onTap();
          }
        },
        child: content,
      );
    }
    return content;
  }
}
