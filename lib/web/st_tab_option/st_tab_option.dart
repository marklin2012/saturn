import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class STCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class STTabOption extends StatefulWidget {
  const STTabOption({
    Key? key,
    this.backgroundColor = STColor.fourRankGrey,
    this.pageBackgroundColor,
    this.isSlided = false,
    this.dirction = STTabOptionDirction.top,
    this.type = STTabOptionType.line,
    this.size = STTabOptionSize.normal,
    this.items,
    this.pages,
    this.initIndex = 0,
    this.padding = const EdgeInsets.all(40.0),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.selectedChanged,
    this.prefix,
    this.suffix,
    this.height = 164,
    this.onDeletedChanged,
    this.onAddItemTap,
    this.itemGutter = 8,
  })  : assert(items != null && items.length != 0),
        assert(pages != null && pages.length != 0),
        assert(pages?.length == items?.length),
        super(key: key);

  final bool isSlided;
  final STTabOptionType type;
  final STTabOptionDirction dirction;
  final STTabOptionSize size;
  final List<STTabOptionData>? items;
  final List<Widget>? pages;
  final int initIndex; // 默认选中
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged<int>? selectedChanged; // 选中的回调
  final ValueChanged<int>? onDeletedChanged; // 删除的回调
  final VoidCallback? onAddItemTap; // 添加的回调
  final Widget? prefix; // 头部
  final Widget? suffix; // 尾部
  final double itemGutter; // tabs之间的间隙
  final double? height;
  final Color? backgroundColor;
  final Color? pageBackgroundColor;

  @override
  _STTabOptionState createState() => _STTabOptionState();
}

class _STTabOptionState extends State<STTabOption> {
  late Axis _axis;
  List<STTabOptionData> _items = [];
  List<Widget> _tabs = [];
  List<Widget> _pages = [];
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _items = widget.items ?? [];
    _selectedIndex = widget.initIndex;
    _pages = widget.pages!;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dirction == STTabOptionDirction.top ||
        widget.dirction == STTabOptionDirction.bottom) {
      _axis = Axis.horizontal;
    } else {
      _axis = Axis.vertical;
    }
    _createWidgetFormData();
    return Container(
      color: widget.backgroundColor,
      padding: widget.padding,
      height: widget.height,
      child: _axis == Axis.horizontal ? _getHorDirction() : _getVerDirction(),
    );
  }

  Widget _getHorDirction() {
    return Column(
      children: [
        if (widget.dirction == STTabOptionDirction.bottom)
          Expanded(child: _getPageView()),
        Stack(
          children: [
            if (widget.type != STTabOptionType.boxCard)
              Positioned(
                left: 0,
                right: 0,
                top: widget.dirction == STTabOptionDirction.top ? null : 0,
                bottom:
                    widget.dirction == STTabOptionDirction.bottom ? null : 0,
                height: (_axis == Axis.horizontal) ? 1 : null,
                width: (_axis == Axis.vertical) ? 1 : null,
                child: Container(
                  color: STColor.thrRankGrey,
                ),
              ),
            Row(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: widget.prefix,
                  ),
                Expanded(child: _getHorContent()),
                if (widget.type == STTabOptionType.editCard) _createAddBtn(),
                if (widget.isSlided) _createMoreBtn(),
                if (widget.suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: widget.suffix,
                  ),
              ],
            ),
          ],
        ),
        if (widget.dirction == STTabOptionDirction.top)
          Expanded(child: _getPageView()),
      ],
    );
  }

  Widget _getVerDirction() {
    return Row(
      children: [
        if (widget.dirction == STTabOptionDirction.right)
          Expanded(child: _getPageView()),
        Stack(
          children: [
            if (widget.type != STTabOptionType.boxCard)
              Positioned(
                left: widget.dirction == STTabOptionDirction.left ? null : 0,
                right: widget.dirction == STTabOptionDirction.right ? null : 0,
                top: 0,
                bottom: 0,
                height: (_axis == Axis.horizontal) ? 1 : null,
                width: (_axis == Axis.vertical) ? 1 : null,
                child: Container(
                  color: STColor.thrRankGrey,
                ),
              ),
            Column(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: widget.prefix,
                  ),
                _getVerContent(),
                if (widget.type == STTabOptionType.editCard) _createAddBtn(),
                if (widget.isSlided) _createMoreBtn(),
                if (widget.suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: widget.suffix,
                  ),
              ],
            ),
          ],
        ),
        if (widget.dirction == STTabOptionDirction.left)
          Expanded(child: _getPageView()),
      ],
    );
  }

  Widget _getVerContent() {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: _tabs,
    );
  }

  Widget _getHorContent() {
    final List<Widget> _childs = _tabs.map((e) {
      return Padding(
        padding: EdgeInsets.only(right: widget.itemGutter),
        child: e,
      );
    }).toList();
    if (widget.type == STTabOptionType.boxCard ||
        widget.mainAxisAlignment != MainAxisAlignment.start) {
      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: _childs,
      );
    }
    return SizedBox(
      height: _getSlidedHeight(),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        scrollBehavior: STCustomScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: _childs,
            ),
          ),
        ],
      ),
    );
  }

  double _getSlidedHeight() {
    if (widget.type == STTabOptionType.line) {
      return widget.size == STTabOptionSize.small
          ? 40
          : (widget.size == STTabOptionSize.large ? 56 : 48);
    } else {
      return widget.size == STTabOptionSize.small
          ? 34
          : (widget.size == STTabOptionSize.large ? 40 : 38);
    }
  }

  Widget _createMoreBtn() {
    return GestureDetector(
      onTap: () {
        STDebounce().start(
          key: 'STTabOptionMoreKey',
          func: () {},
          time: 100,
        );
      },
      child: Container(
        width: 52,
        height: _getSlidedHeight() - 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
        ),
        child: const Icon(
          STIcons.commonly_more_outline,
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _createAddBtn() {
    return GestureDetector(
      onTap: () {
        STDebounce().start(
          key: 'STTabOptionAddKey',
          func: () {
            _itemAddTap();
          },
          time: 100,
        );
      },
      child: Container(
        width: 48,
        height: _getSlidedHeight() - 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
        ),
        child: const Icon(
          STIcons.status_pluscircle_outline,
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _getPageView() {
    return PageView.builder(
      scrollDirection: _axis,
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return Container(
          color: widget.pageBackgroundColor,
          alignment: _getAlignment(),
          child: _pages[index],
        );
      },
    );
  }

  Alignment _getAlignment() {
    switch (widget.dirction) {
      case STTabOptionDirction.right:
        return Alignment.topRight;
      case STTabOptionDirction.bottom:
        return Alignment.bottomLeft;
      default:
        return Alignment.topLeft;
    }
  }

  void _createWidgetFormData() {
    _tabs = [];
    for (int i = 0; i < _items.length; i++) {
      final _item = _items[i];
      final _seleted = _selectedIndex == i;
      final _child = STTabOptionItem(
        icon: _item.icon,
        item: _item.title!,
        disabled: _item.disabled,
        badge: _item.badge,
        maxBadge: _item.maxBadge ?? 99,
        isDeleted: _item.isDeleted,
        selected: _seleted,
        type: widget.type,
        dirction: widget.dirction,
        size: widget.size,
        onTap: () {
          _itemTap(i);
        },
        onDeletedTap: () {
          _itemDeleteTap(i);
        },
      );
      _tabs.add(_child);
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  void _itemTap(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    _createWidgetFormData();
    _pageController.jumpToPage(index);
    setState(() {});
    if (widget.selectedChanged == null) return;
    widget.selectedChanged!(_selectedIndex);
  }

  void _itemDeleteTap(int index) {
    if (widget.onDeletedChanged == null) return;
    if (index < _selectedIndex) {
      _selectedIndex -= 1;
    } else if (index == _selectedIndex) {
      _selectedIndex = index > 0 ? index - 1 : 0;
    }
    widget.onDeletedChanged!(index);
  }

  void _itemAddTap() {
    if (widget.onAddItemTap == null) return;
    _selectedIndex = _tabs.length;
    widget.onAddItemTap!();
  }
}
