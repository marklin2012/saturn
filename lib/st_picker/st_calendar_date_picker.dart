import 'package:flutter/material.dart';
import 'package:saturn/st_icons/st_icons.dart';
import 'package:saturn/st_select/select_show_dialog.dart';

class STCalendarDatePicker extends StatefulWidget {
  const STCalendarDatePicker(
      {Key key,
      this.isRange = false,
      this.offsetVertical,
      this.marign,
      this.onChanged})
      : super(key: key);

  final bool isRange; //是否可以选择范围值
  final double offsetVertical; //垂直方向偏移量
  final ValueChanged<DateTime> onChanged; //选择后的日期回调
  final EdgeInsets marign; //与外部的间隙

  @override
  _STCalendarDatePickerState createState() => _STCalendarDatePickerState();
}

const _stCalendarInputHeight = 48.0;
const _defaultPlaceHolder = '请选择日期';
const _defaultStartHolder = '开始日期';
const _defaultEndHolder = '结束日期';

const _defaultMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _defaultPadding = EdgeInsets.only(left: 14.0);
const _defaultVerticalOffset = 8.0;
const _defaultCalenderHeight = 322.0;

const Color _defaultBackgroundColor = Color(0xFFFAFCFF);
const Color _defaultBorderColor = Color(0xFFC4C5C7);
const Color _borderHighlightedColor = Color(0xFF095BF9);

class _STCalendarDatePickerState extends State<STCalendarDatePicker> {
  final GlobalKey _touchCalKey =
      GlobalKey(debugLabel: '_touchCalKey'); //触发日历的Key
  Offset _touchCalPoints;
  double _offsetVertical;
  EdgeInsets _margin;
  TextEditingController _startController;
  TextEditingController _endController;
  String _startHintText;
  String _endHintText;
  FocusNode _startFocusNode;
  FocusNode _endFocusNode;
  Color _borderColor;

  @override
  void initState() {
    super.initState();
    _margin = widget.marign ?? _defaultMargin;
    _offsetVertical = widget.offsetVertical ?? _defaultVerticalOffset;
    _startController = TextEditingController();
    _startHintText = _defaultPlaceHolder;
    _startFocusNode = FocusNode(debugLabel: 'StartFN');
    _borderColor = _defaultBorderColor;
    _startFocusNode.addListener(() {
      if (!_startFocusNode.hasFocus) {
        // 失去焦点
        _borderColor = _defaultBorderColor;
        setState(() {});
      } else {
        _borderColor = _borderHighlightedColor;
        setState(() {});
        // showDialog(
        //   barrierColor: Colors.transparent,
        //   context: context,
        //   builder: (context) {
        //     return ShowSelectDialog(
        //       offset: Offset(
        //           _touchCalPoints.dx + _margin.left,
        //           _touchCalPoints.dy +
        //               _offsetVertical +
        //               _stCalendarInputHeight),
        //       height: _defaultCalenderHeight,
        //       menu: Container(
        //         color: Colors.blue,
        //       ),
        //     );
        //   },
        // ).then((value) {
        //   FocusScope.of(context).requestFocus(_startFocusNode);
        // });
      }
    });

    if (widget.isRange) {
      _startHintText = _defaultStartHolder;
      _endController = TextEditingController();
      _endHintText = _defaultEndHolder;
      _endFocusNode = FocusNode(debugLabel: 'EndFN');
      _endFocusNode.addListener(() {
        if (!_endFocusNode.hasFocus) {
          // 失去焦点
          _borderColor = _defaultBorderColor;
          setState(() {});
        } else {
          _borderColor = _borderHighlightedColor;
          setState(() {});
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final RenderBox renderBox =
          _touchCalKey.currentContext.findRenderObject();
      _touchCalPoints = renderBox.localToGlobal(Offset.zero);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    double _textFiledWidth =
        _width - _margin.left - _margin.right - _defaultPadding.left - 4;
    if (widget.isRange) {
      _textFiledWidth -= _defaultMargin.left + _defaultMargin.right * 2;
      _textFiledWidth /= 2;
    }
    return Container(
      key: _touchCalKey,
      margin: _margin,
      padding: _defaultPadding,
      height: _stCalendarInputHeight,
      decoration: BoxDecoration(
        color: _defaultBackgroundColor,
        border: Border.all(color: _borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: _textFiledWidth,
            child: TextField(
              controller: _startController,
              focusNode: _startFocusNode,
              decoration: InputDecoration(
                hintText: _startHintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                hintMaxLines: 1,
                suffixIcon: widget.isRange
                    ? null
                    : const Icon(STIcons.commonly_calendar,
                        size: 20, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (widget.isRange)
            const Padding(
                padding: _defaultMargin,
                child: Icon(STIcons.direction_swapright,
                    size: 16, color: Colors.grey)),
          if (widget.isRange)
            SizedBox(
              width: _textFiledWidth,
              child: TextField(
                controller: _endController,
                focusNode: _endFocusNode,
                decoration: InputDecoration(
                  hintText: _endHintText,
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  hintMaxLines: 1,
                  suffixIcon: const Icon(STIcons.commonly_calendar,
                      size: 20, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
