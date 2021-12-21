import 'package:flutter/material.dart';

class STBadgePositioned extends StatelessWidget {
  final STBadgePosition? position;

  final Widget? child;

  const STBadgePositioned({Key? key, this.position, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      final topRight = STBadgePosition.topEnd();
      return PositionedDirectional(
        top: topRight.top,
        end: topRight.end,
        child: child!,
      );
    }
    return PositionedDirectional(
      top: position!.top,
      end: position!.end,
      bottom: position!.bottom,
      start: position!.start,
      child: child!,
    );
  }
}

class STBadgePosition {
  final double? top;
  final double? end;
  final double? start;
  final double? bottom;

  const STBadgePosition({this.top, this.end, this.bottom, this.start});

  factory STBadgePosition.topStart({double? top, double? start}) {
    return STBadgePosition(top: top ?? -5, start: start ?? -10);
  }

  factory STBadgePosition.topEnd({double? top, double? end}) {
    return STBadgePosition(top: top ?? -8, end: end ?? -10);
  }

  factory STBadgePosition.bottomEnd({double? bottom, double? end}) {
    return STBadgePosition(bottom: bottom ?? -8, end: end ?? -10);
  }

  factory STBadgePosition.bottomStart({double? bottom, double? start}) {
    return STBadgePosition(bottom: bottom ?? -8, start: start ?? -10);
  }
}
