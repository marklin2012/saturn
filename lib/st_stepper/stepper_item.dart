import 'package:flutter/material.dart';

enum StepperItemType {
  reduce,
  plus,
}

const _disableImageColor = Color(0xFFDFE2E7);

class STStepperItem extends StatefulWidget {
  final StepperItemType type;
  final ValueChanged<StepperItemType> onChanged;
  final double borderRadius;
  final Color borderColor;
  final bool disabled;
  final double iconSize;
  final Color iconColor;

  const STStepperItem({
    Key key,
    @required this.type,
    this.onChanged,
    this.borderColor = const Color(0xFFDFE2E7),
    this.iconColor = const Color(0xFF000000),
    this.borderRadius = 2.0,
    this.disabled = false,
    this.iconSize = 16.0,
  })  : assert(type != null),
        super(key: key);

  @override
  _STStepperItemState createState() => _STStepperItemState();
}

class _STStepperItemState extends State<STStepperItem> {
  BorderRadius _borderRadius;
  Icon _image;
  Color _borderColor;

  bool get _disabled => widget.disabled;

  void _init() {
    _borderColor = widget.borderColor;
    _borderRadius =
        BorderRadius.horizontal(left: Radius.circular(widget.borderRadius));
    _image = Icon(Icons.remove,
        size: widget.iconSize,
        color: _disabled ? _disableImageColor : widget.iconColor);
    if (widget.type == StepperItemType.plus) {
      _borderRadius =
          BorderRadius.horizontal(right: Radius.circular(widget.borderRadius));
      _image = Icon(Icons.add,
          size: widget.iconSize,
          color: _disabled ? _disableImageColor : widget.iconColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return GestureDetector(
      onTap: () => widget.disabled ? null : widget.onChanged(widget.type),
      child: Container(
        height: 24.0,
        width: 24.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: Border.all(color: _borderColor),
        ),
        child: _image,
      ),
    );
  }
}
