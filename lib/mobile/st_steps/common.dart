import 'package:flutter/material.dart';

enum STStepsType { dot, number, icon, detail }

class STStepItem {
  const STStepItem({this.title, this.iconData, this.number, this.info});
  final String title;
  final IconData iconData;
  final int number;
  final String info;
}

class STRenderItem {
  const STRenderItem({this.offset, this.size});
  final Offset offset;
  final Size size;
}
