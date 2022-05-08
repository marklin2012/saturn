import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/mobile/st_menu/st_menu_item.dart';

class STMenu extends StatefulWidget {
  final List<STMenuDataItem> items;
  final STMenuType type;
  final Function(int)? onTap;

  const STMenu(
      {Key? key,
      required this.items,
      this.type = STMenuType.button,
      this.onTap})
      : super(key: key);
  @override
  _STMenuState createState() => _STMenuState();
}

class _STMenuState extends State<STMenu> {
  int _current = 0;

  void onItemTap(int index) {
    setState(() {
      _current = index;
      if (widget.onTap != null) {
        widget.onTap!(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = widget.items
        .asMap()
        .map((index, item) {
          Widget content = Expanded(
            child: STMenuItem(
              type: widget.type,
              item: item,
              current: _current,
              index: index,
              onTap: onItemTap,
            ),
          );
          if (widget.items.length > 5) {
            content = Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: STMenuItem(
                type: widget.type,
                item: item,
                current: _current,
                index: index,
                onTap: onItemTap,
              ),
            );
          }
          return MapEntry(
            index,
            content,
          );
        })
        .values
        .toList();
    if (widget.type == STMenuType.section) {
      final List<Widget> newContents = [];
      for (int i = 0; i < contents.length; i++) {
        newContents.add(contents[i]);
        if (i < contents.length - 1) {
          newContents.add(
            Container(
              width: 1,
              height: 26,
              color: const Color(0xFFDFE2E7),
            ),
          );
        }
      }

      contents = newContents;
    }

    Widget mainContent = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: contents,
    );
    if (widget.items.length > 5) {
      mainContent = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: contents,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: STColor.backgroundColor,
        border: widget.type == STMenuType.underline
            ? const Border(bottom: BorderSide(color: STColor.fourRankGrey))
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: widget.type == STMenuType.underline ? 0 : 6,
      ),
      height: widget.type == STMenuType.label ? 64 : 44,
      child: mainContent,
    );
  }
}
