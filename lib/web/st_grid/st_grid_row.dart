import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class STGridRow extends StatelessWidget {
  final double? gutter;
  final List<STGridCol> children;
  const STGridRow({Key? key, required this.children, this.gutter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> res = [];
    if (gutter != null) {
      int count = 0;
      for (final STGridCol col in children) {
        res.add(col);
        count++;
        if (count < children.length) {
          res.add(
            SizedBox(
              width: gutter,
            ),
          );
        }
      }
    } else {
      res = children;
    }
    return Flex(
      direction: Axis.horizontal,
      children: res,
    );
  }
}
