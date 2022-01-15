import 'package:flutter/material.dart';

class STSider extends StatelessWidget {
  final Widget child;
  final double width;
  const STSider({Key? key, required this.child, this.width = 160.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: child,
    );
  }
}
