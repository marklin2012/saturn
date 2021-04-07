import 'package:flutter/material.dart';

class STSlider extends StatefulWidget {
  final Axis axis; // 方向
  final bool showTooltip; // 显示提示
  final Color activeColor; // 选中颜色
  final Color inactiveColor; // 未选中的颜色
  final String startText; // 开始处文本
  final String endText; // 结束处文本
  final TextStyle textStyle; // 开始结束文本风格
  final bool disabled; // 禁用
  final double value; // 单个值
  final RangeValues rangeValues; //区间值

  const STSlider({
    Key key,
    this.activeColor = const Color(0xFF095BF9),
    this.inactiveColor = const Color(0xFFDCE8FF),
    this.startText,
    this.endText,
    this.disabled = false,
    this.axis = Axis.horizontal,
    this.showTooltip,
    this.value = 0,
    this.rangeValues,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
  }) : super(key: key);

  @override
  _STSliderState createState() => _STSliderState();
}

class STSliderConstant {
  static const horizontalWidth = 303.0;
  static const verticalHeight = 200.0;
  static const dotWidth = 18.0;
  static const crossLength = 2.0;
  static const borderRadius = BorderRadius.all(Radius.circular(2.0));
}

class _STSliderState extends State<STSlider> {
  Widget _firstDot;
  Widget _secondDot;
  double _firstValue;
  double _secondValue;

  double get _height {
    if (_isHorizontal) {
      return STSliderConstant.crossLength;
    } else {
      return STSliderConstant.horizontalWidth;
    }
  }

  double get _width {
    if (!_isHorizontal) {
      return STSliderConstant.crossLength;
    } else {
      return STSliderConstant.verticalHeight;
    }
  }

  bool get _disabled => widget.disabled;

  bool get _isHorizontal => widget.axis == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _disabled ? 0.2 : 1.0,
      child: _getOpacityChild(),
    );
  }

  Widget _getOpacityChild() {
    if (_isHorizontal) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.startText != null)
                Text(widget.startText, style: widget.textStyle),
              if (widget.endText != null)
                Text(widget.endText, style: widget.textStyle),
            ],
          ),
          _getStackChild(),
        ],
      );
    } else {
      return _getStackChild();
    }
  }

  Widget _getStackChild() {
    _firstValue = widget.value;
    _firstDot = _getFisrtDot();
    if (widget.rangeValues != null) {
      _firstValue = widget.rangeValues.start;
      _secondValue = widget.rangeValues.end;
      _secondDot = _getSecondDot();
    }
    return Stack(
      children: [
        Container(
          height: _isHorizontal ? STSliderConstant.dotWidth : _height,
          width: _isHorizontal ? _width : STSliderConstant.dotWidth,
          alignment: Alignment.center,
        ),
        Positioned(
          top: _isHorizontal ? STSliderConstant.dotWidth / 2 - 1 : 0.0,
          left: _isHorizontal ? 0 : STSliderConstant.dotWidth / 2 - 1,
          child: _backgroundChild(),
        ),
        Positioned(
          top: _isHorizontal ? STSliderConstant.dotWidth / 2 - 1 : 0.0,
          left: _isHorizontal ? 0 : STSliderConstant.dotWidth / 2 - 1,
          child: _activeChild(),
        ),
        Positioned(
          left: _isHorizontal ? _firstValue : 0,
          top: _isHorizontal ? 0 : _firstValue,
          child: _firstDot,
        ),
        if (_secondDot != null) Positioned(child: _secondDot),
      ],
    );
  }

  Widget _getFisrtDot() {
    return Tooltip(
      message: _calculateValue(_firstValue),
      child: Container(
        alignment: Alignment.center,
        width: STSliderConstant.dotWidth,
        height: STSliderConstant.dotWidth,
        decoration: BoxDecoration(
          color: widget.activeColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _getSecondDot() {
    return Tooltip(
      message: _secondValue.toString(),
      child: Container(
        alignment: Alignment.center,
        width: STSliderConstant.dotWidth,
        height: STSliderConstant.dotWidth,
        decoration: BoxDecoration(
          color: widget.activeColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _backgroundChild() {
    return GestureDetector(
      onTapDown: (details) {
        debugPrint('background-${details.localPosition}');
        updateDotPositon(details.localPosition);
      },
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: widget.inactiveColor,
          borderRadius: STSliderConstant.borderRadius,
        ),
      ),
    );
  }

  Widget _activeChild() {
    return GestureDetector(
      onTapDown: (details) {
        debugPrint('active-${details.localPosition}');
        updateDotPositon(details.localPosition);
      },
      child: Container(
        height: _isHorizontal ? STSliderConstant.crossLength : _firstValue,
        width: _isHorizontal ? _firstValue : STSliderConstant.crossLength,
        color: widget.activeColor,
      ),
    );
  }

  void updateDotPositon(Offset positon) {
    setState(() {
      if (_isHorizontal) {
        if (positon.dx <= STSliderConstant.dotWidth) {
          _firstValue = 0;
        } else if (positon.dx > _width - STSliderConstant.dotWidth) {
          _firstValue = _width - STSliderConstant.dotWidth;
        } else {
          _firstValue = positon.dx - STSliderConstant.dotWidth;
        }
      } else {
        if (positon.dy <= STSliderConstant.dotWidth) {
          _firstValue = 0;
        } else if (positon.dy > _height - STSliderConstant.dotWidth) {
          _firstValue = _height - STSliderConstant.dotWidth;
        } else {
          _firstValue = positon.dy - STSliderConstant.dotWidth;
        }
      }
    });
  }

  String _calculateValue(double value) {
    if (value == 0) {
      return '0';
    }
    return '${((_isHorizontal ? value / _width : value / _height) * 100).round()}%';
  }
}
