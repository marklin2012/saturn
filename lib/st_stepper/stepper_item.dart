import 'package:flutter/material.dart';

enum StepperItemType {
  reduce,
  plus,
}

class STStepperItem extends StatefulWidget {
  final StepperItemType type;
  final ValueChanged<StepperItemType> onChanged;
  final Color borderColor;
  final bool disabled;
  final double iconSize;

  const STStepperItem({
    Key key,
    @required this.type,
    this.onChanged,
    this.borderColor,
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

  @override
  void initState() {
    super.initState();
    _borderRadius = const BorderRadius.horizontal(left: Radius.circular(2.0));
    _image = Icon(Icons.remove, size: widget.iconSize);
    if (widget.type == StepperItemType.plus) {
      _borderRadius =
          const BorderRadius.horizontal(right: Radius.circular(2.0));
      _image = Icon(Icons.add, size: widget.iconSize);
    }
    _borderColor = widget.borderColor ?? const Color(0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Opacity(
          opacity: widget.disabled ? 0.2 : 1.0,
          child: _image,
        ),
      ),
    );
  }
}
