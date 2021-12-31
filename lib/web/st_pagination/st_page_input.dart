import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';

const _disableBGColor = Color(0xFFF5F5F5);
const _disbaleBorderColor = Color(0xFFD9D9D9);

class STpageInput extends StatefulWidget {
  const STpageInput({
    Key? key,
    this.width = 52.0,
    this.height = 32.0,
    this.disabled = false,
    this.page,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    this.onChanged,
  }) : super(key: key);

  final double width;
  final double height;
  final bool disabled;
  final String? page;
  final TextStyle textStyle;
  final Function(String)? onChanged;

  @override
  _STpageInputState createState() => _STpageInputState();
}

class _STpageInputState extends State<STpageInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  Color _borderColor = STColor.secRankGrey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          // 失去焦点
          _borderColor = STColor.secRankGrey;
          setState(() {});
          if (_controller.text.isNotEmpty && widget.onChanged != null) {
            widget.onChanged!(_controller.text);
          }
        } else {
          _borderColor = STColor.firRankBlue;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _disabled = widget.disabled;
    if (widget.page != null) {
      _controller.text = widget.page!;
    }
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _disabled ? _disableBGColor : Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        border:
            Border.all(color: _disabled ? _disbaleBorderColor : _borderColor),
      ),
      child: TextField(
        enabled: !_disabled,
        controller: _controller,
        focusNode: _focusNode,
        style: widget.textStyle,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorHeight: widget.height - 2 * 5,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 5.0,
          ),
        ),
      ),
    );
  }
}
