import 'package:flutter/material.dart';

import 'package:saturn/st_slider/painter_background_tip.dart';
import 'package:saturn/st_slider/num_utils.dart';

enum STSliderDotType {
  start,
  end,
}

class STSliderConstant {
  static const horizontalWidth = 303.0;
  static const verticalHeight = 200.0;
  static const dotWidth = 18.0;
  static const crossLength = 2.0;
  static const borderRadius = BorderRadius.all(Radius.circular(2.0));
  static const showTipSize = 40.0;
  static const showTipVerticalOffset = 4.0;
}

class STSlider extends StatefulWidget {
  final Axis axis; // 方向
  final double size; // 当Axis为横轴时代表宽度，为竖轴是代表高度
  final bool showTip; // 显示提示
  final TextStyle tipTextStyle; // 提示字体的样式
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
    this.showTip = true,
    this.tipTextStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.value = 0,
    this.rangeValues,
    this.textStyle = const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
    this.onChanged,
    this.onChangedRange,
    this.size,
  }) : super(key: key);

  @override
  _STSliderState createState() => _STSliderState();
}

class _STSliderState extends State<STSlider> {
  Widget _firstDot;
  Widget _secondDot;
  double _firstValue;
  double _secondValue;
  final GlobalKey _firstKey = GlobalKey(debugLabel: 'firstDot'); // 控件的key
  Offset _firstOffset; // 第一个原点位置

  bool _firHighlighted = false;
  bool _secHighlighted = false;

  double get _height {
    if (_isHorizontal) {
      return STSliderConstant.crossLength;
    } else {
      return widget.size ?? STSliderConstant.horizontalWidth;
    }
  }

  double get _width {
    if (!_isHorizontal) {
      return STSliderConstant.crossLength;
    } else {
      return widget.size ?? STSliderConstant.verticalHeight;
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
    _firstOffset = renderBox.localToGlobal(Offset.zero);
    if (widget.rangeValues != null && widget.rangeValues.start != 0) {
      final temp = _firstOffset;
      if (_isHorizontal) {
        _firstOffset =
            Offset(temp.dx - widget.rangeValues.start * _width, temp.dy);
      } else {
        _firstOffset =
            Offset(temp.dx, temp.dy - widget.rangeValues.start * _height);
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
      clipBehavior: Clip.none,
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
          left: _getDotPostionLeft(_firstValue),
          top: _getDotPositonTop(_firstValue),
          child: _firstDot,
        ),
        if (widget.showTip && _firHighlighted)
          Positioned(
            left: _getTipPostionLeft(_firstValue),
            top: _getTipPositonTop(_firstValue),
            child: SliderTipPaint(
              size: STSliderConstant.showTipSize,
              child: Text(
                _calculateValue(_firstValue),
                style: widget.tipTextStyle,
              ),
            ),
          ),
        if (_secondDot != null)
          Positioned(
            left: _getDotPostionLeft(_secondValue),
            top: _getDotPositonTop(_secondValue),
            child: _secondDot,
          ),
        if (widget.showTip && _secHighlighted && widget.rangeValues != null)
          Positioned(
            left: _getTipPostionLeft(_secondValue),
            top: _getTipPositonTop(_secondValue),
            child: SliderTipPaint(
              size: STSliderConstant.showTipSize,
              child: Text(
                _calculateValue(_secondValue),
                style: widget.tipTextStyle,
              ),
            ),
          ),
      ],
    );
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
      if (_isHorizontal) return STSliderConstant.crossLength;
      return _firstValue * _height;
    } else {
      if (_isHorizontal) return STSliderConstant.crossLength;
      return (_secondValue - _firstValue) * _height;
    }
  }

  double _getActiveChildWidth() {
    if (widget.rangeValues == null) {
      if (!_isHorizontal) return STSliderConstant.crossLength;
      return _firstValue * _width;
    } else {
      if (!_isHorizontal) return STSliderConstant.crossLength;
      return (_secondValue - _firstValue) * _width;
    }
  }

  double _getActiveLeft() {
    if (widget.rangeValues == null) {
      return _isHorizontal ? 0 : STSliderConstant.dotWidth / 2;
    } else {
      if (!_isHorizontal) return STSliderConstant.dotWidth / 2;
      return _getDotPostionLeft(_firstValue);
    }
  }

  double _getActiveTop() {
    if (widget.rangeValues == null) {
      return _isHorizontal ? STSliderConstant.dotWidth / 2 : 0;
    } else {
      if (_isHorizontal) return STSliderConstant.dotWidth / 2;
      return _getDotPositonTop(_firstValue);
    }
  }

  double _getDotPostionLeft(double value) {
    if (!_isHorizontal) return 0;
    return value * _width - STSliderConstant.dotWidth / 2;
  }

  double _getDotPositonTop(double value) {
    if (_isHorizontal) return 0;
    return value * _height - STSliderConstant.dotWidth / 2;
  }

  double _getTipPostionLeft(double value) {
    return _getDotPostionLeft(value) -
        (STSliderConstant.showTipSize - STSliderConstant.dotWidth) / 2;
  }

  double _getTipPositonTop(double value) {
    return _getDotPositonTop(value) -
        STSliderConstant.showTipSize -
        STSliderConstant.showTipVerticalOffset;
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
        onDragStarted: () {
          if (dotType == STSliderDotType.start) {
            _firHighlighted = true;
          } else {
            _secHighlighted = true;
          }
          setState(() {});
        },
        onDragEnd: (details) {
          // debugPrint('${details.offset}-$_firstOffset');
          updateDragAction(details.offset, dotType);
        },
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
      );
    }
  }

  void updateDragAction(Offset positon, STSliderDotType dotType) {
    if (widget.disabled) return;
    if (dotType == STSliderDotType.start) {
      if (_isHorizontal) {
        if (positon.dx <= _firstOffset.dx) {
          _firstValue = 0;
        } else if (positon.dx >= _firstOffset.dx + _width) {
          _firstValue = 1;
        } else {
          _firstValue = (positon.dx - _firstOffset.dx) / _width;
        }
      } else {
        if (positon.dy <= _firstOffset.dy) {
          _firstValue = 0;
        } else if (positon.dy >= _firstOffset.dy + _height) {
          _firstValue = 1;
        } else {
          _firstValue = (positon.dy - _firstOffset.dy) / _height;
        }
      }
    } else {
      if (_isHorizontal) {
        if (positon.dx <= _firstOffset.dx) {
          _secondValue = 0;
        } else if (positon.dx >= _firstOffset.dx + _width) {
          _secondValue = 1;
        } else {
          _secondValue = (positon.dx - _firstOffset.dx) / _width;
        }
      } else {
        if (positon.dy <= _firstOffset.dy) {
          _secondValue = 0;
        } else if (positon.dy >= _firstOffset.dy + _height) {
          _secondValue = 1;
        } else {
          _secondValue = (positon.dy - _firstOffset.dy) / _height;
        }
      }
    }

    if (widget.onChanged != null) widget.onChanged(_firstValue);
    if (widget.rangeValues != null && widget.onChangedRange != null) {
      // 确保第二个值大于第一个值
      if (_firstValue > _secondValue) {
        final temp = _firstValue;
        _firstValue = _secondValue;
        _secondValue = temp;
      }
      widget.onChangedRange(RangeValues(_firstValue, _secondValue));
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (dotType == STSliderDotType.start) {
        _firHighlighted = false;
      } else {
        _secHighlighted = false;
      }
      setState(() {});
    });
  }

  void updateTapAction(Offset positon) {
    if (widget.rangeValues != null || widget.disabled) return;
    if (_isHorizontal) {
      _firstValue = positon.dx / _width;
    } else {
      _firstValue = positon.dy / _height;
    }
    if (widget.onChanged != null) widget.onChanged(_firstValue);
  }

  String _calculateValue(double value) {
    if (widget.maxValue == null) {
      return NumUtils().formartNum(value, 2);
    } else {
      return NumUtils().formartNum(value * widget.maxValue, 2);
    }
  }
}
