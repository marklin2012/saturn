import 'package:flutter/material.dart';

import 'package:saturn/st_steps/common.dart';
import 'package:saturn/st_icons/st_icons.dart';

const _defaultCircleWidth = 8.0;
const _defaultDotHeight = 32.0;
const _defaultNumIconWidth = 20.0;
const _defaultNumIconHeight = 22.0;
const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _defaultTextStyle = TextStyle(color: Color(0xFF555555), fontSize: 14);
const _defaultSelectTextStyle =
    TextStyle(color: Color(0xFF000000), fontSize: 14);
const _defaultNumTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14);
const _defaultColor = Color(0xFFDFE2E7);
const _defaultSelectColor = Color(0xFF095BF9);

class Steps extends StatelessWidget {
  const Steps(
      {Key key,
      this.type = STStepsType.dot,
      this.margin = _defaultMargin,
      this.steps,
      this.current = 1,
      this.deatilHeight,
      this.detailWidth})
      : assert(steps.length > 1),
        super(key: key);

  final STStepsType type;
  final EdgeInsets margin;
  final List<STStepItem> steps;
  final int current;
  final double deatilHeight; //type为detail,竖排需固定高度才能排版
  final double detailWidth; // type为detail,竖排需固定宽度才能满足外部的对齐方式

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case STStepsType.dot:
        return buildDot(context);
      case STStepsType.number:
      case STStepsType.icon:
        return buildNumberAndIcon();
      case STStepsType.detail:
        return buildDetail();
    }
    return Container();
  }

  Widget buildDetail() {
    final _detailHeight =
        deatilHeight ?? (44.0 * steps.length + 30 * (steps.length - 1));
    final _detailWidth = detailWidth ?? 100.0;
    final _leftWidgets = <Widget>[];
    for (var i = 0; i < steps.length * 2 - 1; i++) {
      if (i % 2 == 0) {
        final j = i ~/ 2;
        Widget _preWidget;
        if (_isFinished(j)) {
          _preWidget = const Icon(
            STIcons.commonly_selected,
            size: _defaultNumIconWidth * 2 / 3,
            color: Colors.white,
          );
        } else {
          final _number = steps[j].number ?? j + 1;
          _preWidget = Text('$_number', style: _defaultNumTextStyle);
        }
        var _padding =
            const EdgeInsets.symmetric(vertical: _defaultCircleWidth / 2);
        if (j == 0) {
          _padding = const EdgeInsets.only(bottom: _defaultCircleWidth / 2);
        } else if (j == steps.length - 1) {
          _padding = const EdgeInsets.only(top: _defaultCircleWidth / 2);
        }
        final _widget = Container(
          height: _defaultNumIconWidth,
          width: _defaultNumIconWidth,
          padding: _padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_defaultNumIconWidth / 2),
            color: _isFinished(j) ? _defaultSelectColor : _defaultColor,
          ),
          alignment: Alignment.center,
          child: _preWidget,
        );
        _leftWidgets.add(_widget);
      } else {
        final j = i ~/ 2 + 1;
        final _flex = Flexible(
          child: Container(
            width: 2,
            color: _isFinished(j) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _leftWidgets.add(_flex);
      }
    }
    final _rightWidgets = List.generate(steps.length, (index) {
      return SizedBox(
        height: _defaultNumIconHeight + _defaultNumIconWidth,
        child: Column(
          children: [
            SizedBox(
              height: _defaultNumIconHeight,
              child: Text(
                steps[index].title,
                style: TextStyle(
                    fontSize: 14.0,
                    color: _isFinished(index)
                        ? const Color(0xFF000000)
                        : const Color(0xFF555555)),
              ),
            ),
            const SizedBox(width: _defaultCircleWidth / 2),
            SizedBox(
              height: _defaultNumIconWidth,
              child: Text(
                steps[index].info,
                style:
                    const TextStyle(fontSize: 12.0, color: Color(0xFF888888)),
              ),
            ),
          ],
        ),
      );
    }).toList();

    return SizedBox(
      height: _detailHeight,
      width: _detailWidth,
      child: Row(
        children: [
          Column(
            children: _leftWidgets,
          ),
          const SizedBox(width: _defaultCircleWidth / 2),
          Column(
            children: _rightWidgets,
          ),
        ],
      ),
    );
  }

  Widget buildNumberAndIcon() {
    final _widgets = <Widget>[];
    for (var i = 0; i < steps.length * 2 - 1; i++) {
      if (i % 2 == 0) {
        final j = i ~/ 2;
        Widget _preWidget;
        if (type == STStepsType.number) {
          final _number = steps[j].number ?? j + 1;
          _preWidget = Text('$_number', style: _defaultNumTextStyle);
        } else {
          _preWidget = Icon(
            steps[j].iconData ?? STIcons.commonly_selected,
            size: _defaultNumIconWidth * 2 / 3,
            color: Colors.white,
          );
        }
        var _padding =
            const EdgeInsets.symmetric(horizontal: _defaultCircleWidth / 2);
        if (j == 0) {
          _padding = const EdgeInsets.only(right: _defaultCircleWidth / 2);
        } else if (j == steps.length - 1) {
          _padding = const EdgeInsets.only(left: _defaultCircleWidth / 2);
        }
        final _numberIcon = Container(
          padding: _padding,
          child: Row(
            children: [
              Container(
                height: _defaultNumIconWidth,
                width: _defaultNumIconWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_defaultNumIconWidth / 2),
                  color: _isFinished(j) ? _defaultSelectColor : _defaultColor,
                ),
                alignment: Alignment.center,
                child: _preWidget,
              ),
              const SizedBox(width: 4),
              Text(
                steps[j].title,
                style: _isFinished(j)
                    ? _defaultSelectTextStyle
                    : _defaultTextStyle,
              ),
            ],
          ),
        );
        _widgets.add(_numberIcon);
      } else {
        final _index = i ~/ 2 + 1;
        final _flex = Flexible(
          child: Container(
            height: 2,
            color: _isFinished(_index) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _widgets.add(_flex);
      }
    }

    return Container(
      margin: margin,
      child: Row(
        children: _widgets,
      ),
    );
  }

  Widget buildDot(BuildContext context) {
    final _titlesWidgets = List.generate(
      steps.length,
      (index) {
        return Text(
          steps[index].title,
          style:
              _isFinished(index) ? _defaultSelectTextStyle : _defaultTextStyle,
        );
      },
    ).toList();
    final _dotWidgets = <Widget>[];
    for (var i = 0; i < steps.length * 2 - 1; i++) {
      if (i % 2 == 0) {
        final _index = i ~/ 2;
        var _padding =
            const EdgeInsets.symmetric(horizontal: _defaultCircleWidth / 2);
        if (_index == 0) {
          _padding = const EdgeInsets.only(right: _defaultCircleWidth / 2);
        } else if (_index == steps.length - 1) {
          _padding = const EdgeInsets.only(left: _defaultCircleWidth / 2);
        }
        final _dot = Container(
          padding: _padding,
          child: Container(
            height: _defaultCircleWidth,
            width: _defaultCircleWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_defaultCircleWidth / 2),
              color: _isFinished(_index) ? _defaultSelectColor : _defaultColor,
            ),
          ),
        );
        _dotWidgets.add(_dot);
      } else {
        final _index = i ~/ 2 + 1;
        final _flex = Flexible(
          child: Container(
            height: 2,
            color: _isFinished(_index) ? _defaultSelectColor : _defaultColor,
          ),
        );
        _dotWidgets.add(_flex);
      }
    }

    return Container(
      margin: margin,
      height: _defaultDotHeight,
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titlesWidgets),
          const SizedBox(height: _defaultCircleWidth / 2),
          Row(children: _dotWidgets),
        ],
      ),
    );
  }

  bool _isFinished(int index) => index < current;
}
