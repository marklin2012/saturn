import 'package:flutter/material.dart';

class STDialogOption {
  String title;
  String message;
  String icon;
  bool isRadio;
  bool isAligmentCenter;
  bool hasSeparateLine;
  VoidCallback onTap;

  STDialogOption(
      {this.title,
      this.message,
      this.icon,
      this.isRadio = false,
      this.isAligmentCenter = false,
      this.hasSeparateLine = false,
      this.onTap});
}
