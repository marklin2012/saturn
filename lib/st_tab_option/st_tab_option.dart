import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class STTabOptionData {
  final IconData? icon;
  final String? title;
  final int? badge;
  final int? maxBadge;
  final bool disabled;

  const STTabOptionData({
    this.icon,
    this.title,
    this.badge,
    this.maxBadge,
    this.disabled = false,
  });
}

class STTabOption extends StatefulWidget {
  const STTabOption({
    Key? key,
    this.isCard = false,
    this.dirction = STTabOptionDirction.top,
    this.optionSize = STTabOptionSize.middle,
    this.selectedColor = STColor.firRankBlue,
    this.unselectedColor = STColor.firRankFont,
    this.disabledColor = STColor.secRankGrey,
    this.items,
    this.initIndex = 0,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.selectedChanged,
    this.prefix,
    this.suffix,
  })  : assert(items != null && items.length != 0),
        super(key: key);

  final bool isCard;
  final STTabOptionDirction dirction;
  final STTabOptionSize optionSize;
  final Color selectedColor;
  final Color unselectedColor;
  final Color disabledColor;
  final List<STTabOptionData>? items;
  final int initIndex;
  final EdgeInsets? padding;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged<int>? selectedChanged;
  final Widget? prefix;
  final Widget? suffix;

  @override
  _STTabOptionState createState() => _STTabOptionState();
}

class _STTabOptionState extends State<STTabOption> {
  List<Widget> _items = [];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initIndex;
    _initWidgets();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    debugPrint('$_width');
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            left: widget.dirction == STTabOptionDirction.left ? null : 0,
            right: widget.dirction == STTabOptionDirction.right ? null : 0,
            top: widget.dirction == STTabOptionDirction.top ? null : 0,
            bottom: widget.dirction == STTabOptionDirction.bottom ? null : 0,
            height: (widget.dirction == STTabOptionDirction.top ||
                    widget.dirction == STTabOptionDirction.bottom)
                ? 1
                : null,
            width: (widget.dirction == STTabOptionDirction.left ||
                    widget.dirction == STTabOptionDirction.right)
                ? 1
                : null,
            child: Container(
              color: STColor.thrRankGrey,
            ),
          ),
          _getContent(),
        ],
      ),
    );
  }

  Widget _getContent() {
    if (widget.dirction == STTabOptionDirction.top ||
        widget.dirction == STTabOptionDirction.bottom) {
      return Row(
        children: [
          if (widget.prefix != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: widget.prefix,
            ),
          Expanded(child: _getHorContent()),
          if (widget.suffix != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: widget.suffix,
            ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefix != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: widget.prefix,
            ),
          _getVerContent(),
          if (widget.suffix != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: widget.suffix,
            ),
        ],
      );
    }
  }

  Widget _getVerContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _items,
    );
  }

  Widget _getHorContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: _items.map((e) {
            if (e == _items.last) {
              return e;
            }
            return Padding(
              padding: EdgeInsets.only(right: widget.isCard ? 4 : 32),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }

  void _itemTap(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    _initWidgets();
    setState(() {});
    if (widget.selectedChanged == null) return;
    widget.selectedChanged!(_selectedIndex);
  }

  void _initWidgets() {
    _items = [];
    for (int i = 0; i < widget.items!.length; i++) {
      final _data = widget.items![i];
      final _seleted = _selectedIndex == i;
      final _item = STTabOptionItem(
        icon: _data.icon,
        item: _data.title!,
        disabled: _data.disabled,
        badge: _data.badge,
        maxBadge: _data.maxBadge ?? 99,
        selected: _seleted,
        isCard: widget.isCard,
        selectedColor: widget.selectedColor,
        unselectedColor: widget.unselectedColor,
        disabledColor: widget.disabledColor,
        dirction: widget.dirction,
        optionSize: widget.optionSize,
        onTap: () {
          _itemTap(i);
        },
      );
      _items.add(_item);
    }
  }
}
