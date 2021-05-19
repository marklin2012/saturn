import 'package:flutter/material.dart';

class STActionSheetOption {
  String title;
  String message;
  String icon;
  bool isRadio;
  VoidCallback onTap;

  STActionSheetOption(
      {this.title, this.message, this.icon, this.isRadio = false, this.onTap});
}
