import 'package:flutter/material.dart';

import 'package:saturn/st_icons/st_icons.dart';
import 'package:saturn/st_steps/common.dart';

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

class STStatefulSteps extends StatefulWidget {
  const STStatefulSteps({
    Key key,
    this.margin,
    this.steps,
    this.current,
    this.detailWidth,
    this.type = STStepsType.dot,
  }) : super(key: key);

  final STStepsType type;
  final EdgeInsets margin;
  final List<STStepItem> steps;
  final int current;
  final double detailWidth; // type为detail,竖排需固定宽度才能满足外部的对齐方式

  @override
  _STStatefulStepsState createState() => _STStatefulStepsState();
}

class _STStatefulStepsState extends State<STStatefulSteps> {
  STStepsType _type;
  List<STStepItem> _steps;
  EdgeInsets _margin;
  List<GlobalKey> _golbalKeys;
  bool _isFindRender = false;
  List<STRenderItem> _renders;
  int _current;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    _steps = List.from(widget.steps);
    _margin = widget.margin ?? _defaultMargin;
    _current = widget.current ?? 1;
    _golbalKeys = <GlobalKey>[];
    for (var i = 0; i < _steps.length; i++) {
      final _tempKey = GlobalKey(debugLabel: '${_steps[i].title}+$i');
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
    if (_type == STStepsType.dot) {
      return buildDot();
    } else {
      return buildDetail();
    }
  }

  Widget buildDetail() {
    final _detailHeight = 44.0 * _steps.length + 30 * (_steps.length - 1);
    final _detailWidth = widget.detailWidth ?? 100.0;
    final _stackWidgets = <Widget>[];
    final _bgWidgtets = List.generate(_steps.length, (index) {
      Widget _preWidget;
      if (_isFinished(index)) {
        _preWidget = const Icon(
          STIcons.commonly_selected,
          size: _defaultNumIconWidth * 2 / 3,
          color: Colors.white,
        );
      } else {
        final _number = _steps[index].number ?? index + 1;
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
                    _steps[index].title,
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
                    _steps[index].info,
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
      for (var i = 0; i < _steps.length - 1; i++) {
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

  Widget buildDot() {
    final _stackWidgets = <Widget>[];
    final _titlesWidgets = List.generate(
      _steps.length,
      (index) {
        var _crossAxisAlignment = CrossAxisAlignment.center;
        if (index == 0) {
          _crossAxisAlignment = CrossAxisAlignment.start;
        } else if (index == _steps.length - 1) {
          _crossAxisAlignment = CrossAxisAlignment.end;
        }
        return Column(
          crossAxisAlignment: _crossAxisAlignment,
          children: [
            Text(
              _steps[index].title,
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
      for (var i = 1; i < _steps.length; i++) {
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

  bool _isFinished(int index) => index < _current;
}
