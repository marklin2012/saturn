import 'package:flutter/material.dart';

enum STTagType {
  normal,
  success,
  failure,
  warning,
}

enum STTagCorner { normal, circle, rightHalf }
enum STTagTextSizeType { big, normal, small }

class STTagConstant {
  static const colorNormal = Color(0xFF095BF9);
  static const colorSuccess = Color(0xFF49C564);
  static const colorFailure = Color(0xFFFF4141);
  static const colorWarnning = Color(0xFFFFA927);
}
