import 'package:flutter/material.dart';

enum STSliderDotType {
  start,
  end,
}

class STSlider extends StatefulWidget {
  final Axis axis; // 方向
  final bool showTooltip; // 显示提示
  final Color activeColor; // 选中颜色
  final Color inactiveColor; // 未选中的颜色
  final int minValue; // 最小值
  final int maxValue; // 最大值
  final TextStyle textStyle; // 开始结束文本风格
  final bool disabled; // 禁用
  final double value; // 单个值(0,1)
  final RangeValues rangeValues; //区间值(0,1)
  final ValueChanged<double> onChanged;
  final ValueChanged<RangeValues> onChangedRange;

  const STSlider({
    Key key,
    this.activeColor = const Color(0xFF095BF9),
    this.inactiveColor = const Color(0xFFDCE8FF),
    this.minValue,
    this.maxValue,
    this.disabled = false,
    this.axis = Axis.horizontal,
    this.showTooltip,
    this.value = 0,
    this.rangeValues,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
    this.onChanged,
    this.onChangedRange,
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
  final GlobalKey _firstKey = GlobalKey(debugLabel: 'firstDot'); // 控件的key
  Offset _firstOffset; // 第一个原点位置

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _findRenderObject();
    });
  }

  void _findRenderObject() {
    final RenderBox renderBox = _firstKey.currentContext.findRenderObject();
    // offset.dx , offset.dy 就是控件的左上角坐标
    final offset = renderBox.localToGlobal(Offset.zero);
    final dx = offset.dx + (renderBox.size.width / 2);
    final dy = offset.dy + (renderBox.size.height / 2);
    _firstOffset = Offset(dx, dy);
    if (widget.rangeValues != null && widget.rangeValues.start != 0) {
      if (_isHorizontal) {
        _firstOffset = Offset(
            dx -
                widget.rangeValues.start * _width -
                STSliderConstant.dotWidth / 2,
            dy);
      } else {
        _firstOffset = Offset(
            dx,
            dy -
                widget.rangeValues.start * _height -
                STSliderConstant.dotWidth / 2);
      }
    }
    setState(() {});
  }

  void initValue() {
    _firstValue = widget.value;
    if (widget.rangeValues != null) {
      _firstValue = widget.rangeValues.start;
      _secondValue = widget.rangeValues.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    initValue();
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
              if (widget.minValue != null)
                Text('${widget.minValue}', style: widget.textStyle),
              if (widget.maxValue != null)
                Text('${widget.maxValue}', style: widget.textStyle),
            ],
          ),
          _getStackChild(),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getStackChild(),
          Column(
            children: [
              if (widget.minValue != null)
                Text('${widget.minValue}', style: widget.textStyle),
              if (widget.maxValue != null)
                SizedBox(height: _height - STSliderConstant.dotWidth * 2),
              if (widget.maxValue != null)
                Text('${widget.maxValue}', style: widget.textStyle),
            ],
          )
        ],
      );
    }
  }

  Widget _getStackChild() {
    _firstDot = _getDot(_firstValue, STSliderDotType.start);
    if (widget.rangeValues != null) {
      _secondDot = _getDot(_secondValue, STSliderDotType.end);
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
          top: _getActiveTop(),
          left: _getActiveLeft(),
          child: _activeChild(),
        ),
        Positioned(
          left: _getFirstDotPostionLeft(_firstValue),
          top: _getFirstDotPositonTop(_firstValue),
          child: _firstDot,
        ),
        if (_secondDot != null)
          Positioned(
              left: _getFirstDotPostionLeft(_secondValue),
              top: _getFirstDotPositonTop(_secondValue),
              child: _secondDot),
      ],
    );
  }

  double _getActiveLeft() {
    if (widget.rangeValues == null) {
      return _isHorizontal ? 0 : STSliderConstant.dotWidth / 2 - 1;
    } else {
      return _getFirstDotPostionLeft(_firstValue) +
          STSliderConstant.dotWidth / 2;
    }
  }

  double _getActiveTop() {
    if (widget.rangeValues == null) {
      return _isHorizontal ? STSliderConstant.dotWidth / 2 - 1 : 0;
    } else {
      return _getFirstDotPositonTop(_firstValue) +
          STSliderConstant.dotWidth / 2;
    }
  }

  double _getFirstDotPostionLeft(double value) {
    if (value == 0 || !_isHorizontal) {
      return 0;
    } else if (value == 1) {
      return _width - STSliderConstant.dotWidth;
    } else {
      return value * _width + STSliderConstant.dotWidth / 2;
    }
  }

  double _getFirstDotPositonTop(double value) {
    if (value == 0 || _isHorizontal) {
      return 0;
    } else if (value == 1) {
      return _height - STSliderConstant.dotWidth;
    } else {
      return value * _height + STSliderConstant.dotWidth / 2;
    }
  }

  Widget _getDot(double value, STSliderDotType dotType) {
    if (widget.disabled) {
      return Container(
        key: dotType == STSliderDotType.start ? _firstKey : null,
        alignment: Alignment.center,
        width: STSliderConstant.dotWidth,
        height: STSliderConstant.dotWidth,
        decoration: BoxDecoration(
          color: widget.activeColor,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Draggable(
        axis: widget.axis,
        feedback: Container(
          alignment: Alignment.center,
          width: STSliderConstant.dotWidth,
          height: STSliderConstant.dotWidth,
          decoration: BoxDecoration(
            color: widget.activeColor,
            shape: BoxShape.circle,
          ),
        ),
        onDragEnd: (details) {
          // debugPrint('${details.offset}-$_firstOffset-$isFirst');
          updateDragAction(details.offset, dotType);
        },
        child: Tooltip(
          message: widget.maxValue == null
              ? '${(value * 100).round()}%'
              : _calculateValue(value),
          verticalOffset: -(STSliderConstant.dotWidth + 5) * 2,
          child: Container(
            key: dotType == STSliderDotType.start ? _firstKey : null,
            alignment: Alignment.center,
            width: STSliderConstant.dotWidth,
            height: STSliderConstant.dotWidth,
            decoration: BoxDecoration(
              color: widget.activeColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
  }

  Widget _backgroundChild() {
    return GestureDetector(
      onTapDown: (details) {
        // debugPrint('background-${details.localPosition}');
        updateTapAction(details.localPosition);
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
        // debugPrint('active-${details.localPosition}');
        updateTapAction(details.localPosition);
      },
      child: Container(
        height: _getActiveChildHeight(),
        width: _getActiveChildWidth(),
        color: widget.activeColor,
      ),
    );
  }

  double _getActiveChildHeight() {
    if (widget.rangeValues == null) {
      if (_isHorizontal) {
        return STSliderConstant.crossLength;
      } else if (_firstValue == 0) {
        return 0;
      } else if (_firstValue == 1) {
        return _height;
      } else {
        return _firstValue * _height + STSliderConstant.dotWidth / 2;
      }
    } else {
      return (_secondValue - _firstValue) * _height;
    }
  }

  double _getActiveChildWidth() {
    if (widget.rangeValues == null) {
      if (!_isHorizontal) {
        return STSliderConstant.crossLength;
      } else if (_firstValue == 0) {
        return 0;
      } else if (_firstValue == 1) {
        return _width;
      } else {
        return _firstValue * _width + STSliderConstant.dotWidth / 2;
      }
    } else {
      return (_secondValue - _firstValue) * _width;
    }
  }

  void updateDragAction(Offset positon, STSliderDotType dotType) {
    if (widget.disabled) return;
    if (dotType == STSliderDotType.start) {
      if (_isHorizontal) {
        if (positon.dx <= _firstOffset.dx) {
          _firstValue = 0;
        } else if (positon.dx >
            _firstOffset.dx + _width - STSliderConstant.dotWidth) {
          _firstValue = 1;
        } else {
          _firstValue = (positon.dx - _firstOffset.dx) / _width;
        }
      } else {
        if (positon.dy <= _firstOffset.dy) {
          _firstValue = 0;
        } else if (positon.dy >
            _firstOffset.dy + _height - STSliderConstant.dotWidth) {
          _firstValue = 1;
        } else {
          _firstValue = (positon.dy - _firstOffset.dy) / _height;
        }
      }
    } else {
      if (_isHorizontal) {
        if (positon.dx <= _firstOffset.dx) {
          _secondValue = 0;
        } else if (positon.dx >
            _firstOffset.dx + _width - STSliderConstant.dotWidth) {
          _secondValue = 1;
        } else {
          _secondValue = (positon.dx - _firstOffset.dx) / _width;
        }
      } else {
        if (positon.dy <= _firstOffset.dy) {
          _secondValue = 0;
        } else if (positon.dy >
            _firstOffset.dy + _height - STSliderConstant.dotWidth) {
          _secondValue = 1;
        } else {
          _secondValue = (positon.dy - _firstOffset.dy) / _height;
        }
      }
    }
    if (widget.onChanged != null) widget.onChanged(_firstValue);
    if (widget.rangeValues != null && widget.onChangedRange != null) {
      widget.onChangedRange(RangeValues(_firstValue, _secondValue));
    }
  }

  void updateTapAction(Offset positon) {
    if (widget.rangeValues != null || widget.disabled) return;
    if (_isHorizontal) {
      if (positon.dx <= STSliderConstant.dotWidth) {
        _firstValue = 0;
      } else if (positon.dx > _width - STSliderConstant.dotWidth) {
        _firstValue = 1;
      } else {
        _firstValue = (positon.dx - STSliderConstant.dotWidth) / _width;
      }
    } else {
      if (positon.dy <= STSliderConstant.dotWidth) {
        _firstValue = 0;
      } else if (positon.dy > _height - STSliderConstant.dotWidth) {
        _firstValue = 1;
      } else {
        _firstValue = (positon.dy - STSliderConstant.dotWidth) / _height;
      }
    }
    if (widget.onChanged != null) widget.onChanged(_firstValue);
  }

  String _calculateValue(double value) =>
      '${(value * widget.maxValue).round()}';
}
