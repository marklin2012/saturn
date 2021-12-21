import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class STSwitch extends StatelessWidget {
  final bool value;
  final String? text;
  final bool disabled;
  final ValueChanged<bool> onChanged;
  final double space;
  final TextStyle textStyle;
  final Color? activeColor;
  final Color? trackColor;

  const STSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.text,
    this.disabled = false,
    this.space = 12.0,
    this.textStyle = const TextStyle(fontSize: 17, color: Color(0xFF000000)),
    this.activeColor,
    this.trackColor,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.2 : 1.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoSwitch(
            value: _getValue(),
            onChanged: disabled ? null : onChanged,
            activeColor: activeColor,
            trackColor: trackColor,
          ),
          if (text != null) SizedBox(width: space),
          if (text != null) Text(text!, style: textStyle),
        ],
      ),
    );
  }

  bool _getValue() {
    if (disabled) return false;
    return value;
  }
}
