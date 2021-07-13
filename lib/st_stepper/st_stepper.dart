import 'package:flutter/material.dart';
import 'package:saturn/st_stepper/stepper_item.dart';

const _defaultBackgroudColor = Color(0xFFFAFCFF);
const _disableTextColor = Color(0xFFDFE2E7);
const _defaultTextFontSize = 14.0;

class STStepper extends StatefulWidget {
  final int value;
  final bool disabled;
  final Color borderColor;
  final double borderRadius;
  final Color textColor;
  final int minValue; // 低于这个值减号按钮不可用
  final int maxValue; // 高于这个值加号按钮不可用

  const STStepper({
    Key key,
    this.value = 0,
    this.disabled = false,
    this.borderColor = const Color(0xFFDFE2E7),
    this.borderRadius = 2.0,
    this.textColor = const Color(0xFF000000),
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

  bool get _disabled => widget.disabled;

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
    return Container(
      width: _defaultAllWidth,
      height: _height,
      color: _defaultBackgroudColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          STStepperItem(
            type: StepperItemType.reduce,
            disabled: _disabled ? _disabled : _count == widget.minValue,
            borderColor: widget.borderColor,
            iconColor: widget.textColor,
            borderRadius: widget.borderRadius,
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
              style: TextStyle(
                  color: _disabled ? _disableTextColor : widget.textColor,
                  fontSize: _defaultTextFontSize),
            ),
          ),
          STStepperItem(
            type: StepperItemType.plus,
            disabled: _disabled ? _disabled : _count == widget.maxValue,
            borderColor: widget.borderColor,
            iconColor: widget.textColor,
            borderRadius: widget.borderRadius,
            onChanged: (StepperItemType value) {
              _valueChanged(value);
            },
          ),
        ],
      ),
    );
  }

  void _valueChanged(StepperItemType type) {
    if (_disabled) {
      return;
    } else if (type == StepperItemType.reduce && _count > widget.minValue) {
      _count -= 1;
    } else if (type == StepperItemType.plus && _count < widget.maxValue) {
      _count += 1;
    }
    setState(() {});
  }
}
