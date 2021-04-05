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

  const STStepperItem({
    Key key,
    @required this.type,
    this.onChanged,
    this.borderColor,
    this.disabled = false,
  })  : assert(type != null),
        super(key: key);

  @override
  _STStepperItemState createState() => _STStepperItemState();
}

class _STStepperItemState extends State<STStepperItem> {
  static const reduceIconPath = 'images/stepper/reduce.png';
  static const plusIconPath = 'images/stepper/plus.png';
  static const iconPackage = 'saturn';
  BorderRadius _borderRadius;
  Image _image;
  Color _borderColor;

  @override
  void initState() {
    super.initState();
    _borderRadius = const BorderRadius.horizontal(left: Radius.circular(2.0));
    _image = Image.asset(
      reduceIconPath,
      package: iconPackage,
      width: 8,
      height: 1,
    );
    if (widget.type == StepperItemType.plus) {
      _borderRadius =
          const BorderRadius.horizontal(right: Radius.circular(2.0));
      _image = Image.asset(
        plusIconPath,
        package: iconPackage,
        width: 8,
        height: 8,
      );
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
