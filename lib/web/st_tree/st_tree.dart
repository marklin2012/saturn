import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_tree/st_tree_provider.dart';
import 'package:saturn/web/st_tree/st_tree_search.dart';

class STTreeData {
  final String title;
  final String? key;
  final IconData? icon;
  final bool disabled;
  bool isOpened;
  bool checked;
  final List<STTreeData>? subs;

  STTreeData({
    required this.title,
    this.key,
    this.icon,
    this.disabled = false,
    this.checked = false,
    this.isOpened = false,
    this.subs,
  });
}

enum STTreeArrowType {
  normal,
  outline,
  addsub,
}

class STTree extends StatelessWidget {
  const STTree({
    Key? key,
    required this.items,
    this.isSearh = false,
    this.checkable = false,
    this.showLine = false,
    this.type = STTreeArrowType.normal,
    this.padding = const EdgeInsets.all(40.0),
    this.checkChanged,
  }) : super(key: key);

  final bool isSearh;
  final bool checkable;
  final bool showLine;
  final STTreeArrowType type;
  final List<STTreeData> items;
  final EdgeInsets padding;
  final Function(List<STTreeData>)? checkChanged;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => STTreeProvider(items: items),
      child: _buildConsumer(),
    );
  }

  Widget _buildConsumer() {
    return Consumer<STTreeProvider>(
      builder: (cnt, provider, _) {
        final List<Widget> _children = [];
        if (isSearh) {
          _children.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
              child: STTreeSearch(
                onChanged: (String str) {
                  provider.search(str);
                },
              ),
            ),
          );
        }
        for (int i = 0; i < provider.items.length; i++) {
          final _item = provider.items[i];
          final _itemWidget = _currentLevel(
            provider: provider,
            index: i,
            data: _item,
          );
          _children.add(_itemWidget);
        }

        return Container(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _children,
          ),
        );
      },
    );
  }

  Widget _currentLevel({
    required STTreeProvider provider,
    required int index,
    required STTreeData data,
  }) {
    EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 24.0);
    if (data.subs != null && index == data.subs!.length - 1) {
      _padding = const EdgeInsets.fromLTRB(24, 0, 24, 0);
    } else if (showLine) {
      _padding = const EdgeInsets.symmetric(horizontal: 12.0);
    }

    /// 是否展开
    final _isOpen = data.isOpened;
    return Container(
      padding: _padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCurrentRow(
            provider: provider,
            index: index,
            data: data,
          ),
          if (_isOpen)
            Container(
              margin: showLine ? const EdgeInsets.only(left: 11.5) : null,
              decoration: showLine
                  ? const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: STColor.thrRankGrey),
                      ),
                    )
                  : null,
              child: STTree(
                padding: EdgeInsets.zero,
                checkable: checkable,
                showLine: showLine,
                items: data.subs!,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentRow({
    required STTreeProvider provider,
    required int index,
    required STTreeData data,
  }) {
    final List<Widget> _children = [];
    Widget _iconArrow = const SizedBox();

    /// 是否有子集
    final _hasSubs = data.subs != null && data.subs!.isNotEmpty;
    if (_hasSubs) {
      _iconArrow = GestureDetector(
        onTap: () {
          if (data.disabled) return;
          provider.changeOpened(data: data);
        },
        child: _buildArrow(index: index, data: data),
      );
    }
    _children.add(
      SizedBox(
        height: 24,
        width: 24,
        child: _iconArrow,
      ),
    );
    if (checkable) {
      _children.add(
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: _buildCheck(
            provider: provider,
            index: index,
            data: data,
          ),
        ),
      );
    }
    if (data.icon != null) {
      _children.add(
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Icon(
            data.icon,
            size: 16,
            color: STColor.firRankFont,
          ),
        ),
      );
    }
    _children.add(
      Text(
        data.title,
        style: TextStyle(
          color: data.disabled ? STColor.fourRankFont : STColor.firRankFont,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return SizedBox(
      height: 24,
      child: Row(
        children: _children,
      ),
    );
  }

  Widget _buildCheck({
    required STTreeProvider provider,
    required int index,
    required STTreeData data,
  }) {
    final _onCheck = data.checked;
    return STMouseRegion(
      child: GestureDetector(
        onTap: () {
          if (data.disabled) return;
          provider.changeChecked(data: data);
          if (checkChanged == null) return;
          checkChanged!(provider.checkItems);
        },
        child: Container(
          height: 16,
          width: 16,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(
                color:
                    data.disabled ? STColor.thrRankGrey : STColor.thrRankFont),
            color: _onCheck ? STColor.firRankBlue : Colors.transparent,
          ),
          child: _onCheck
              ? const Icon(
                  STIcons.commonly_selected_outline,
                  size: 12,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildArrow({
    required int index,
    required STTreeData data,
  }) {
    IconData _iconData;
    final _isOpen = data.isOpened;
    if (type == STTreeArrowType.normal) {
      _iconData =
          _isOpen ? STIcons.direction_caretdown : STIcons.direction_caretright;
    } else if (type == STTreeArrowType.outline) {
      _iconData = _isOpen
          ? STIcons.direction_downoutlined
          : STIcons.direction_rightoutlined;
    } else {
      _iconData =
          _isOpen ? Icons.add_circle_outline : Icons.remove_circle_outline;
    }
    return Icon(
      _iconData,
      size: 12,
      color: Colors.black,
    );
  }
}
