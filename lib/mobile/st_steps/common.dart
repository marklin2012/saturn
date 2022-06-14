import 'package:flutter/material.dart';

enum STStepsType { dot, number, icon, detail }

enum STStepsLineType { solid, dotted }

class STStepItem {
  const STStepItem({
    this.title,
    this.image,
    this.currentImage,
    this.number,
    this.info,
  });
  final String? title;
  final Widget? image;
  final Widget? currentImage;
  final int? number;
  final String? info;
}

class STRenderItem {
  const STRenderItem({this.offset, this.size});
  final Offset? offset;
  final Size? size;
}
