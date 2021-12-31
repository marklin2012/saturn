import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/utils/include.dart';

class STDropdownSimple extends StatefulWidget {
  const STDropdownSimple({
    Key? key,
    required this.child,
    this.initValue,
    this.entryWidth,
    this.disabled = false,
    required this.items,
    this.onChanged,
  })  : assert(items.length > 0),
        super(key: key);

  final Widget child;
  final String? initValue;
  final double? entryWidth;
  final bool disabled;
  final List<String> items;
  final Function(String)? onChanged;

  @override
  _STDropdownSimpleState createState() => _STDropdownSimpleState();
}

class _STDropdownSimpleState extends State<STDropdownSimple> {
  late OverlayState? _overlayState;
  late OverlayEntry? _entry;
  final _simpleTriggerKey = GlobalKey(debugLabel: 'simpleTriggerKey');
  late Offset _triggerOffset;
  late Size _triggerSize;
  late String _currentValue;
  late List<String> _items;
  // 需每次重新定位
  bool _isPostFrame = false;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _currentValue = widget.initValue ?? _items.first;
  }

  void _goPostFrame() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _positonTrigger();
    });
  }

  void _positonTrigger() {
    final _renderObj = _simpleTriggerKey.currentContext?.findRenderObject();
    if (_renderObj != null && _renderObj is RenderBox) {
      final _renderBox = _renderObj;
      _triggerOffset = _renderBox.localToGlobal(Offset.zero);
      _triggerSize = _renderBox.size;
    }
    _isPostFrame = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 200), () {
      _isPostFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _overlayState = Overlay.of(context);
    if (!_isPostFrame) {
      _goPostFrame();
    }
    return GestureDetector(
      key: _simpleTriggerKey,
      onTap: () {
        STDebounce().start(
          key: 'STDropdownSimpleKey',
          func: () {
            if (widget.disabled) return;
            _show();
          },
          time: 100,
        );
      },
      child: widget.child,
    );
  }

  void _show() {
    var _left = _triggerOffset.dx;
    if (widget.entryWidth != null) {
      _left = _left + _triggerSize.width - widget.entryWidth!;
    }
    _entry = OverlayEntry(
      builder: (ctx) {
        return Stack(
          children: [
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
              left: _left,
              top: _triggerOffset.dy + _triggerSize.height + 4.0,
              child: _buildEntryConent(),
            ),
          ],
        );
      },
    );
    _overlayState?.insert(_entry!);
  }

  Widget _buildEntryConent() {
    return Container(
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _items.map((e) {
          return _DropdownSimpleRow(
            title: e,
            width: widget.entryWidth,
            selected: _currentValue == e,
            onChanged: (String selectValue) {
              _hide();
              if (_currentValue == selectValue) return;
              _currentValue = selectValue;
              if (widget.onChanged == null) return;
              widget.onChanged!(_currentValue);
            },
          );
        }).toList(),
      ),
    );
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }
}

// ignore: unused_element
class _DropdownSimpleRow extends StatelessWidget {
  _DropdownSimpleRow({
    Key? key,
    required this.title,
    this.selected = false,
    this.width,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final bool selected;
  final double? width;
  final Function(String)? onChanged;

  final _backgroundColorNoti = ValueNotifier(Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return STMouseRegion(
      onExit: (PointerExitEvent exit) {
        _backgroundColorNoti.value = Colors.transparent;
      },
      onHover: (PointerHoverEvent hover) {
        _backgroundColorNoti.value = STColor.fourRankGrey;
      },
      child: GestureDetector(
        onTap: () {
          STDebounce().start(
            key: 'STDropdownDebounceKey',
            func: () {
              if (onChanged == null) return;
              onChanged!(title);
            },
            time: 100,
          );
        },
        child: ValueListenableBuilder(
          valueListenable: _backgroundColorNoti,
          builder: (ctx, Color bgColor, _) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              width: width,
              alignment: Alignment.center,
              color: selected ? STColor.fourRankBlue : bgColor,
              child: _buildText(title),
            );
          },
        ),
      ),
    );
  }

  Widget _buildText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }
}
