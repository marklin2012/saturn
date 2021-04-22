import 'package:flutter/material.dart';
import 'package:saturn/st_stepper/stepper_item.dart';

class STStepper extends StatefulWidget {
  final int value;
  final bool disabled;
  final Color borderColor;
  final TextStyle textStyle;
  final int minValue; // 低于这个值减号按钮不可用
  final int maxValue; // 高于这个值加号按钮不可用

  const STStepper({
    Key key,
    this.value = 0,
    this.disabled = false,
    this.borderColor = const Color(0xFFDFE2E7),
    this.textStyle,
    this.minValue = 0,
    this.maxValue = 99,
  }) : super(key: key);

  @override
  _STStepperState createState() => _STStepperState();
}

class _STStepperState extends State<STStepper> {
  int _count;
  final double _defaultAllWidth = 88.0;
  final double _textWidth = 40.0;
  final double _height = 24.0;
  final TextStyle _textStyle =
      const TextStyle(color: Color(0xFF000000), fontSize: 14.0);

  @override
  void initState() {
    super.initState();
    _count = widget.value;
    if (_count > widget.maxValue) {
      _count = widget.maxValue;
    } else if (_count < widget.minValue) {
      _count = widget.minValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.disabled ? 0.2 : 1.0,
      child: SizedBox(
        width: _defaultAllWidth,
        height: _height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            STStepperItem(
              type: StepperItemType.reduce,
              disabled: _count == widget.minValue,
              borderColor: widget.borderColor,
              onChanged: (StepperItemType value) {
                _valueChanged(value);
              },
            ),
            Container(
              height: _height,
              width: _textWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: widget.borderColor),
                  bottom: BorderSide(color: widget.borderColor),
                ),
              ),
              child: Text(
                '$_count',
                style: widget.textStyle ?? _textStyle,
              ),
            ),
            STStepperItem(
              type: StepperItemType.plus,
              disabled: _count == widget.maxValue,
              borderColor: widget.borderColor,
              onChanged: (StepperItemType value) {
                _valueChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _valueChanged(StepperItemType type) {
    if (widget.disabled) {
      return;
    } else if (type == StepperItemType.reduce) {
      _count -= 1;
    } else if (type == StepperItemType.plus) {
      _count += 1;
    }
    setState(() {});
  }
}
