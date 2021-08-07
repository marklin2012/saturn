import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

enum STMenuType {
  button,
  underline,
  section,
  label,
}

class STMenuDataItem {
  final IconData icon;
  final String title;
  final bool disable;

  STMenuDataItem({this.icon, @required this.title, this.disable = false});
}

const defaultTextColor = Color(0xFF555555);

class STMenuItem extends StatelessWidget {
  final Function(int) onTap;
  final int index;
  final int current;
  final STMenuDataItem item;
  final STMenuType type;

  const STMenuItem({
    Key key,
    this.type = STMenuType.button,
    @required this.onTap,
    @required this.index,
    @required this.current,
    @required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == current;

    Color currentColor = Theme.of(context).primaryColor;
    if (type != STMenuType.button) {
      currentColor = Colors.transparent;
    }
    BoxDecoration decoration = BoxDecoration(
      color: index == current ? currentColor : Colors.transparent,
      borderRadius: const BorderRadius.all(
        Radius.circular(4),
      ),
    );

    Color selectedTextColor = Colors.white;

    if (type == STMenuType.underline) {
      selectedTextColor = const Color(0xFF000000);
      if (isSelected) {
        decoration = BoxDecoration(
          color: isSelected ? currentColor : Colors.transparent,
          border: const Border(
            bottom: BorderSide(width: 1, color: Color(0xFF095BF9)),
          ),
        );
      }
    } else if (type == STMenuType.section) {
      selectedTextColor = const Color(0xFF095BF9);
    } else if (type == STMenuType.label) {
      selectedTextColor = const Color(0xFF095BF9);
    }

    Widget innerContent = Text(
      item.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
        color: isSelected ? selectedTextColor : defaultTextColor,
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              color: isSelected ? selectedTextColor : defaultTextColor,
            ),
          ),
        ],
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap(index);
          }
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
          // height: 32,
          child: innerContent,
        ),
      ),
    );
  }
}
