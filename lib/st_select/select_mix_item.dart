import 'package:flutter/material.dart';

class STSelectMixItem {
  final IconData icon;
  final String title;
  final bool disabled;
  final String key;

  const STSelectMixItem({
    icon,
    title,
    disabled,
    key,
  })  : key = key ?? title,
        title = title ?? '混合型',
        disabled = disabled ?? false,
        // ignore: prefer_initializing_formals
        icon = icon;
}
