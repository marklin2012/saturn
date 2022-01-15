import 'package:flutter/material.dart';

class STGridCol extends StatelessWidget {
  final int span;
  final int? offset;
  final String title;
  final Color backgroundColor;
  const STGridCol({
    Key? key,
    this.span = 24,
    this.offset,
    this.title = "Col-24",
    this.backgroundColor = const Color(0xFF4585FF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int flex = span;
    if (offset != null) {
      flex = span + offset!;
    }

    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (offset != null)
            Expanded(
              flex: offset!,
              child: Container(),
            ),
          if (span != 0)
            Expanded(
              flex: span,
              child: Container(
                height: 50,
                color: backgroundColor,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
