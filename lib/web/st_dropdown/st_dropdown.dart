import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_dropdown/st_dropdown_overlay.dart';

class STDropdown extends StatefulWidget {
  const STDropdown({
    Key? key,
    required this.triggerData,
    this.itemDatas,
    this.selectedCallback,
  }) : super(key: key);

  final STDropdownTriggerData triggerData;
  final List<STDropdownItemData>? itemDatas;
  final Function(List<STDropdownItemData>)? selectedCallback;

  @override
  _STDropdownState createState() => _STDropdownState();
}

class _STDropdownState extends State<STDropdown> {
  static const _cascadingWidth = 256.0;
  static const _normalWidth = 148.0;

  OverlayState? _overlayState;
  List<OverlayEntry?> _entrys = [];
  List<STDropdownItemData> _selectedItems = [];
  bool _isCascading = false;
  int _depth = 0;
  int _maxItems = 0;
  double _entryWidth = 0;
  double _entryHeight = 0;
  Offset _firstEntryOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    var _temp = 1;
    if (widget.itemDatas != null) {
      _maxItems = widget.itemDatas!.length;
      for (final item in widget.itemDatas!) {
        if (item.nextDatas != null && item.nextDatas!.isNotEmpty) {
          _isCascading = true;
        }
        _temp = max(_temp, _caculateDepth(item));
        _caculateMaxImtes(item);
      }
    }
    _depth = _temp;
    _entryWidth = _caculateEntryWidth();
    _entryHeight = _maxItems * 32.0 + 8.0;
    debugPrint('深度:$_depth,宽度:$_entryWidth,最大items:$_maxItems');
  }

  int _caculateDepth(STDropdownItemData data) {
    if (data.nextDatas == null || data.nextDatas!.isEmpty) return 1;
    var _temp = 1;
    for (final _item in data.nextDatas!) {
      final _itemDepth = _caculateDepth(_item) + 1;
      _temp = max(_temp, _itemDepth);
    }
    return _temp;
  }

  int _caculateMaxImtes(STDropdownItemData data) {
    if (data.nextDatas == null || data.nextDatas!.isEmpty) return 0;
    final _temp = data.nextDatas!.length;
    _maxItems = max(_maxItems, _temp);
    for (final _item in data.nextDatas!) {
      _maxItems = max(_maxItems, _caculateMaxImtes(_item));
    }
    return _temp;
  }

  double _caculateEntryWidth() {
    if (_depth == 1) return _normalWidth;
    return _cascadingWidth + (_normalWidth + 4) * (_depth - 1);
  }

  @override
  Widget build(BuildContext context) {
    return STDropdownTrigger(
      data: widget.triggerData,
      showFunc: (position) {
        _show(position);
      },
      hideFunc: () {
        _hide();
      },
    );
  }

  void _show(STDropdownPositon position) {
    if (widget.itemDatas == null || widget.itemDatas!.isEmpty) return;
    var _left = position.offset!.dx;
    var _top = position.offset!.dy + position.size!.height + 4.0;
    // 计算entry宽度 确定左边还是右边
    if (widget.triggerData.aligment == STDropdownTriggerAligment.center) {
      _left -= (_entryWidth - position.size!.width) / 2;
    } else if (widget.triggerData.aligment == STDropdownTriggerAligment.right) {
      _left -= _entryWidth - position.size!.width;
    }
    if (_top + _entryHeight > MediaQuery.of(context).size.height) {
      _top = _top - _entryHeight - position.size!.height;
    }
    _firstEntryOffset = Offset(_left, _top);
    _realityShow(left: _left, top: _top);
  }

  void _realityShow({double left = 0.0, double top = 0.0}) {
    _overlayState = Overlay.of(context);
    final _entry = OverlayEntry(
      builder: (ctx) {
        return Stack(
          children: [
            if (widget.triggerData.triggerMode ==
                STDropdownTriggerMode.clickLeft)
              GestureDetector(
                onTap: () {
                  _hide();
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                ),
              ),
            Positioned(
              left: left,
              top: top,
              child: STDropdownEntry(
                items: widget.itemDatas!,
                isCascarding: _isCascading,
                selectedItem:
                    _selectedItems.isNotEmpty ? _selectedItems.first : null,
                onTap: (STDropdownItemData data) {
                  _selectedItems = [];
                  _selectedItems.add(data);
                  _dealEntry(1);
                  _overlayState?.setState(() {});
                  if (data.nextDatas != null && data.nextDatas!.isNotEmpty) {
                    _addSubEntry();
                  } else {
                    _hide();
                  }
                  if (widget.selectedCallback == null) return;
                  widget.selectedCallback!(_selectedItems);
                },
              ),
            ),
          ],
        );
      },
    );
    _entrys.add(_entry);
    _overlayState?.insert(_entry);
  }

  void _hide() {
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var entry in _entrys) {
        entry?.remove();
        entry = null;
      }
      _entrys = [];
      _selectedItems = [];
    });
  }

  void _dealEntry(int rank) {
    if (_entrys.length <= rank) return;
    for (int i = 0; i < _entrys.length; i++) {
      if (i >= rank) {
        var entry = _entrys[i];
        entry?.remove();
        entry = null;
      }
    }
    _entrys = _entrys.sublist(0, rank);
  }

  void _addSubEntry() {
    _overlayState = Overlay.of(context);
    final _rank = _selectedItems.length;
    final _rankEntry = OverlayEntry(
      builder: (ctx) {
        return Stack(
          children: [
            Positioned(
              left: _firstEntryOffset.dx +
                  _cascadingWidth +
                  _rank * 4 +
                  (_rank - 1) * _normalWidth,
              top: _firstEntryOffset.dy,
              child: STDropdownEntry(
                items: _selectedItems[_rank - 1].nextDatas!,
                selectedItem: _selectedItems.length > _rank
                    ? _selectedItems[_rank]
                    : null,
                onTap: (STDropdownItemData data) {
                  _selectedItems = _selectedItems.sublist(0, _rank);
                  _selectedItems.add(data);
                  _dealEntry(_rank + 1);
                  _overlayState?.setState(() {});
                  if (data.nextDatas != null && data.nextDatas!.isNotEmpty) {
                    _addSubEntry();
                  } else {
                    _hide();
                  }
                  if (widget.selectedCallback == null) return;
                  widget.selectedCallback!(_selectedItems);
                },
              ),
            ),
          ],
        );
      },
    );
    _entrys.add(_rankEntry);
    _overlayState?.insert(_rankEntry);
  }
}
