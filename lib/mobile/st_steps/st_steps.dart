import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';
import 'package:saturn/mobile/st_steps/common.dart';
import 'package:saturn/mobile/st_steps/st_shapes_dotted_line.dart';
import 'package:saturn/mobile/st_steps/steps_stateful.dart';

const _defaultCircleWidth = 8.0;
const _defaultNumIconWidth = 20.0;
const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _defaultTextStyle = TextStyle(color: Color(0xFF555555), fontSize: 14);
const _defaultSelectTextStyle =
    TextStyle(color: Color(0xFF000000), fontSize: 14);
const _defaultNumTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 14);
const _defaultColor = Color(0xFFDFE2E7);
const _defaultSelectColor = Color(0xFF095BF9);

class STSteps extends StatelessWidget {
  const STSteps({
    Key? key,
    this.type = STStepsType.dot,
    this.lineType = STStepsLineType.solid,
    this.margin = _defaultMargin,
    required this.steps,
    this.current = 0,
    this.detailWidth,
    this.dotted = 4.0,
    this.fixed = 4.0,
  })  : assert(steps.length > 1),
        super(key: key);

  final STStepsType type;
  final STStepsLineType lineType;
  final EdgeInsets margin;
  final List<STStepItem> steps;
  final int current;
  final double? detailWidth; // type为detail,竖排需固定宽度才能满足外部的对齐方式
  final double dotted; // 虚线时 虚线的宽或者高
  final double fixed;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case STStepsType.dot:
        return buildDot();
      case STStepsType.number:
      case STStepsType.icon:
        return buildNumberAndIcon();
      case STStepsType.detail:
        return buildDetail();
    }
  }

  Widget buildDot() {
    return STStatefulSteps(
      margin: margin,
      steps: steps,
      current: current,
      lineType: lineType,
      dotted: dotted,
    );
  }

  Widget buildDetail() {
    return STStatefulSteps(
      type: STStepsType.detail,
      current: current,
      margin: margin,
      steps: steps,
      detailWidth: detailWidth,
      lineType: lineType,
      dotted: dotted,
      fixed: fixed,
    );
  }

  Widget buildNumberAndIcon() {
    final _widgets = <Widget>[];
    for (int i = 0; i < steps.length * 2 - 1; i++) {
      if (i.isEven) {
        final j = i ~/ 2;
        Widget _preWidget;
        if (type == STStepsType.number) {
          final _number = steps[j].number ?? j + 1;
          _preWidget = Text('$_number', style: _defaultNumTextStyle);
        } else {
          _preWidget = _isFinished(j)
              ? steps[j].currentImage ??
                  const Icon(
                    STIcons.commonly_selected_outline,
                    size: _defaultNumIconWidth * 2 / 3,
                    color: Colors.white,
                  )
              : steps[j].image ??
                  const Icon(
                    STIcons.commonly_selected_outline,
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
                steps[j].title!,
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
          child: lineType == STStepsLineType.solid
              ? Container(
                  height: 2,
                  width: 44,
                  color:
                      _isFinished(_index) ? _defaultSelectColor : _defaultColor,
                )
              : STShapesDottedLine(
                  width: 44,
                  dotted: dotted,
                  color:
                      _isFinished(_index) ? _defaultSelectColor : _defaultColor,
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

  bool _isFinished(int index) => index <= current;
}
