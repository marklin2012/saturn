import 'package:flutter/material.dart';
import 'package:saturn/st_icons/st_icons.dart';

enum STStepsType { normal, number, icon, detail }

class STStepItem {
  const STStepItem({this.title, this.iconData, this.number, this.info});
  final String title;
  final IconData iconData;
  final int number;
  final String info;
}

class STRenderItem {
  const STRenderItem({this.offset, this.size});
  final Offset offset;
  final Size size;
}

const _defaultCircleWidth = 8.0;
const _defaultNumIconWidth = 20.0;
const _defaultNumIconHeight = 22.0;
const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _defaultTextStyle = TextStyle(color: Color(0xFF555555), fontSize: 14);
const _defaultSelectTextStyle =
    TextStyle(color: Color(0xFF000000), fontSize: 14);
const _defaultNumTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14);
const _defaultColor = Color(0xFFDFE2E7);
const _defaultSelectColor = Color(0xFF095BF9);

class STSteps extends StatefulWidget {
  const STSteps({
    Key key,
    this.type = STStepsType.normal,
    this.margin,
    this.items,
    this.finishedIndex,
    this.deatilHeight,
    this.detailWidth,
  }) : super(key: key);

  final STStepsType type;
  final EdgeInsets margin;
  final List<STStepItem> items;
  final int finishedIndex;
  final double deatilHeight; //type为detail,竖排需固定高度才能排版
  final double detailWidth; // type为detail,竖排需固定宽度才能满足外部的对齐方式

  @override
  _STStepsState createState() => _STStepsState();
}

class _STStepsState extends State<STSteps> {
  STStepsType _type;
  List<STStepItem> _items;
  EdgeInsets _margin;
  List<GlobalKey> _golbalKeys;
  bool _isFindRender = false;
  List<STRenderItem> _renders;
  int _finishedIndex;
  double _detailHeight;
  double _detailWidth;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    _items = List.from(widget.items);
    _margin = widget.margin ?? _defaultMargin;
    _finishedIndex = widget.finishedIndex ?? 1;
    _golbalKeys = <GlobalKey>[];
    for (var i = 0; i < _items.length; i++) {
      final _tempKey = GlobalKey(debugLabel: '${_items[i].title}+$i');
      _golbalKeys.add(_tempKey);
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _findRenderObject();
    });
  }

  void _findRenderObject() {
    _isFindRender = true;
    _renders = <STRenderItem>[];
    for (var i = 0; i < _golbalKeys.length; i++) {
      final RenderBox tempRender =
          _golbalKeys[i].currentContext.findRenderObject();
      final _offset = tempRender.localToGlobal(Offset.zero);
      final _render = STRenderItem(offset: _offset, size: tempRender.size);
      _renders.add(_render);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case STStepsType.normal:
        return buildNormal();
      case STStepsType.number:
      case STStepsType.icon:
        return buildNumberAndIcon();
      case STStepsType.detail:
        return buildDetail();
    }
    return Container();
  }

  Widget buildDetail() {
    _detailHeight = widget.deatilHeight ??
        (44.0 * _items.length + 30 * (_items.length - 1));
    _detailWidth = widget.detailWidth ?? 100.0;
    final _stackWidgets = <Widget>[];
    final _bgWidgtets = List.generate(_items.length, (index) {
      Widget _preWidget;
      if (_isFinished(index)) {
        _preWidget = const Icon(
          STIcons.commonly_selected,
          size: _defaultNumIconWidth * 2 / 3,
          color: Colors.white,
        );
      } else {
        final _number = _items[index].number ?? index + 1;
        _preWidget = Text('$_number', style: _defaultNumTextStyle);
      }
      return SizedBox(
        width: _detailWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              key: _golbalKeys[index],
              height: _defaultNumIconWidth,
              width: _defaultNumIconWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_defaultNumIconWidth / 2),
                color: _isFinished(index) ? _defaultSelectColor : _defaultColor,
              ),
              alignment: Alignment.center,
              child: _preWidget,
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                SizedBox(
                  height: _defaultNumIconHeight,
                  child: Text(
                    _items[index].title,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: _isFinished(index)
                            ? const Color(0xFF000000)
                            : const Color(0xFF555555)),
                  ),
                ),
                SizedBox(
                  height: _defaultNumIconWidth,
                  child: Text(
                    _items[index].info,
                    style: const TextStyle(
                        fontSize: 12.0, color: Color(0xFF888888)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
    _stackWidgets.add(SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _bgWidgtets,
      ),
    ));
    if (_isFindRender) {
      for (var i = 0; i < _items.length - 1; i++) {
        final _top = _renders[i].offset.dy -
            _renders[0].offset.dy +
            _defaultNumIconWidth +
            _defaultCircleWidth / 2;
        final _height = _renders[i + 1].offset.dy -
            _renders[i].offset.dy -
            _defaultNumIconWidth -
            _defaultCircleWidth;
        final _temp = Positioned(
          left: (_defaultNumIconWidth - 2) / 2,
          top: _top,
          child: Container(
            height: _height,
            width: 2,
            color: _isFinished(i + 1) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _stackWidgets.add(_temp);
      }
    }
    return SizedBox(
      height: _detailHeight,
      child: Stack(
        children: _stackWidgets,
      ),
    );
  }

  Widget buildNumberAndIcon() {
    final _stackWidgets = <Widget>[];
    final _bgWidgtets = List.generate(_items.length, (index) {
      Widget _preWidget;
      if (_type == STStepsType.number) {
        final _number = _items[index].number ?? index + 1;
        _preWidget = Text('$_number', style: _defaultNumTextStyle);
      } else {
        _preWidget = Icon(
          _items[index].iconData ?? STIcons.commonly_exception,
          size: _defaultNumIconWidth * 2 / 3,
          color: Colors.white,
        );
      }
      return Row(
        key: _golbalKeys[index],
        children: [
          Container(
            height: _defaultNumIconWidth,
            width: _defaultNumIconWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_defaultNumIconWidth / 2),
              color: _isFinished(index) ? _defaultSelectColor : _defaultColor,
            ),
            alignment: Alignment.center,
            child: _preWidget,
          ),
          const SizedBox(width: 4),
          Text(
            _items[index].title,
            style: _isFinished(index)
                ? _defaultSelectTextStyle
                : _defaultTextStyle,
          ),
        ],
      );
    }).toList();
    _stackWidgets.add(SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _bgWidgtets,
      ),
    ));
    if (_isFindRender) {
      for (var i = 1; i < _items.length; i++) {
        final _width = _renders[i].offset.dx -
            _renders[i - 1].offset.dx -
            _renders[i - 1].size.width -
            _defaultNumIconWidth / 2;
        final _left = _renders[i - 1].offset.dx +
            _renders[i - 1].size.width -
            _defaultNumIconWidth / 2;
        final _temp = Positioned(
          left: _left,
          bottom: (_defaultNumIconHeight - 2) / 2,
          child: Container(
            height: 2,
            width: _width,
            color: _isFinished(i) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _stackWidgets.add(_temp);
      }
    }
    return Container(
      margin: _margin,
      height: _defaultNumIconHeight,
      child: Stack(
        children: _stackWidgets,
      ),
    );
  }

  Widget buildNormal() {
    final _stackWidgets = <Widget>[];
    final _titlesWidgets = List.generate(
      _items.length,
      (index) {
        var _crossAxisAlignment = CrossAxisAlignment.center;
        if (index == 0) {
          _crossAxisAlignment = CrossAxisAlignment.start;
        } else if (index == _items.length - 1) {
          _crossAxisAlignment = CrossAxisAlignment.end;
        }
        return Column(
          crossAxisAlignment: _crossAxisAlignment,
          children: [
            Text(
              _items[index].title,
              style: _isFinished(index)
                  ? _defaultSelectTextStyle
                  : _defaultTextStyle,
            ),
            const SizedBox(height: _defaultCircleWidth / 2),
            Container(
              key: _golbalKeys[index],
              height: _defaultCircleWidth,
              width: _defaultCircleWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_defaultCircleWidth / 2),
                color: _isFinished(index) ? _defaultSelectColor : _defaultColor,
              ),
            ),
          ],
        );
      },
    ).toList();
    _stackWidgets.add(SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _titlesWidgets,
      ),
    ));
    if (_isFindRender) {
      for (var i = 1; i < _items.length; i++) {
        final _width = _renders[i].offset.dx -
            _renders[i - 1].offset.dx -
            _defaultCircleWidth * 2;
        final _left = _renders[i - 1].offset.dx - _defaultCircleWidth / 2;
        final _temp = Positioned(
          left: _left,
          bottom: (_defaultCircleWidth - 2) / 2,
          child: Container(
            height: 2,
            width: _width,
            color: _isFinished(i) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _stackWidgets.add(_temp);
      }
    }
    return Container(
      margin: _margin,
      child: Stack(
        children: _stackWidgets,
      ),
    );
  }

  bool _isFinished(int index) => index < _finishedIndex;
}