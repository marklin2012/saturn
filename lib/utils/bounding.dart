import 'package:flutter/material.dart';

Size boundingTextSize(BuildContext context, String? text, TextStyle style,
    {int maxLines = 2 ^ 31, double maxWidth = double.infinity,}) {
  if (text == null || text.isEmpty) {
    return Size.zero;
  }
  final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      locale: Localizations.maybeLocaleOf(context),
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,)
    ..layout(maxWidth: maxWidth);
  return textPainter.size;
}
