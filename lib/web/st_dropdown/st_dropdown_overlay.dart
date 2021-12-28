import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class STDropdownPositon {
  final Offset? offset;
  final Size? size;

  const STDropdownPositon({
    this.offset,
    this.size,
  });

  STDropdownPositon.zero({
    this.offset = Offset.zero,
    this.size = Size.zero,
  });
}

class STDropdownEntry extends StatefulWidget {
  const STDropdownEntry({
    Key? key,
    this.isCascarding = false,
    required this.items,
    this.selectedItem,
    this.onTap,
  }) : super(key: key);

  final bool isCascarding;
  final STDropdownItemData? selectedItem;
  final List<STDropdownItemData> items;
  final Function(STDropdownItemData)? onTap;

  @override
  _STDropdownEntryState createState() => _STDropdownEntryState();
}

class _STDropdownEntryState extends State<STDropdownEntry> {
  static const _cascadingWidth = 256.0;
  static const _normalWidth = 148.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      width: widget.isCascarding ? _cascadingWidth : _normalWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: .5,
            color: Color.fromARGB(25, 0, 0, 0),
          ),
        ],
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    final List<Widget> _children = [];
    for (int i = 0; i < widget.items.length; i++) {
      final _data = widget.items[i];
      final _itemW = STDropdownItem(
        data: _data,
        selected: _data == widget.selectedItem,
        onTap: (STDropdownItemData data) {
          if (widget.onTap == null) return;
          widget.onTap!(data);
        },
      );
      _children.add(_itemW);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _children,
    );
  }
}
