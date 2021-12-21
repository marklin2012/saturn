import 'package:flutter/material.dart';

class STSelectMixItem {
  final IconData? icon;
  final String title;
  final bool disabled;
  final String key;

  const STSelectMixItem({
    this.icon,
    required this.title,
    disabled,
    key,
  })  : assert(title != null),
        key = key ?? title,
        disabled = disabled ?? false;
}
