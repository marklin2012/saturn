import 'package:flutter/material.dart';

class STHeader extends StatelessWidget {
  final Widget child;
  const STHeader({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: child,
    );
  }
}
