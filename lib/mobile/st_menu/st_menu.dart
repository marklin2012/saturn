import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/mobile/st_menu/st_menu_item.dart';
import 'package:saturn/utils/globalkey_ext.dart';

class STMenu extends StatefulWidget {
  final List<STMenuDataItem> items;
  final STMenuType type;
  final Color? backgroundColor;
  final int? initIndex;
  final EdgeInsets? padding;
  final EdgeInsets? itemPadding;
  final Alignment alignment; // 当items小于一屏宽度时，可选择对齐方式
  final double? height;
  final Function(int)? onTap;

  const STMenu({
    Key? key,
    required this.items,
    this.type = STMenuType.button,
    this.backgroundColor,
    this.initIndex,
    this.padding,
    this.itemPadding,
    this.alignment = Alignment.center,
    this.height,
    this.onTap,
  }) : super(key: key);
  @override
  _STMenuState createState() => _STMenuState();
}

class _STMenuState extends State<STMenu> {
  late int _current;
  late ScrollController _scrollController;
  late List<Widget> _contents;
  late List<GlobalKey> _tabKeys;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabKeys = widget.items.map((e) => GlobalKey(debugLabel: e.title)).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onItemTap(int index) {
    if (index == _current) return;

    final key = _tabKeys[index];
    var offset = key.position()?.dx ?? 0;

    final ScrollPosition position = _scrollController.position;
    offset = (offset - position.viewportDimension / 2)
        .clamp(position.minScrollExtent, position.maxScrollExtent);

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );

    setState(() {
      _current = index;
      if (widget.onTap == null) return;
      widget.onTap!(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _current = widget.initIndex ?? 0;
    _contents = widget.items
        .asMap()
        .map((index, item) {
          final content = Container(
            key: _tabKeys[index],
            padding:
                widget.itemPadding ?? const EdgeInsets.symmetric(horizontal: 4),
            child: STMenuItem(
              type: widget.type,
              item: item,
              current: _current,
              index: index,
              onTap: onItemTap,
            ),
          );
          return MapEntry(
            index,
            content,
          );
        })
        .values
        .toList();
    if (widget.type == STMenuType.section) {
      final List<Widget> newContents = [];
      for (int i = 0; i < _contents.length; i++) {
        newContents.add(_contents[i]);
        if (i < _contents.length - 1) {
          newContents.add(
            Container(
              width: 1,
              height: 26,
              color: const Color(0xFFDFE2E7),
            ),
          );
        }
      }

      _contents = newContents;
    }

    final mainContent = Container(
      width: MediaQuery.of(context).size.width,
      alignment: widget.alignment,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _contents,
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? STColor.backgroundColor,
        border: widget.type == STMenuType.underline
            ? const Border(bottom: BorderSide(color: STColor.fourRankGrey))
            : null,
      ),
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: 16,
            vertical: widget.type == STMenuType.underline ? 0 : 6,
          ),
      height: widget.height ?? (widget.type == STMenuType.label ? 64 : 44),
      child: mainContent,
    );
  }
}
