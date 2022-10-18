import 'package:flutter/material.dart';

enum STMenuType {
  button,
  underline,
  section,
  label,
}

class STMenuDataItem {
  final IconData? icon;
  final String title;
  final bool disable;
  final double fontSize;
  final String? subTitle;

  STMenuDataItem({
    this.icon,
    required this.title,
    this.disable = false,
    this.fontSize = 16,
    this.subTitle,
  });
}

const defaultTextColor = Color(0xFF555555);
const defaultCurBGColor = Color(0xFF1070FF);

class STMenuItem extends StatelessWidget {
  final Function(int) onTap;
  final int index;
  final int current;
  final STMenuDataItem item;
  final STMenuType type;

  const STMenuItem({
    Key? key,
    this.type = STMenuType.button,
    required this.onTap,
    required this.index,
    required this.current,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == current;

    Color currentColor = defaultCurBGColor;
    if (type != STMenuType.button) {
      currentColor = Colors.transparent;
    }
    final decoration = BoxDecoration(
      color: index == current ? currentColor : Colors.transparent,
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
    );

    Color selectedTextColor = Colors.white;

    if (type == STMenuType.underline) {
      selectedTextColor = const Color(0xFF000000);
    } else if (type == STMenuType.section) {
      selectedTextColor = const Color(0xFF095BF9);
    } else if (type == STMenuType.label) {
      selectedTextColor = const Color(0xFF095BF9);
    }

    Widget innerContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(
            item.title,
            style: TextStyle(
              fontSize: item.fontSize,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              decoration: TextDecoration.none,
              color: isSelected ? selectedTextColor : defaultTextColor,
            ),
          ),
          if (item.subTitle != null)
            Text(
              item.subTitle!,
              style: TextStyle(
                fontSize: item.fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                decoration: TextDecoration.none,
                color: isSelected ? selectedTextColor : defaultTextColor,
              ),
            ),
        ],
      ),
    );

    if (type == STMenuType.label) {
      innerContent = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null)
            Icon(
              item.icon,
              size: 24,
              color: isSelected ? selectedTextColor : defaultTextColor,
            ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: item.fontSize,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              color: isSelected ? selectedTextColor : defaultTextColor,
            ),
          ),
        ],
      );
    } else if (type == STMenuType.underline) {
      innerContent = Container(
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(width: 2, color: Color(0xFF095BF9)),
                )
              : null,
        ),
        child: Center(
          child: Text(
            item.title,
            style: TextStyle(
              fontSize: item.fontSize,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              decoration: TextDecoration.none,
              color: isSelected ? selectedTextColor : defaultTextColor,
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        highlightColor: currentColor,
        splashColor: currentColor,
        hoverColor: currentColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: decoration,
          child: innerContent,
        ),
      ),
    );
  }
}
